// GENERATED CODE - DO NOT MODIFY BY HAND

part of versus_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Versus extends Versus {
  @override
  final Left<String, dynamic> description;
  @override
  final Left<String, dynamic> link;
  @override
  final Left<String, dynamic> ncovNum;
  @override
  final Left<String, dynamic> title;
  @override
  final Left<String, dynamic> vsNum;

  factory _$Versus([void Function(VersusBuilder) updates]) =>
      (new VersusBuilder()..update(updates)).build();

  _$Versus._(
      {this.description, this.link, this.ncovNum, this.title, this.vsNum})
      : super._();

  @override
  Versus rebuild(void Function(VersusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VersusBuilder toBuilder() => new VersusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Versus &&
        description == other.description &&
        link == other.link &&
        ncovNum == other.ncovNum &&
        title == other.title &&
        vsNum == other.vsNum;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, description.hashCode), link.hashCode),
                ncovNum.hashCode),
            title.hashCode),
        vsNum.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Versus')
          ..add('description', description)
          ..add('link', link)
          ..add('ncovNum', ncovNum)
          ..add('title', title)
          ..add('vsNum', vsNum))
        .toString();
  }
}

class VersusBuilder implements Builder<Versus, VersusBuilder> {
  _$Versus _$v;

  Left<String, dynamic> _description;
  Left<String, dynamic> get description => _$this._description;
  set description(Left<String, dynamic> description) =>
      _$this._description = description;

  Left<String, dynamic> _link;
  Left<String, dynamic> get link => _$this._link;
  set link(Left<String, dynamic> link) => _$this._link = link;

  Left<String, dynamic> _ncovNum;
  Left<String, dynamic> get ncovNum => _$this._ncovNum;
  set ncovNum(Left<String, dynamic> ncovNum) => _$this._ncovNum = ncovNum;

  Left<String, dynamic> _title;
  Left<String, dynamic> get title => _$this._title;
  set title(Left<String, dynamic> title) => _$this._title = title;

  Left<String, dynamic> _vsNum;
  Left<String, dynamic> get vsNum => _$this._vsNum;
  set vsNum(Left<String, dynamic> vsNum) => _$this._vsNum = vsNum;

  VersusBuilder();

  VersusBuilder get _$this {
    if (_$v != null) {
      _description = _$v.description;
      _link = _$v.link;
      _ncovNum = _$v.ncovNum;
      _title = _$v.title;
      _vsNum = _$v.vsNum;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Versus other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Versus;
  }

  @override
  void update(void Function(VersusBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Versus build() {
    final _$result = _$v ??
        new _$Versus._(
            description: description,
            link: link,
            ncovNum: ncovNum,
            title: title,
            vsNum: vsNum);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
