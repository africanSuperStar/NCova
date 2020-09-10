import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:notifications_enabled/notifications_enabled.dart';
import 'package:quiver/core.dart';
import 'package:webfeed/webfeed.dart';

import '../../../../../messaging_service.dart';
import '../../../../../navigator_service.dart';
import '../../../../locale/presentation/pages/locale_screen.dart';
import '../../../data/models/models.dart';
import '../../../domain/repository/status_repository.dart';
import 'bloc.dart';

class StatusBloc extends Bloc<StatusesEvent, StatusesState> {
  final BuildContext _context;
  final StatusRepository _statusRepository;
  NavigatorService _service;

  StreamSubscription _statusSubscription;

  StatusBloc({@required StatusRepository statusRepository, @required BuildContext context})
      : assert(statusRepository != null),
        assert(context != null),
        _statusRepository = statusRepository,
        _context = context;

  @override
  StatusesState get initialState => StatusesLoading();

  @override
  Stream<StatusesState> mapEventToState(StatusesEvent event) async* {
    _service = NavigatorProvider.of(_context).service;

    if (event is LoadStatuses) {
      yield* _mapLoadStatusToState();
    } else if (event is LoadRssFeed) {
      yield* _mapRssFeedToState();
    } else if (event is UpdateStatuses) {
      yield* _mapStatusUpdateToState(event);
    } else if (event is LoadStatusHistories) {
      yield* _mapLoadStatusHistoryToState(event.selectedStatus);
    } else if (event is LoadStatusCharts) {
      yield* _mapLoadStatusChartsToState(event.selectedStatus);
    } else if (event is UpdateRssFeed) {
      // Avoid Glitching Page on Locale Page.
      if (_service.currentPage is! LocaleScreen) {
        yield RssFeedLoaded(rssFeed: event.rssFeed);
      }
    } else if (event is UpdateStatusHistories) {
      yield StatusHistoriesLoaded(
        selectedStatus: event.selectedStatus,
        statuses: event.statuses,
      );
    } else if (event is UpdateStatusCharts) {
      yield StatusChartsLoaded(
        selectedStatus: event.selectedStatus,
        statuses: event.statuses,
      );
    } else if (event is InsertFavorite) {
      yield* _mapInsertFavoriteToState(event);
    } else if (event is RemoveFavorite) {
      yield* _mapRemoveFavoriteToState(event);
    } else {
      yield* _mapLoadStatusToState();
    }
  }

  Stream<StatusesState> _mapRssFeedToState() async* {
    _statusSubscription?.cancel();
    _statusSubscription = _statusRepository.rssFeed().listen(
          (body) => add(
            UpdateRssFeed(
              rssFeed: RssFeed.parse(
                body,
              ),
            ),
          ),
        );
  }

  Stream<StatusesState> _mapLoadStatusToState() async* {
    _statusSubscription?.cancel();
    _statusSubscription = _statusRepository.statuses().listen(
          (statuses) => add(
            UpdateStatuses(statuses: statuses),
          ),
        );
  }

  Stream<StatusesState> _mapLoadStatusHistoryToState(Status status) async* {
    _statusSubscription?.cancel();
    _statusSubscription = _statusRepository.statusHistory(status: status).listen(
          (statuses) => add(
            UpdateStatusHistories(status, statuses),
          ),
        );
  }

  Stream<StatusesState> _mapLoadStatusChartsToState(Status status) async* {
    _statusSubscription?.cancel();
    _statusSubscription = _statusRepository.statuses().listen(
          (statuses) => add(
            UpdateStatusCharts(selectedStatus: status, statuses: statuses),
          ),
        );
  }

  Stream<StatusesState> _mapInsertFavoriteToState(InsertFavorite event) async* {
    final FirebaseMessaging _messanger = MessagingProvider.messanger;
    final MessagingService _messangerService = MessagingProvider.service;

    final Optional<bool> notificationsEnabled = await NotificationsEnabled.notificationsEnabled;

    if (Platform.isIOS && (notificationsEnabled.isNotPresent == true || notificationsEnabled.value == false)) {
      _messanger.onIosSettingsRegistered.listen((data) {
        _messangerService.saveDeviceToken(_context);
      });

      _messangerService.requestIOSPermissions();

      // Show on_first_favorite popup.
      MessagingProvider.analytics.logEvent(name: "on_first_favorite");
    } else {
      _messangerService.saveDeviceToken(_context);
      _messanger.subscribeToTopic('statusBNO');
    }

    final favorites = await _statusRepository.loadFavorites();

    favorites.removeWhere((favorite) => favorite.name == event.selectedFavorite.name);

    if (event.selectedFavorite.favorited == true) {
      favorites.add(event.selectedFavorite);
    }

    _saveFavorites(favorites);
  }

  Stream<StatusesState> _mapRemoveFavoriteToState(RemoveFavorite event) async* {
    final favorites = await _statusRepository.loadFavorites();

    favorites.removeWhere((favorite) => favorite.name == event.selectedFavorite.name);

    _saveFavorites(favorites);
  }

  Stream<StatusesLoaded> _mapStatusUpdateToState(UpdateStatuses event) async* {
    final favorites = await _statusRepository.loadFavorites();

    event.statuses.removeWhere((status) => status == null);

    List<Status> newFavorites = [];

    for (final favorite in favorites) {
      final firstMatch = event.statuses.firstWhere((status) => status.name == favorite.name, orElse: null);

      if (firstMatch != null) {
        final builder = StatusBuilder()
          ..id = firstMatch.id
          ..a3 = firstMatch.a3
          ..checkedAt = firstMatch.checkedAt
          ..createdAt = firstMatch.createdAt
          ..totals = firstMatch.totals
          ..name = firstMatch.name
          ..favorited = true;
        newFavorites.add(builder.build());
      }

      event.statuses.removeWhere((status) => status.name == favorite.name);
    }

    _saveFavorites(newFavorites);

    if (newFavorites.isNotEmpty) {
      yield StatusesLoaded(
        statuses: newFavorites + event.statuses,
      );
    } else {
      yield StatusesLoaded(
        statuses: event.statuses,
      );
    }
  }

  @override
  Future<void> close() {
    _statusSubscription?.cancel();
    return super.close();
  }

  _saveFavorites(List<Status> favorites) async {
    _statusRepository.saveFavorites(favorites);
  }
}
