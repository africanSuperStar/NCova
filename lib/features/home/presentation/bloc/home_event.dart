import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../status/data/models/models.dart';

@immutable
abstract class HomeEvent extends Equatable {
  HomeEvent([List props = const <dynamic>[]]) : super();
}

class NavigateToLocale extends HomeEvent {
  @override
  String toString() => 'NavigateToLocale';

  @override
  List<Object> get props => [];
}

class NavigateToLocaleCharts extends HomeEvent {
  final Status selectedStatus;
  final List<Status> statuses;

  NavigateToLocaleCharts({@required this.selectedStatus, @required this.statuses})
      : assert(selectedStatus != null),
        assert(statuses != null);

  @override
  String toString() => 'NavigateToCharts';

  @override
  List<Object> get props => [];
}

class NavigateToGlobalCharts extends HomeEvent {
  final List<Status> intl;

  NavigateToGlobalCharts({@required this.intl}) : assert(intl != null);

  @override
  String toString() => 'NavigateToGlobalCharts';

  @override
  List<Object> get props => [intl];
}

class NavigateToStatus extends HomeEvent {
  @override
  String toString() => 'NavigateToStatus';

  @override
  List<Object> get props => [];
}

class NavigateToStatusNews extends HomeEvent {
  @override
  String toString() => 'NavigateToStatusNews';

  @override
  List<Object> get props => [];
}

class NavigateToInfo extends HomeEvent {
  @override
  String toString() => 'NavigateToInfo';

  @override
  List<Object> get props => [];
}
