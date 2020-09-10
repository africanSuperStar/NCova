// GENERATED CODE - DO NOT MODIFY BY HAND

part of top_headline_news_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ResponseTopHeadlinesNews> _$responseTopHeadlinesNewsSerializer =
    new _$ResponseTopHeadlinesNewsSerializer();
Serializer<Article> _$articleSerializer = new _$ArticleSerializer();
Serializer<Source> _$sourceSerializer = new _$SourceSerializer();

class _$ResponseTopHeadlinesNewsSerializer
    implements StructuredSerializer<ResponseTopHeadlinesNews> {
  @override
  final Iterable<Type> types = const [
    ResponseTopHeadlinesNews,
    _$ResponseTopHeadlinesNews
  ];
  @override
  final String wireName = 'ResponseTopHeadlinesNews';

  @override
  Iterable<Object> serialize(
      Serializers serializers, ResponseTopHeadlinesNews object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType: const FullType(Either,
                const [const FullType(Status), const FullType(dynamic)])));
    }
    if (object.totalResults != null) {
      result
        ..add('totalResults')
        ..add(serializers.serialize(object.totalResults,
            specifiedType: const FullType(
                Either, const [const FullType(int), const FullType(dynamic)])));
    }
    if (object.articles != null) {
      result
        ..add('articles')
        ..add(serializers.serialize(object.articles,
            specifiedType: const FullType(Either, const [
              const FullType(BuiltList, const [const FullType(Article)]),
              const FullType(dynamic)
            ])));
    }
    if (object.error != null) {
      result
        ..add('error')
        ..add(serializers.serialize(object.error,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  ResponseTopHeadlinesNews deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ResponseTopHeadlinesNewsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(Either, const [
                const FullType(Status),
                const FullType(dynamic)
              ])) as Either<Status, dynamic>;
          break;
        case 'totalResults':
          result.totalResults = serializers.deserialize(value,
              specifiedType: const FullType(Either, const [
                const FullType(int),
                const FullType(dynamic)
              ])) as Either<int, dynamic>;
          break;
        case 'articles':
          result.articles = serializers.deserialize(value,
              specifiedType: const FullType(Either, const [
                const FullType(BuiltList, const [const FullType(Article)]),
                const FullType(dynamic)
              ])) as Either<BuiltList<Article>, dynamic>;
          break;
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ArticleSerializer implements StructuredSerializer<Article> {
  @override
  final Iterable<Type> types = const [Article, _$Article];
  @override
  final String wireName = 'Article';

  @override
  Iterable<Object> serialize(Serializers serializers, Article object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.source != null) {
      result
        ..add('source')
        ..add(serializers.serialize(object.source,
            specifiedType: const FullType(Source)));
    }
    if (object.author != null) {
      result
        ..add('author')
        ..add(serializers.serialize(object.author,
            specifiedType: const FullType(String)));
    }
    if (object.title != null) {
      result
        ..add('title')
        ..add(serializers.serialize(object.title,
            specifiedType: const FullType(String)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.url != null) {
      result
        ..add('url')
        ..add(serializers.serialize(object.url,
            specifiedType: const FullType(String)));
    }
    if (object.urlToImage != null) {
      result
        ..add('urlToImage')
        ..add(serializers.serialize(object.urlToImage,
            specifiedType: const FullType(String)));
    }
    if (object.publishedAt != null) {
      result
        ..add('publishedAt')
        ..add(serializers.serialize(object.publishedAt,
            specifiedType: const FullType(String)));
    }
    if (object.content != null) {
      result
        ..add('content')
        ..add(serializers.serialize(object.content,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Article deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArticleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'source':
          result.source.replace(serializers.deserialize(value,
              specifiedType: const FullType(Source)) as Source);
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'urlToImage':
          result.urlToImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'publishedAt':
          result.publishedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'content':
          result.content = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SourceSerializer implements StructuredSerializer<Source> {
  @override
  final Iterable<Type> types = const [Source, _$Source];
  @override
  final String wireName = 'Source';

  @override
  Iterable<Object> serialize(Serializers serializers, Source object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Source deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SourceBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ResponseTopHeadlinesNews extends ResponseTopHeadlinesNews {
  @override
  final Either<Status, dynamic> status;
  @override
  final Either<int, dynamic> totalResults;
  @override
  final Either<BuiltList<Article>, dynamic> articles;
  @override
  final String error;

  factory _$ResponseTopHeadlinesNews(
          [void Function(ResponseTopHeadlinesNewsBuilder) updates]) =>
      (new ResponseTopHeadlinesNewsBuilder()..update(updates)).build();

  _$ResponseTopHeadlinesNews._(
      {this.status, this.totalResults, this.articles, this.error})
      : super._();

  @override
  ResponseTopHeadlinesNews rebuild(
          void Function(ResponseTopHeadlinesNewsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResponseTopHeadlinesNewsBuilder toBuilder() =>
      new ResponseTopHeadlinesNewsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResponseTopHeadlinesNews &&
        status == other.status &&
        totalResults == other.totalResults &&
        articles == other.articles &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, status.hashCode), totalResults.hashCode),
            articles.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ResponseTopHeadlinesNews')
          ..add('status', status)
          ..add('totalResults', totalResults)
          ..add('articles', articles)
          ..add('error', error))
        .toString();
  }
}

class ResponseTopHeadlinesNewsBuilder
    implements
        Builder<ResponseTopHeadlinesNews, ResponseTopHeadlinesNewsBuilder> {
  _$ResponseTopHeadlinesNews _$v;

  Either<Status, dynamic> _status;
  Either<Status, dynamic> get status => _$this._status;
  set status(Either<Status, dynamic> status) => _$this._status = status;

  Either<int, dynamic> _totalResults;
  Either<int, dynamic> get totalResults => _$this._totalResults;
  set totalResults(Either<int, dynamic> totalResults) =>
      _$this._totalResults = totalResults;

  Either<BuiltList<Article>, dynamic> _articles;
  Either<BuiltList<Article>, dynamic> get articles => _$this._articles;
  set articles(Either<BuiltList<Article>, dynamic> articles) =>
      _$this._articles = articles;

  String _error;
  String get error => _$this._error;
  set error(String error) => _$this._error = error;

  ResponseTopHeadlinesNewsBuilder();

  ResponseTopHeadlinesNewsBuilder get _$this {
    if (_$v != null) {
      _status = _$v.status;
      _totalResults = _$v.totalResults;
      _articles = _$v.articles;
      _error = _$v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResponseTopHeadlinesNews other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ResponseTopHeadlinesNews;
  }

  @override
  void update(void Function(ResponseTopHeadlinesNewsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ResponseTopHeadlinesNews build() {
    final _$result = _$v ??
        new _$ResponseTopHeadlinesNews._(
            status: status,
            totalResults: totalResults,
            articles: articles,
            error: error);
    replace(_$result);
    return _$result;
  }
}

class _$Article extends Article {
  @override
  final Source source;
  @override
  final String author;
  @override
  final String title;
  @override
  final String description;
  @override
  final String url;
  @override
  final String urlToImage;
  @override
  final String publishedAt;
  @override
  final String content;

  factory _$Article([void Function(ArticleBuilder) updates]) =>
      (new ArticleBuilder()..update(updates)).build();

  _$Article._(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content})
      : super._();

  @override
  Article rebuild(void Function(ArticleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleBuilder toBuilder() => new ArticleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Article &&
        source == other.source &&
        author == other.author &&
        title == other.title &&
        description == other.description &&
        url == other.url &&
        urlToImage == other.urlToImage &&
        publishedAt == other.publishedAt &&
        content == other.content;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, source.hashCode), author.hashCode),
                            title.hashCode),
                        description.hashCode),
                    url.hashCode),
                urlToImage.hashCode),
            publishedAt.hashCode),
        content.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Article')
          ..add('source', source)
          ..add('author', author)
          ..add('title', title)
          ..add('description', description)
          ..add('url', url)
          ..add('urlToImage', urlToImage)
          ..add('publishedAt', publishedAt)
          ..add('content', content))
        .toString();
  }
}

class ArticleBuilder implements Builder<Article, ArticleBuilder> {
  _$Article _$v;

  SourceBuilder _source;
  SourceBuilder get source => _$this._source ??= new SourceBuilder();
  set source(SourceBuilder source) => _$this._source = source;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  String _urlToImage;
  String get urlToImage => _$this._urlToImage;
  set urlToImage(String urlToImage) => _$this._urlToImage = urlToImage;

  String _publishedAt;
  String get publishedAt => _$this._publishedAt;
  set publishedAt(String publishedAt) => _$this._publishedAt = publishedAt;

  String _content;
  String get content => _$this._content;
  set content(String content) => _$this._content = content;

  ArticleBuilder();

  ArticleBuilder get _$this {
    if (_$v != null) {
      _source = _$v.source?.toBuilder();
      _author = _$v.author;
      _title = _$v.title;
      _description = _$v.description;
      _url = _$v.url;
      _urlToImage = _$v.urlToImage;
      _publishedAt = _$v.publishedAt;
      _content = _$v.content;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Article other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Article;
  }

  @override
  void update(void Function(ArticleBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Article build() {
    _$Article _$result;
    try {
      _$result = _$v ??
          new _$Article._(
              source: _source?.build(),
              author: author,
              title: title,
              description: description,
              url: url,
              urlToImage: urlToImage,
              publishedAt: publishedAt,
              content: content);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'source';
        _source?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Article', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Source extends Source {
  @override
  final String name;

  factory _$Source([void Function(SourceBuilder) updates]) =>
      (new SourceBuilder()..update(updates)).build();

  _$Source._({this.name}) : super._();

  @override
  Source rebuild(void Function(SourceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SourceBuilder toBuilder() => new SourceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Source && name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(0, name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Source')..add('name', name))
        .toString();
  }
}

class SourceBuilder implements Builder<Source, SourceBuilder> {
  _$Source _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  SourceBuilder();

  SourceBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Source other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Source;
  }

  @override
  void update(void Function(SourceBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Source build() {
    final _$result = _$v ?? new _$Source._(name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
