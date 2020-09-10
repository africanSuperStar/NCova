// GENERATED CODE - DO NOT MODIFY BY HAND

part of status;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Status extends Status {
  @override
  final String id;
  @override
  final Left<String, dynamic> a3;
  @override
  final Left<String, dynamic> createdAt;
  @override
  final Left<String, dynamic> checkedAt;
  @override
  final bool favorited;
  @override
  final Left<bool, dynamic> present;
  @override
  final Left<String, dynamic> name;
  @override
  final Left<bool, dynamic> neighbour;
  @override
  final Left<String, dynamic> region;
  @override
  final Left<String, dynamic> status;
  @override
  final Left<BuiltList<String>, dynamic> neighbours;
  @override
  final Left<String, dynamic> source;
  @override
  final Left<Totals, dynamic> totals;
  @override
  final Left<Stats, dynamic> stats;
  @override
  final Left<Diffs, dynamic> diffs;
  @override
  final Left<Versus, dynamic> versus;

  factory _$Status([void Function(StatusBuilder) updates]) =>
      (new StatusBuilder()..update(updates)).build();

  _$Status._(
      {this.id,
      this.a3,
      this.createdAt,
      this.checkedAt,
      this.favorited,
      this.present,
      this.name,
      this.neighbour,
      this.region,
      this.status,
      this.neighbours,
      this.source,
      this.totals,
      this.stats,
      this.diffs,
      this.versus})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Status', 'id');
    }
  }

  @override
  Status rebuild(void Function(StatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StatusBuilder toBuilder() => new StatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Status &&
        id == other.id &&
        a3 == other.a3 &&
        createdAt == other.createdAt &&
        checkedAt == other.checkedAt &&
        favorited == other.favorited &&
        present == other.present &&
        name == other.name &&
        neighbour == other.neighbour &&
        region == other.region &&
        status == other.status &&
        neighbours == other.neighbours &&
        source == other.source &&
        totals == other.totals &&
        stats == other.stats &&
        diffs == other.diffs &&
        versus == other.versus;
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
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(0,
                                                                    id.hashCode),
                                                                a3.hashCode),
                                                            createdAt.hashCode),
                                                        checkedAt.hashCode),
                                                    favorited.hashCode),
                                                present.hashCode),
                                            name.hashCode),
                                        neighbour.hashCode),
                                    region.hashCode),
                                status.hashCode),
                            neighbours.hashCode),
                        source.hashCode),
                    totals.hashCode),
                stats.hashCode),
            diffs.hashCode),
        versus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Status')
          ..add('id', id)
          ..add('a3', a3)
          ..add('createdAt', createdAt)
          ..add('checkedAt', checkedAt)
          ..add('favorited', favorited)
          ..add('present', present)
          ..add('name', name)
          ..add('neighbour', neighbour)
          ..add('region', region)
          ..add('status', status)
          ..add('neighbours', neighbours)
          ..add('source', source)
          ..add('totals', totals)
          ..add('stats', stats)
          ..add('diffs', diffs)
          ..add('versus', versus))
        .toString();
  }
}

class StatusBuilder implements Builder<Status, StatusBuilder> {
  _$Status _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  Left<String, dynamic> _a3;
  Left<String, dynamic> get a3 => _$this._a3;
  set a3(Left<String, dynamic> a3) => _$this._a3 = a3;

  Left<String, dynamic> _createdAt;
  Left<String, dynamic> get createdAt => _$this._createdAt;
  set createdAt(Left<String, dynamic> createdAt) =>
      _$this._createdAt = createdAt;

  Left<String, dynamic> _checkedAt;
  Left<String, dynamic> get checkedAt => _$this._checkedAt;
  set checkedAt(Left<String, dynamic> checkedAt) =>
      _$this._checkedAt = checkedAt;

  bool _favorited;
  bool get favorited => _$this._favorited;
  set favorited(bool favorited) => _$this._favorited = favorited;

  Left<bool, dynamic> _present;
  Left<bool, dynamic> get present => _$this._present;
  set present(Left<bool, dynamic> present) => _$this._present = present;

  Left<String, dynamic> _name;
  Left<String, dynamic> get name => _$this._name;
  set name(Left<String, dynamic> name) => _$this._name = name;

  Left<bool, dynamic> _neighbour;
  Left<bool, dynamic> get neighbour => _$this._neighbour;
  set neighbour(Left<bool, dynamic> neighbour) => _$this._neighbour = neighbour;

  Left<String, dynamic> _region;
  Left<String, dynamic> get region => _$this._region;
  set region(Left<String, dynamic> region) => _$this._region = region;

  Left<String, dynamic> _status;
  Left<String, dynamic> get status => _$this._status;
  set status(Left<String, dynamic> status) => _$this._status = status;

  Left<BuiltList<String>, dynamic> _neighbours;
  Left<BuiltList<String>, dynamic> get neighbours => _$this._neighbours;
  set neighbours(Left<BuiltList<String>, dynamic> neighbours) =>
      _$this._neighbours = neighbours;

  Left<String, dynamic> _source;
  Left<String, dynamic> get source => _$this._source;
  set source(Left<String, dynamic> source) => _$this._source = source;

  Left<Totals, dynamic> _totals;
  Left<Totals, dynamic> get totals => _$this._totals;
  set totals(Left<Totals, dynamic> totals) => _$this._totals = totals;

  Left<Stats, dynamic> _stats;
  Left<Stats, dynamic> get stats => _$this._stats;
  set stats(Left<Stats, dynamic> stats) => _$this._stats = stats;

  Left<Diffs, dynamic> _diffs;
  Left<Diffs, dynamic> get diffs => _$this._diffs;
  set diffs(Left<Diffs, dynamic> diffs) => _$this._diffs = diffs;

  Left<Versus, dynamic> _versus;
  Left<Versus, dynamic> get versus => _$this._versus;
  set versus(Left<Versus, dynamic> versus) => _$this._versus = versus;

  StatusBuilder();

  StatusBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _a3 = _$v.a3;
      _createdAt = _$v.createdAt;
      _checkedAt = _$v.checkedAt;
      _favorited = _$v.favorited;
      _present = _$v.present;
      _name = _$v.name;
      _neighbour = _$v.neighbour;
      _region = _$v.region;
      _status = _$v.status;
      _neighbours = _$v.neighbours;
      _source = _$v.source;
      _totals = _$v.totals;
      _stats = _$v.stats;
      _diffs = _$v.diffs;
      _versus = _$v.versus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Status other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Status;
  }

  @override
  void update(void Function(StatusBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Status build() {
    final _$result = _$v ??
        new _$Status._(
            id: id,
            a3: a3,
            createdAt: createdAt,
            checkedAt: checkedAt,
            favorited: favorited,
            present: present,
            name: name,
            neighbour: neighbour,
            region: region,
            status: status,
            neighbours: neighbours,
            source: source,
            totals: totals,
            stats: stats,
            diffs: diffs,
            versus: versus);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
