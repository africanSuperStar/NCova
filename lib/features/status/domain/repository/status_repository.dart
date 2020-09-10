import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/models.dart';

abstract class StatusRepository {
  Future<List<Status>> loadFavorites();
  void saveFavorites(List<Status> favorites);
  Stream<List<Status>> statuses();
  Stream<List<Status>> statusHistory({@required Status status});
  Stream<List<Status>> intl();
  Stream<List<Status>> intlHistory();
  Stream<String> rssFeed();
}
