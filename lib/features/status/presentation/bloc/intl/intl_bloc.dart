import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/repository/status_repository.dart';
import 'bloc.dart';

class IntlBloc extends Bloc<IntlEvent, IntlState> {
  final StatusRepository _intlRepository;
  StreamSubscription _intlSubscription;

  IntlBloc({@required StatusRepository intlRepository})
      : assert(intlRepository != null),
        _intlRepository = intlRepository;

  @override
  IntlState get initialState => IntlLoading();

  @override
  Stream<IntlState> mapEventToState(IntlEvent event) async* {
    if (event is LoadIntl) {
      yield* _mapLoadIntlToState();
    } else if (event is IntlUpdated) {
      yield* _mapIntlUpdateToState(event);
    } else if (event is LoadGlobalIntlHistories) {
      yield* _mapLoadIntlHistoryToState();
    } else if (event is LoadGlobalIntlCharts) {
      yield* _mapLoadIntlChartsToState();
    } else if (event is LoadGlobalDetails) {
      yield GlobalIntlDetailsLoaded(intl: event.intl);
    } else if (event is UpdateGlobalIntlHistories) {
      yield GlobalIntlHistoriesLoaded(
        intl: event.intl,
      );
    } else if (event is UpdateGlobalIntlCharts) {
      yield GlobalIntlChartsLoaded(
        intl: event.intl,
      );
    }
  }

  Stream<IntlState> _mapLoadIntlToState() async* {
    _intlSubscription?.cancel();
    _intlSubscription = _intlRepository.intl().listen(
          (intl) => add(
            IntlUpdated(intl),
          ),
        );
  }

  Stream<IntlState> _mapIntlUpdateToState(IntlUpdated event) async* {
    yield IntlLoaded(intl: event.intl);
  }

  Stream<IntlState> _mapLoadIntlHistoryToState() async* {
    _intlSubscription?.cancel();
    _intlSubscription = _intlRepository.intlHistory().listen(
          (intl) => add(
            UpdateGlobalIntlHistories(intl: intl),
          ),
        );
  }

  Stream<IntlState> _mapLoadIntlChartsToState() async* {
    _intlSubscription?.cancel();
    _intlSubscription = _intlRepository.intlHistory().listen(
          (intl) => add(
            UpdateGlobalIntlCharts(intl: intl),
          ),
        );
  }

  @override
  Future<void> close() {
    _intlSubscription?.cancel();
    return super.close();
  }
}
