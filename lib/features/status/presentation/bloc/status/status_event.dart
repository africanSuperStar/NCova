import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

import '../../../data/models/models.dart';

abstract class StatusesEvent extends Equatable {
  const StatusesEvent();

  @override
  List<Object> get props => [];
}

class LoadStatuses extends StatusesEvent {}

class LoadRssFeed extends StatusesEvent {}

class LoadStatusHistories extends StatusesEvent {
  final Status selectedStatus;

  const LoadStatusHistories({@required this.selectedStatus}) : assert(selectedStatus != null);

  @override
  List<Object> get props => [selectedStatus];
}

class LoadStatusCharts extends StatusesEvent {
  final Status selectedStatus;

  const LoadStatusCharts({@required this.selectedStatus}) : assert(selectedStatus != null);

  @override
  List<Object> get props => [selectedStatus];
}

class ToggleAll extends StatusesEvent {}

class InsertFavorite extends StatusesEvent {
  final Status selectedFavorite;

  const InsertFavorite(this.selectedFavorite);

  @override
  List<Object> get props => [selectedFavorite];
}

class RemoveFavorite extends StatusesEvent {
  final Status selectedFavorite;

  const RemoveFavorite(this.selectedFavorite);

  @override
  List<Object> get props => [selectedFavorite];
}

class UpdateStatuses extends StatusesEvent {
  final List<Status> statuses;

  const UpdateStatuses({this.statuses});

  @override
  List<Object> get props => [statuses];
}

class UpdateStatusHistories extends StatusesEvent {
  final Status selectedStatus;
  final List<Status> statuses;

  const UpdateStatusHistories(this.selectedStatus, this.statuses);

  @override
  List<Object> get props => [statuses];
}

class UpdateStatusCharts extends StatusesEvent {
  final Status selectedStatus;
  final List<Status> statuses;

  const UpdateStatusCharts({
    @required this.selectedStatus,
    @required this.statuses,
  }) : assert(selectedStatus != null);

  @override
  List<Object> get props => [selectedStatus];
}

class UpdateRssFeed extends StatusesEvent {
  final RssFeed rssFeed;

  const UpdateRssFeed({this.rssFeed});

  @override
  List<Object> get props => [rssFeed];

  @override
  String toString() => 'UpdateRssFeed { body: $rssFeed }';
}
