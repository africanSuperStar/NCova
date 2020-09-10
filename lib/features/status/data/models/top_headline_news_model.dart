library top_headline_news_model;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:dartz/dartz.dart';

import 'serializers.dart';
import 'status_model.dart';

part 'top_headline_news_model.g.dart';

abstract class ResponseTopHeadlinesNews implements Built<ResponseTopHeadlinesNews, ResponseTopHeadlinesNewsBuilder> {
  @nullable
  Either<Status, dynamic> get status;

  @nullable
  Either<int, dynamic> get totalResults;

  @nullable
  Either<BuiltList<Article>, dynamic> get articles;

  @nullable
  String get error;

  ResponseTopHeadlinesNews._();

  factory ResponseTopHeadlinesNews([void Function(ResponseTopHeadlinesNewsBuilder) updates]) = _$ResponseTopHeadlinesNews;

  static ResponseTopHeadlinesNews withError(error) {
    return error;
  }

  String toJson() {
    return json.encode(serializers.serializeWith(ResponseTopHeadlinesNews.serializer, this));
  }

  static ResponseTopHeadlinesNews fromJson(String jsonString) {
    return serializers.deserializeWith(ResponseTopHeadlinesNews.serializer, json.decode(jsonString));
  }

  static Serializer<ResponseTopHeadlinesNews> get serializer => _$responseTopHeadlinesNewsSerializer;
}

abstract class Article implements Built<Article, ArticleBuilder> {
  @nullable
  Source get source;
  @nullable
  String get author;
  @nullable
  String get title;
  @nullable
  String get description;
  @nullable
  String get url;
  @nullable
  String get urlToImage;
  @nullable
  String get publishedAt;
  @nullable
  String get content;

  Article._();

  factory Article([void Function(ArticleBuilder) updates]) = _$Article;

  String toJson() {
    return json.encode(serializers.serializeWith(Article.serializer, this));
  }

  static Article fromJson(String jsonString) {
    return serializers.deserializeWith(Article.serializer, json.decode(jsonString));
  }

  static Serializer<Article> get serializer => _$articleSerializer;
}

abstract class Source implements Built<Source, SourceBuilder> {
  @nullable
  String get name;

  Source._();

  factory Source([void Function(SourceBuilder) updates]) = _$Source;

  String toJson() {
    return json.encode(serializers.serializeWith(Source.serializer, this));
  }

  static Source fromJson(String jsonString) {
    return serializers.deserializeWith(Source.serializer, json.decode(jsonString));
  }

  static Serializer<Source> get serializer => _$sourceSerializer;
}
