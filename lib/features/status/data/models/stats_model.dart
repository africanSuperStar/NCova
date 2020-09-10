library stats_model;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';
import 'package:uncovid/features/status/data/models/serializers.dart';

part 'stats_model.g.dart';

abstract class Stats implements Built<Stats, StatsBuilder> {
  @nullable
  Left<String, dynamic> get countries;

  @nullable
  Left<String, dynamic> get deathRate;

  @nullable
  Left<String, dynamic> get incubation;

  @nullable
  Left<String, dynamic> get r0;

  Stats._();

  factory Stats([void Function(StatsBuilder) updates]) = _$Stats;

  String toJson() {
    return json.encode(serializers.serializeWith<Stats>(Stats.serializer, this));
  }

  Stats fromJson(String jsonString) {
    return serializers.deserializeWith<Stats>(Stats.serializer, json.decode(jsonString));
  }

  @BuiltValueSerializer(custom: true)
  static Serializer<Stats> get serializer => StatsValueSerializer();
}

class StatsValueSerializer implements StructuredSerializer<Stats> {
  @override
  Stats deserialize(Serializers serializers, Iterable serialized, {FullType specifiedType = FullType.unspecified}) {
    final result = StatsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'countries':
          if (value is String) {
            result.countries = Left(value);
          }
          break;
        case 'deathRate':
          if (value is String) {
            result.deathRate = Left(value);
          }
          break;
        case 'incubation':
          if (value is String) {
            result.incubation = Left(value);
          }
          break;
        case 'r0':
          if (value is String) {
            result.r0 = Left(value);
          }
          break;
        default:
          break;
      }
    }
    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, Stats object, {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.countries != null) {
      result..add('countries')..add(serializers.serialize(object.countries?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.deathRate != null) {
      result..add('deathRate')..add(serializers.serialize(object.deathRate?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.incubation != null) {
      result..add('incubation')..add(serializers.serialize(object.incubation?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.r0 != null) {
      result..add('r0')..add(serializers.serialize(object.r0?.value ?? '', specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Iterable<Type> get types => [Stats, _$Stats];

  @override
  String get wireName => 'Stats';
}
