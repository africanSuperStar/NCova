// GENERATED CODE - DO NOT MODIFY BY HAND

part of diffs_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DiffsType _$day = const DiffsType._('day');
const DiffsType _$week = const DiffsType._('week');
const DiffsType _$month = const DiffsType._('month');
const DiffsType _$last = const DiffsType._('last');

DiffsType _$valueOf(String name) {
  switch (name) {
    case 'day':
      return _$day;
    case 'week':
      return _$week;
    case 'month':
      return _$month;
    case 'last':
      return _$last;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<DiffsType> _$values = new BuiltSet<DiffsType>(const <DiffsType>[
  _$day,
  _$week,
  _$month,
  _$last,
]);

Serializer<DiffsType> _$diffsTypeSerializer = new _$DiffsTypeSerializer();

class _$DiffsTypeSerializer implements PrimitiveSerializer<DiffsType> {
  @override
  final Iterable<Type> types = const <Type>[DiffsType];
  @override
  final String wireName = 'DiffsType';

  @override
  Object serialize(Serializers serializers, DiffsType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  DiffsType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DiffsType.valueOf(serialized as String);
}

class _$Diffs extends Diffs {
  @override
  final Left<Totals, dynamic> day;
  @override
  final Left<Totals, dynamic> week;
  @override
  final Left<Totals, dynamic> month;
  @override
  final Left<Totals, dynamic> last;

  factory _$Diffs([void Function(DiffsBuilder) updates]) =>
      (new DiffsBuilder()..update(updates)).build();

  _$Diffs._({this.day, this.week, this.month, this.last}) : super._();

  @override
  Diffs rebuild(void Function(DiffsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DiffsBuilder toBuilder() => new DiffsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Diffs &&
        day == other.day &&
        week == other.week &&
        month == other.month &&
        last == other.last;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, day.hashCode), week.hashCode), month.hashCode),
        last.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Diffs')
          ..add('day', day)
          ..add('week', week)
          ..add('month', month)
          ..add('last', last))
        .toString();
  }
}

class DiffsBuilder implements Builder<Diffs, DiffsBuilder> {
  _$Diffs _$v;

  Left<Totals, dynamic> _day;
  Left<Totals, dynamic> get day => _$this._day;
  set day(Left<Totals, dynamic> day) => _$this._day = day;

  Left<Totals, dynamic> _week;
  Left<Totals, dynamic> get week => _$this._week;
  set week(Left<Totals, dynamic> week) => _$this._week = week;

  Left<Totals, dynamic> _month;
  Left<Totals, dynamic> get month => _$this._month;
  set month(Left<Totals, dynamic> month) => _$this._month = month;

  Left<Totals, dynamic> _last;
  Left<Totals, dynamic> get last => _$this._last;
  set last(Left<Totals, dynamic> last) => _$this._last = last;

  DiffsBuilder();

  DiffsBuilder get _$this {
    if (_$v != null) {
      _day = _$v.day;
      _week = _$v.week;
      _month = _$v.month;
      _last = _$v.last;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Diffs other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Diffs;
  }

  @override
  void update(void Function(DiffsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Diffs build() {
    final _$result =
        _$v ?? new _$Diffs._(day: day, week: week, month: month, last: last);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
