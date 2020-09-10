import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

import '../../../data/models/models.dart';

abstract class StatusesState extends Equatable {
  final bool permissionsAccepted;

  const StatusesState([this.permissionsAccepted]);

  @override
  List<Object> get props => [];
}

class StatusesLoading extends StatusesState {
  final Status status;

  const StatusesLoading([this.status]);

  @override
  List<Object> get props => [status];
}

class StatusHistoryLoading extends StatusesState {
  final Status status;

  const StatusHistoryLoading([this.status]);

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'StatusHistoryLoading { status: $status }';
}

class FavoritesLoading extends StatusesState {}

class StatusesLoaded extends StatusesState {
  final List<Status> statuses;

  const StatusesLoaded({this.statuses});

  @override
  List<Object> get props => [statuses];

  @override
  String toString() => 'StatusesLoaded { status: $statuses }';

  void cleanStatuses() {
    statuses.removeWhere((status) => status == null);
  }
}

class StatusHistoriesLoaded extends StatusesState {
  final Status selectedStatus;
  final List<Status> statuses;

  const StatusHistoriesLoaded({
    @required this.selectedStatus,
    @required this.statuses,
  })  : assert(selectedStatus != null),
        assert(statuses != null);

  @override
  List<Object> get props => [statuses];

  @override
  String toString() => 'StatusHistoriesLoaded { status: $statuses }';

  void cleanStatuses() {
    statuses.removeWhere((val) => val == null);
  }
}

class StatusChartsLoaded extends StatusesState {
  final Status selectedStatus;
  final List<Status> statuses;

  const StatusChartsLoaded({
    @required this.selectedStatus,
    @required this.statuses,
  })  : assert(selectedStatus != null),
        assert(statuses != null);

  @override
  List<Object> get props => [statuses];

  @override
  String toString() => 'StatusChartsLoaded { status: $statuses }';

  void cleanStatuses() {
    statuses.removeWhere((val) => val == null);
  }
}

class FavoritesNotLoaded extends StatusesState {}

class RssFeedLoaded extends StatusesState {
  final RssFeed rssFeed;

  const RssFeedLoaded({this.rssFeed});

  @override
  List<Object> get props => [rssFeed];

  @override
  String toString() => 'RssFeedLoaded { rssFeed: $rssFeed }';
}
