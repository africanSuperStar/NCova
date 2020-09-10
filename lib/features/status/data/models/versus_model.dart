library versus_model;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';
import 'package:uncovid/features/status/data/models/serializers.dart';

part 'versus_model.g.dart';

abstract class Versus implements Built<Versus, VersusBuilder> {
  @nullable
  Left<String, dynamic> get description;

  @nullable
  Left<String, dynamic> get link;

  @nullable
  Left<String, dynamic> get ncovNum;

  @nullable
  Left<String, dynamic> get title;

  @nullable
  Left<String, dynamic> get vsNum;

  Versus._();

  factory Versus([void Function(VersusBuilder) updates]) = _$Versus;

  String toJson() {
    return json.encode(serializers.serializeWith(Versus.serializer, this));
  }

  Versus fromJson(String jsonString) {
    return serializers.deserializeWith(Versus.serializer, json.decode(jsonString));
  }

  @BuiltValueSerializer(custom: true)
  static Serializer<Versus> get serializer => VersusValueSerializer();
}

class VersusValueSerializer implements StructuredSerializer<Versus> {
  @override
  Versus deserialize(Serializers serializers, Iterable serialized, {FullType specifiedType = FullType.unspecified}) {
    final result = VersusBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'description':
          if (value is String) {
            result.description = Left(value);
          }
          break;
        case 'link':
          if (value is String) {
            result.link = Left(value);
          }
          break;
        case 'ncovNum':
          if (value is String) {
            result.ncovNum = Left(value);
          }
          break;
        case 'title':
          if (value is String) {
            result.title = Left(value);
          }
          break;
        case 'vsNum':
          if (value is String) {
            result.vsNum = Left(value);
          }
          break;
        default:
          break;
      }
    }
    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, Versus object, {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.description != null) {
      result..add('description')..add(serializers.serialize(object.description?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.link != null) {
      result..add('link')..add(serializers.serialize(object.link?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.ncovNum != null) {
      result..add('ncovNum')..add(serializers.serialize(object.ncovNum?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.title != null) {
      result..add('title')..add(serializers.serialize(object.title?.value ?? '', specifiedType: const FullType(String)));
    }
    if (object.vsNum != null) {
      result..add('vsNum')..add(serializers.serialize(object.vsNum?.value ?? '', specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Iterable<Type> get types => [Versus, _$Versus];

  @override
  String get wireName => 'Versus';
}
