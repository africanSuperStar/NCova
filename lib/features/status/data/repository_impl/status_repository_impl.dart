import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../navigator_service.dart';
import '../../../../services/storage/file_storage.dart';
import '../../domain/repository/status_repository.dart';
import '../models/models.dart';
import '../models/serializers.dart';

class StatusRepositoryImpl implements StatusRepository {
  final FileStorage fileStorage;
  final NavigatorService service;

  StatusRepositoryImpl({
    @required this.fileStorage,
    @required this.service,
  }) : assert(
          fileStorage != null,
          service != null,
        );

  @override
  void saveFavorites(List<Status> favorites) async {
    final favoriteEntities = <Status>[];

    for (final favorite in favorites) {
      favoriteEntities.add(favorite);
    }
    fileStorage.saveFavorites(favoriteEntities);
  }

  @override
  Future<List<Status>> loadFavorites() async {
    return await fileStorage.loadFavorites();
  }

  @override
  Stream<List<Status>> statuses() {
    return service.statusCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map<Status>(
            (doc) => _mapStatusEntity(doc),
          )
          .toList();
    });
  }

  @override
  Stream<List<Status>> statusHistory({@required Status status}) {
    return service.statusCollection.document(status.a3?.value ?? '').collection('history').snapshots().map((snapshot) {
      return snapshot.documents
          .map<Status>(
            (doc) => _mapStatusEntity(doc),
          )
          .toList();
    });
  }

  @override
  Stream<List<Status>> intl() {
    return service.statusCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map<Status>(
            (doc) => _mapIntlEntity(doc),
          )
          .toList();
    });
  }

  @override
  Stream<List<Status>> intlHistory() {
    return service.statusCollection.document('intl').collection('history').snapshots().map((snapshot) {
      return snapshot.documents
          .map<Status>(
            (doc) => _mapIntlHistoryEntity(doc),
          )
          .toList();
    });
  }

  @override
  Stream<String> rssFeed() {
    var client = new http.Client();
    // WHO Atom feed
    return client.get("https://www.afro.who.int/rss/featured-news.xml").then((response) {
      return response.body;
    }).asStream();
  }

  Status _mapStatusEntity(DocumentSnapshot doc) {
    if (doc.documentID == 'intl') return null;
    var dataWithID = Map.from(doc.data)..addEntries([MapEntry("id", doc.documentID)]);
    Status status = serializers.deserializeWith<Status>(Status.serializer, dataWithID);
    return status;
  }

  Status _mapIntlEntity(DocumentSnapshot doc) {
    if (doc.documentID == 'intl') {
      var dataWithID = Map.from(doc.data)..addEntries([MapEntry("id", doc.documentID)]);
      Status status = serializers.deserializeWith<Status>(Status.serializer, dataWithID);
      return status;
    } else {
      return null;
    }
  }

  Status _mapIntlHistoryEntity(DocumentSnapshot doc) {
    if (int.tryParse(doc.documentID).isFinite) {
      var dataWithID = Map.from(doc.data)..addEntries([MapEntry("id", doc.documentID)]);
      Status status = serializers.deserializeWith<Status>(Status.serializer, dataWithID);
      return status;
    } else {
      return null;
    }
  }
}
