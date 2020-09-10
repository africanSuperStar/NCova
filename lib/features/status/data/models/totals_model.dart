library totals_model;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';
import 'package:uncovid/features/status/data/models/serializers.dart';

part 'totals_model.g.dart';

abstract class Totals implements Built<Totals, TotalsBuilder> {
  @nullable
  Left<String, dynamic> get cases;

  @nullable
  Left<String, dynamic> get closed;

  @nullable
  Left<String, dynamic> get current;

  @nullable
  Left<String, dynamic> get mild;

  @nullable
  Left<String, dynamic> get mildPercent;

  @nullable
  Left<String, dynamic> get deaths;

  @nullable
  Left<String, dynamic> get deathsPercent;

  @nullable
  Left<String, dynamic> get recovered;

  @nullable
  Left<String, dynamic> get recoveredPercent;

  @nullable
  Left<String, dynamic> get serious;

  @nullable
  Left<String, dynamic> get seriousPercent;

  @nullable
  Left<String, dynamic> get suspected;

  Totals._();

  factory Totals([void Function(TotalsBuilder) updates]) = _$Totals;

  String toJson() {
    return json.encode(serializers.serializeWith(Totals.serializer, this));
  }

  Totals fromJson(String jsonString) {
    return serializers.deserializeWith(Totals.serializer, json.decode(jsonString));
  }

  @BuiltValueSerializer(custom: true)
  static Serializer<Totals> get serializer => TotalsValueSerializer();
}

class TotalsValueSerializer implements StructuredSerializer<Totals> {
  @override
  Totals deserialize(Serializers serializers, Iterable serialized, {FullType specifiedType = FullType.unspecified}) {
    final result = TotalsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'cases':
          if (value is String) {
            result.cases = Left(value);
          }
          break;
        case 'closed':
          if (value is String) {
            result.closed = Left(value);
          }
          break;
        case 'current':
          if (value is String) {
            result.current = Left(value);
          }
          break;
        case 'mild':
          if (value is String) {
            result.mild = Left(value);
          }
          break;
        case 'mildPercent':
          if (value is String) {
            result.mildPercent = Left(value);
          }
          break;
        case 'deaths':
          if (value is String) {
            result.deaths = Left(value);
          }
          break;
        case 'deathsPercent':
          if (value is String) {
            result.deathsPercent = Left(value);
          }
          break;
        case 'recovered':
          if (value is String) {
            result.recovered = Left(value);
          }
          break;
        case 'recoveredPercent':
          if (value is String) {
            result.recoveredPercent = Left(value);
          }
          break;
        case 'serious':
          if (value is String) {
            result.serious = Left(value);
          }
          break;
        case 'seriousPercent':
          if (value is String) {
            result.seriousPercent = Left(value);
          }
          break;
        case 'suspected':
          if (value is String) {
            result.suspected = Left(value);
          }
          break;
        default:
          break;
      }
    }
    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, Totals object, {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.cases != null) {
      result..add('cases')..add(serializers.serialize(object.cases?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.closed != null) {
      result..add('closed')..add(serializers.serialize(object.closed?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.current != null) {
      result..add('current')..add(serializers.serialize(object.current?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.mild != null) {
      result..add('mild')..add(serializers.serialize(object.mild?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.mildPercent != null) {
      result..add('mildPercent')..add(serializers.serialize(object.mildPercent?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.deaths != null) {
      result..add('deaths')..add(serializers.serialize(object.deaths?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.deathsPercent != null) {
      result..add('deathsPercent')..add(serializers.serialize(object.deathsPercent?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.recovered != null) {
      result..add('recovered')..add(serializers.serialize(object.recovered?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.recoveredPercent != null) {
      result..add('recoveredPercent')..add(serializers.serialize(object.recoveredPercent?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.serious != null) {
      result..add('serious')..add(serializers.serialize(object.serious?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.seriousPercent != null) {
      result..add('seriousPercent')..add(serializers.serialize(object.seriousPercent?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.suspected != null) {
      result..add('suspected')..add(serializers.serialize(object.suspected?.value ?? '', specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Iterable<Type> get types => [Totals, _$Totals];

  @override
  String get wireName => 'Totals';
}
