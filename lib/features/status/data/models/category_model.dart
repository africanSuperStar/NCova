import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';

import 'serializers.dart';

part 'category_model.g.dart';

abstract class Category implements Built<Category, CategoryBuilder> {
  @nullable
  Left<String, dynamic> get image;

  @nullable
  Left<String, dynamic> get title;

  Category._();

  factory Category([void Function(CategoryBuilder) updates]) = _$Category;

  String toJson() {
    return json.encode(serializers.serializeWith(Category.serializer, this));
  }

  static Category fromJson(String jsonString) {
    return serializers.deserializeWith(Category.serializer, json.decode(jsonString));
  }

  @BuiltValueSerializer(custom: true)
  static Serializer<Category> get serializer => CategoryValueSerializer();
}

class CategoryValueSerializer implements StructuredSerializer<Category> {
  @override
  Category deserialize(Serializers serializers, Iterable serialized, {FullType specifiedType = FullType.unspecified}) {
    final result = CategoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'image':
          if (value is String) {
            result.image = Left(value);
          }
          break;
        case 'title':
          if (value is String) {
            result.title = Left(value);
          }
          break;
        default:
          break;
      }
    }
    return result.build();
  }

  @override
  Iterable serialize(Serializers serializers, Category object, {FullType specifiedType = FullType.unspecified}) {
    // TODO: implement serialize
    return null;
  }

  @override
  Iterable<Type> get types => [Category, _$Category];

  @override
  String get wireName => 'Category';
}
