import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is NavigateToLocale) {
      yield LocaleActive();
    } else if (event is NavigateToLocaleCharts) {
      yield LocaleChartsActive(
        selectedStatus: event.selectedStatus,
        statuses: event.statuses,
      );
    } else if (event is NavigateToStatus) {
      yield StatusActive();
    } else if (event is NavigateToStatusNews) {
      yield StatusNewsActive();
    } else if (event is NavigateToInfo) {
      yield InfoActive();
    } else if (event is NavigateToGlobalCharts) {
      yield GlobalChartsActive(intl: event.intl);
    } else {
      yield StatusActive();
    }
  }
}
