import 'package:meta/meta.dart';

import '../../../status/data/models/models.dart';

@immutable
abstract class HomeState {
  bool loading = true;

  HomeState([List props = const <dynamic>[]]) : super();
}

class PageLoading extends HomeState {}

class PageLoaded extends HomeState {
  final List<bool> users;

  PageLoaded({@required this.users})
      : assert(users != null),
        super([users]);
}

class HomeError extends HomeState {}

class InitialHomeState extends HomeState {}

class LocaleActive extends HomeState {
  static final route = "/local";
  final String title = "Locale";
  final int itemIndex = 11;
}

class LocaleChartsActive extends HomeState {
  static final route = "/charts";
  final String title = "Charts";
  final int itemIndex = 14;

  final Status selectedStatus;
  final List<Status> statuses;

  LocaleChartsActive({
    @required this.selectedStatus,
    @required this.statuses,
  })  : assert(selectedStatus != null),
        assert(statuses != null);
}

class StatusActive extends HomeState {
  static final route = "/status";
  final String title = "Status";
  final int itemIndex = 20;
}

class GlobalChartsActive extends HomeState {
  static final route = "/global_charts";
  final String title = "Global Charts";
  final int itemIndex = 21;

  final List<Status> intl;

  GlobalChartsActive({@required this.intl}) : assert(intl != null);
}

class StatusNewsActive extends HomeState {
  static final route = "/status_news";
  final String title = "Status";
  final int itemIndex = 21;
}

class InfoActive extends HomeState {
  static final route = "/info";
  final String title = "Info";
  final int itemIndex = 30;
}
