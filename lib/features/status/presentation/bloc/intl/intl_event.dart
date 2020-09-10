import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/models.dart';

abstract class IntlEvent extends Equatable {
  const IntlEvent();

  @override
  List<Object> get props => [];
}

class LoadIntl extends IntlEvent {}

class LoadGlobalDetails extends IntlEvent {
  final List<Status> intl;

  LoadGlobalDetails({@required this.intl}) : assert(intl != null);

  @override
  List<Object> get props => [intl];
}

class LoadGlobalIntlCharts extends IntlEvent {}

class IntlUpdated extends IntlEvent {
  final List<Status> intl;

  IntlUpdated(this.intl);

  @override
  List<Object> get props => [intl];
}

class UpdateIntl extends IntlEvent {
  final List<Status> intl;

  UpdateIntl({this.intl});

  @override
  List<Object> get props => [intl];

  @override
  String toString() => 'UpdateIntl { todos: $intl }';
}

class LoadGlobalIntlHistories extends IntlEvent {
  @override
  List<Object> get props => [];
}

class UpdateGlobalIntlHistories extends IntlEvent {
  final List<Status> intl;

  UpdateGlobalIntlHistories({@required this.intl}) : assert(intl != null);

  @override
  List<Object> get props => [intl];
}

class UpdateGlobalIntlCharts extends IntlEvent {
  final List<Status> intl;

  UpdateGlobalIntlCharts({
    @required this.intl,
  }) : assert(intl != null);

  @override
  List<Object> get props => [intl];
}
