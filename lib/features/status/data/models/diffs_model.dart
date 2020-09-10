library diffs_model;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';
import 'package:uncovid/features/status/data/models/serializers.dart';
import 'package:uncovid/features/status/data/models/totals_model.dart';

part 'diffs_model.g.dart';

abstract class Diffs implements Built<Diffs, DiffsBuilder> {
  @nullable
  Left<Totals, dynamic> get day;

  @nullable
  Left<Totals, dynamic> get week;

  @nullable
  Left<Totals, dynamic> get month;

  @nullable
  Left<Totals, dynamic> get last;

  Diffs._();

  factory Diffs([void Function(DiffsBuilder) updates]) = _$Diffs;

  String toJson() {
    return json.encode(serializers.serializeWith(Diffs.serializer, this));
  }

  Diffs fromJson(String jsonString) {
    return serializers.deserializeWith(Diffs.serializer, json.decode(jsonString));
  }

  @BuiltValueSerializer(custom: true)
  static Serializer<Diffs> get serializer => DiffsValueSerializer();
}

class DiffsValueSerializer implements StructuredSerializer<Diffs> {
  @override
  Diffs deserialize(Serializers serializers, Iterable serialized, {FullType specifiedType = FullType.unspecified}) {
    final result = DiffsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'day':
          if (value is Map) {
            result.day = Left(serializers.deserializeWith<Totals>(Totals.serializer, value));
          }
          break;
        case 'week':
          if (value is Map) {
            result.week = Left(serializers.deserializeWith<Totals>(Totals.serializer, value));
          }
          break;
        case 'month':
          if (value is Map) {
            result.month = Left(serializers.deserializeWith<Totals>(Totals.serializer, value));
          }
          break;
        case 'last':
          if (value is Map) {
            result.last = Left(serializers.deserializeWith<Totals>(Totals.serializer, value));
          }
          break;
        default:
          break;
      }
    }
    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, Diffs object, {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.day != null) {
      result..add('day')..add(serializers.serializeWith<Totals>(Totals.serializer, object.day?.value));
    }
    if (object.week != null) {
      result..add('week')..add(serializers.serializeWith<Totals>(Totals.serializer, object.week?.value));
    }
    if (object.month != null) {
      result..add('month')..add(serializers.serializeWith<Totals>(Totals.serializer, object.month?.value));
    }
    if (object.last != null) {
      result..add('last')..add(serializers.serializeWith<Totals>(Totals.serializer, object.last?.value));
    }
    return result;
  }

  @override
  Iterable<Type> get types => [Diffs, _$Diffs];

  @override
  String get wireName => 'Diffs';
}

class DiffsType extends EnumClass {
  static const DiffsType day = _$day;
  static const DiffsType week = _$week;
  static const DiffsType month = _$month;
  static const DiffsType last = _$last;

  const DiffsType._(String name) : super(name);

  static BuiltSet<DiffsType> get values => _$values;
  static DiffsType valueOf(String name) => _$valueOf(name);
  static Serializer<DiffsType> get serializer => _$diffsTypeSerializer;
}
