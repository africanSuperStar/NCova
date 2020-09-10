import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../data/models/models.dart';

abstract class IntlState extends Equatable {
  final List<Status> intl;

  IntlState({@required this.intl});

  @override
  List<Object> get props => [intl];

  void cleanIntl() {
    intl.removeWhere((val) => val == null);
  }
}

class IntlLoading extends IntlState {}

class IntlLoaded extends IntlState {
  IntlLoaded({@required List<Status> intl}) : super(intl: intl);

  @override
  List<Object> get props => [intl];

  @override
  String toString() => 'IntlLoaded { intl: $intl }';
}

class IntlNotLoaded extends IntlState {}

class GlobalIntlHistoriesLoaded extends IntlState {
  GlobalIntlHistoriesLoaded({@required List<Status> intl}) : super(intl: intl);

  @override
  List<Object> get props => [intl];

  @override
  String toString() => 'GlobalIntlHistoriesLoaded { status: $intl }';
}

class GlobalIntlDetailsLoaded extends IntlState {
  GlobalIntlDetailsLoaded({@required List<Status> intl}) : super(intl: intl);

  @override
  List<Object> get props => [intl];

  @override
  String toString() => 'GlobalIntlDetailsLoaded { status: $intl }';
}

class GlobalIntlChartsLoaded extends IntlState {
  GlobalIntlChartsLoaded({@required List<Status> intl}) : super(intl: intl);

  @override
  List<Object> get props => [intl];

  @override
  String toString() => 'GlobalIntlChartsLoaded { status: $intl }';
}
