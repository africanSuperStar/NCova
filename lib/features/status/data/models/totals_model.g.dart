// GENERATED CODE - DO NOT MODIFY BY HAND

part of totals_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Totals extends Totals {
  @override
  final Left<String, dynamic> cases;
  @override
  final Left<String, dynamic> closed;
  @override
  final Left<String, dynamic> current;
  @override
  final Left<String, dynamic> mild;
  @override
  final Left<String, dynamic> mildPercent;
  @override
  final Left<String, dynamic> deaths;
  @override
  final Left<String, dynamic> deathsPercent;
  @override
  final Left<String, dynamic> recovered;
  @override
  final Left<String, dynamic> recoveredPercent;
  @override
  final Left<String, dynamic> serious;
  @override
  final Left<String, dynamic> seriousPercent;
  @override
  final Left<String, dynamic> suspected;

  factory _$Totals([void Function(TotalsBuilder) updates]) =>
      (new TotalsBuilder()..update(updates)).build();

  _$Totals._(
      {this.cases,
      this.closed,
      this.current,
      this.mild,
      this.mildPercent,
      this.deaths,
      this.deathsPercent,
      this.recovered,
      this.recoveredPercent,
      this.serious,
      this.seriousPercent,
      this.suspected})
      : super._();

  @override
  Totals rebuild(void Function(TotalsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TotalsBuilder toBuilder() => new TotalsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Totals &&
        cases == other.cases &&
        closed == other.closed &&
        current == other.current &&
        mild == other.mild &&
        mildPercent == other.mildPercent &&
        deaths == other.deaths &&
        deathsPercent == other.deathsPercent &&
        recovered == other.recovered &&
        recoveredPercent == other.recoveredPercent &&
        serious == other.serious &&
        seriousPercent == other.seriousPercent &&
        suspected == other.suspected;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, cases.hashCode),
                                                closed.hashCode),
                                            current.hashCode),
                                        mild.hashCode),
                                    mildPercent.hashCode),
                                deaths.hashCode),
                            deathsPercent.hashCode),
                        recovered.hashCode),
                    recoveredPercent.hashCode),
                serious.hashCode),
            seriousPercent.hashCode),
        suspected.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Totals')
          ..add('cases', cases)
          ..add('closed', closed)
          ..add('current', current)
          ..add('mild', mild)
          ..add('mildPercent', mildPercent)
          ..add('deaths', deaths)
          ..add('deathsPercent', deathsPercent)
          ..add('recovered', recovered)
          ..add('recoveredPercent', recoveredPercent)
          ..add('serious', serious)
          ..add('seriousPercent', seriousPercent)
          ..add('suspected', suspected))
        .toString();
  }
}

class TotalsBuilder implements Builder<Totals, TotalsBuilder> {
  _$Totals _$v;

  Left<String, dynamic> _cases;
  Left<String, dynamic> get cases => _$this._cases;
  set cases(Left<String, dynamic> cases) => _$this._cases = cases;

  Left<String, dynamic> _closed;
  Left<String, dynamic> get closed => _$this._closed;
  set closed(Left<String, dynamic> closed) => _$this._closed = closed;

  Left<String, dynamic> _current;
  Left<String, dynamic> get current => _$this._current;
  set current(Left<String, dynamic> current) => _$this._current = current;

  Left<String, dynamic> _mild;
  Left<String, dynamic> get mild => _$this._mild;
  set mild(Left<String, dynamic> mild) => _$this._mild = mild;

  Left<String, dynamic> _mildPercent;
  Left<String, dynamic> get mildPercent => _$this._mildPercent;
  set mildPercent(Left<String, dynamic> mildPercent) =>
      _$this._mildPercent = mildPercent;

  Left<String, dynamic> _deaths;
  Left<String, dynamic> get deaths => _$this._deaths;
  set deaths(Left<String, dynamic> deaths) => _$this._deaths = deaths;

  Left<String, dynamic> _deathsPercent;
  Left<String, dynamic> get deathsPercent => _$this._deathsPercent;
  set deathsPercent(Left<String, dynamic> deathsPercent) =>
      _$this._deathsPercent = deathsPercent;

  Left<String, dynamic> _recovered;
  Left<String, dynamic> get recovered => _$this._recovered;
  set recovered(Left<String, dynamic> recovered) =>
      _$this._recovered = recovered;

  Left<String, dynamic> _recoveredPercent;
  Left<String, dynamic> get recoveredPercent => _$this._recoveredPercent;
  set recoveredPercent(Left<String, dynamic> recoveredPercent) =>
      _$this._recoveredPercent = recoveredPercent;

  Left<String, dynamic> _serious;
  Left<String, dynamic> get serious => _$this._serious;
  set serious(Left<String, dynamic> serious) => _$this._serious = serious;

  Left<String, dynamic> _seriousPercent;
  Left<String, dynamic> get seriousPercent => _$this._seriousPercent;
  set seriousPercent(Left<String, dynamic> seriousPercent) =>
      _$this._seriousPercent = seriousPercent;

  Left<String, dynamic> _suspected;
  Left<String, dynamic> get suspected => _$this._suspected;
  set suspected(Left<String, dynamic> suspected) =>
      _$this._suspected = suspected;

  TotalsBuilder();

  TotalsBuilder get _$this {
    if (_$v != null) {
      _cases = _$v.cases;
      _closed = _$v.closed;
      _current = _$v.current;
      _mild = _$v.mild;
      _mildPercent = _$v.mildPercent;
      _deaths = _$v.deaths;
      _deathsPercent = _$v.deathsPercent;
      _recovered = _$v.recovered;
      _recoveredPercent = _$v.recoveredPercent;
      _serious = _$v.serious;
      _seriousPercent = _$v.seriousPercent;
      _suspected = _$v.suspected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Totals other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Totals;
  }

  @override
  void update(void Function(TotalsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Totals build() {
    final _$result = _$v ??
        new _$Totals._(
            cases: cases,
            closed: closed,
            current: current,
            mild: mild,
            mildPercent: mildPercent,
            deaths: deaths,
            deathsPercent: deathsPercent,
            recovered: recovered,
            recoveredPercent: recoveredPercent,
            serious: serious,
            seriousPercent: seriousPercent,
            suspected: suspected);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
