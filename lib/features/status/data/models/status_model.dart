library status;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';
import 'package:uncovid/features/status/data/models/serializers.dart';
import 'package:uuid/uuid.dart';

import 'diffs_model.dart';
import 'stats_model.dart';
import 'totals_model.dart';
import 'versus_model.dart';

part 'status_model.g.dart';

abstract class Status implements Built<Status, StatusBuilder> {
  String get id;

  @nullable
  Left<String, dynamic> get a3;

  @nullable
  Left<String, dynamic> get createdAt;

  @nullable
  Left<String, dynamic> get checkedAt;

  @nullable
  bool get favorited;

  @nullable
  @BuiltValueField(wireName: 'in')
  Left<bool, dynamic> get present;

  @nullable
  Left<String, dynamic> get name;

  @nullable
  Left<bool, dynamic> get neighbour;

  @nullable
  Left<String, dynamic> get region;

  @nullable
  Left<String, dynamic> get status;

  @nullable
  Left<BuiltList<String>, dynamic> get neighbours;

  @nullable
  Left<String, dynamic> get source;

  @nullable
  Left<Totals, dynamic> get totals;

  @nullable
  Left<Stats, dynamic> get stats;

  @nullable
  Left<Diffs, dynamic> get diffs;

  @nullable
  @BuiltValueField(wireName: 'vs')
  Left<Versus, dynamic> get versus;

  Status._();

  factory Status() {
    return _$Status._(
      id: Uuid().v4(),
    );
  }

  factory Status.builder([updates(StatusBuilder b)]) {
    final builder = StatusBuilder()
      ..id = Uuid().v4()
      ..update(updates);

    return builder.build();
  }

  String toJson() {
    return json.encode(serializers.serializeWith<Status>(Status.serializer, this));
  }

  static Status fromJson(String jsonString) {
    return serializers.deserializeWith<Status>(Status.serializer, json.decode(jsonString));
  }

  @BuiltValueSerializer(custom: true)
  static Serializer<Status> get serializer => StatusValueSerializer();
}

class StatusValueSerializer implements StructuredSerializer<Status> {
  @override
  Status deserialize(Serializers serializers, Iterable serialized, {FullType specifiedType = FullType.unspecified}) {
    final result = StatusBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          if (value is String) {
            result.id = serializers.deserialize(value, specifiedType: const FullType(String)) as String;
          } else if (value is Map) {
            result.id = serializers.deserialize(value.values.toList()[1], specifiedType: const FullType(String)) as String;
          } else {
            result.id = Uuid().v4();
          }
          break;
        case 'a3':
          if (value is String) {
            result.a3 = Left(value);
          }
          break;
        case 'favorited':
          if (value is bool) {
            result.favorited = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          }
          break;
        case 'createdAt':
          if (value is String) {
            result.createdAt = Left(value);
          }
          break;
        case 'checkedAt':
          if (value is String) {
            result.checkedAt = Left(value);
          }
          break;
        case 'favorited':
          if (value is bool) {
            result.favorited = serializers.deserialize(value, specifiedType: const FullType(bool)) as bool;
          }
          break;
        case 'in':
          if (value is bool) {
            result.present = Left(value);
          }
          break;
        case 'name':
          if (value is String) {
            result.name = Left(value);
          }
          break;
        case 'neighbour':
          if (value is bool) {
            result.neighbour = Left(value);
          }
          break;
        case 'region':
          if (value is String) {
            result.region = Left(value);
          }
          break;
        case 'status':
          if (value is String) {
            result.status = Left(value);
          }
          break;
        // case 'neighbours':
        //   if (value is List) {
        //     result.neighbours = Left(serializers.deserialize(value)) as Left<BuiltList<String>, dynamic>;
        //   }
        //   break;
        case 'source':
          if (value is String) {
            result.source = Left(value);
          }
          break;
        case 'totals':
          if (value is Map) {
            result.totals = Left(serializers.deserializeWith<Totals>(Totals.serializer, value));
          }
          break;
        case 'stats':
          if (value is Map) {
            result.stats = Left(serializers.deserializeWith<Stats>(Stats.serializer, value));
          }
          break;
        case 'diffs':
          if (value is Map) {
            result.diffs = Left(serializers.deserializeWith<Diffs>(Diffs.serializer, value));
          }
          break;
        case 'vs':
          if (value is Map) {
            result.versus = Left(serializers.deserializeWith<Versus>(Versus.serializer, value));
          }
          break;
        default:
          break;
      }
    }

    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, Status object, {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.id != null) {
      result..add('id')..add(serializers.serialize(object.id));
    }
    if (object.a3 != null) {
      result..add('a3')..add(serializers.serialize(object.a3?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.createdAt != null) {
      result..add('createdAt')..add(serializers.serialize(object.createdAt?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.checkedAt != null) {
      result..add('checkedAt')..add(serializers.serialize(object.checkedAt?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.favorited != null) {
      result..add('favorited')..add(serializers.serialize(object.favorited, specifiedType: const FullType(bool)));
    }
    if (object.present != null) {
      result..add('in')..add(serializers.serialize(object.present?.value ?? false, specifiedType: const FullType(bool)));
    }
    if (object.name != null) {
      result..add('name')..add(serializers.serialize(object.name?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.neighbour != null) {
      result..add('neighbour')..add(serializers.serialize(object.neighbour?.value ?? false, specifiedType: const FullType(bool)));
    }
    if (object.region != null) {
      result..add('region')..add(serializers.serialize(object.region?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result..add('status')..add(serializers.serialize(object.status?.value, specifiedType: const FullType(String)));
    }
    // if (object.neighbours != null) {
    //   result..add('neighbours')..add(serializers.serialize(object.neighbours, specifiedType: const FullType(Either, const [const FullType(String), const FullType(dynamic)])));
    // }
    if (object.source != null) {
      result..add('source')..add(serializers.serialize(object.source?.value ?? false, specifiedType: const FullType(String)));
    }
    if (object.totals != null) {
      result..add('totals')..add(serializers.serializeWith<Totals>(Totals.serializer, object.totals?.value));
    }
    if (object.diffs != null) {
      result..add('diffs')..add(serializers.serializeWith<Diffs>(Diffs.serializer, object.diffs?.value));
    }
    if (object.stats != null) {
      result..add('stats')..add(serializers.serializeWith<Stats>(Stats.serializer, object.stats?.value));
    }
    if (object.versus != null) {
      result..add('vs')..add(serializers.serializeWith<Versus>(Versus.serializer, object.versus?.value));
    }
    return result;
  }

  @override
  Iterable<Type> get types => [Status, _$Status];

  @override
  String get wireName => 'Status';
}
