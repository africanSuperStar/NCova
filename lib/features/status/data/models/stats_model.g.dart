// GENERATED CODE - DO NOT MODIFY BY HAND

part of stats_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Stats extends Stats {
  @override
  final Left<String, dynamic> countries;
  @override
  final Left<String, dynamic> deathRate;
  @override
  final Left<String, dynamic> incubation;
  @override
  final Left<String, dynamic> r0;

  factory _$Stats([void Function(StatsBuilder) updates]) =>
      (new StatsBuilder()..update(updates)).build();

  _$Stats._({this.countries, this.deathRate, this.incubation, this.r0})
      : super._();

  @override
  Stats rebuild(void Function(StatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatsBuilder toBuilder() => new StatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Stats &&
        countries == other.countries &&
        deathRate == other.deathRate &&
        incubation == other.incubation &&
        r0 == other.r0;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, countries.hashCode), deathRate.hashCode),
            incubation.hashCode),
        r0.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Stats')
          ..add('countries', countries)
          ..add('deathRate', deathRate)
          ..add('incubation', incubation)
          ..add('r0', r0))
        .toString();
  }
}

class StatsBuilder implements Builder<Stats, StatsBuilder> {
  _$Stats _$v;

  Left<String, dynamic> _countries;
  Left<String, dynamic> get countries => _$this._countries;
  set countries(Left<String, dynamic> countries) =>
      _$this._countries = countries;

  Left<String, dynamic> _deathRate;
  Left<String, dynamic> get deathRate => _$this._deathRate;
  set deathRate(Left<String, dynamic> deathRate) =>
      _$this._deathRate = deathRate;

  Left<String, dynamic> _incubation;
  Left<String, dynamic> get incubation => _$this._incubation;
  set incubation(Left<String, dynamic> incubation) =>
      _$this._incubation = incubation;

  Left<String, dynamic> _r0;
  Left<String, dynamic> get r0 => _$this._r0;
  set r0(Left<String, dynamic> r0) => _$this._r0 = r0;

  StatsBuilder();

  StatsBuilder get _$this {
    if (_$v != null) {
      _countries = _$v.countries;
      _deathRate = _$v.deathRate;
      _incubation = _$v.incubation;
      _r0 = _$v.r0;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Stats other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Stats;
  }

  @override
  void update(void Function(StatsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Stats build() {
    final _$result = _$v ??
        new _$Stats._(
            countries: countries,
            deathRate: deathRate,
            incubation: incubation,
            r0: r0);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
