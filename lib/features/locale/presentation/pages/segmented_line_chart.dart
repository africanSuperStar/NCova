import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../../../status/data/models/status_model.dart';

class SegmentsLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  static List<Status> statuses = [];

  SegmentsLineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SegmentsLineChart.withStatusData(List<Status> statuses) {
    return SegmentsLineChart(
      _layoutStatusData(statuses),
      animate: true,
    );
  }

  factory SegmentsLineChart.withIntlData(List<Status> intl) {
    return SegmentsLineChart(
      _layoutIntlData(intl),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(
      seriesList,
      defaultRenderer: charts.LineRendererConfig(includeArea: true, stacked: true),
      animate: animate,
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.inside,
          desiredMaxRows: 2,
        ),
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearStatusCases, int>> _layoutStatusData(List<Status> statuses) {
    // Series of data with static dash pattern and stroke width. The colorFn
    // accessor will colorize each datum (for all three series).
    statuses.removeWhere((val) => val == null);

    final statusChangeData = statuses
        .map(
          (status) => LinearStatusCases(
            deaths: int.tryParse(status.totals != null && status.totals.isLeft() ? status.totals.value.deaths?.value : '...') ?? 0,
            cases: int.tryParse(status.totals != null && status.totals.isLeft() ? status.totals.value.cases?.value : '...') ?? 0,
            serious: int.tryParse(status.totals != null && status.totals.isLeft() ? status.totals.value.serious?.value : '...') ?? 0,
            recovered: int.tryParse(status.totals != null && status.totals.isLeft() ? status.totals.value.recovered?.value : '...') ?? 0,
            strokeWidthPx: 2.0,
          ),
        )
        .toList();

    statusChangeData.sort((s1, s2) => s1.cases.compareTo(s2.cases));

    // Generate 2 shades of each color so that we can style the line segments.
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final green = charts.MaterialPalette.green.makeShades(2);
    final orange = charts.MaterialPalette.deepOrange.makeShades(2);

    return [
      charts.Series<LinearStatusCases, int>(
        id: 'Deaths',
        colorFn: (LinearStatusCases status, _) => status.deaths % 2 == 0 ? green[1] : green[0],
        strokeWidthPxFn: (LinearStatusCases status, _) => status.strokeWidthPx,
        domainFn: (LinearStatusCases status, _) => status.cases,
        measureFn: (LinearStatusCases status, _) => status.deaths,
        data: statusChangeData,
      ),
      charts.Series<LinearStatusCases, int>(
        id: 'Serious',
        colorFn: (LinearStatusCases status, _) => status.serious % 2 == 0 ? orange[1] : orange[0],
        strokeWidthPxFn: (LinearStatusCases status, _) => status.strokeWidthPx,
        domainFn: (LinearStatusCases status, _) => status.cases,
        measureFn: (LinearStatusCases status, _) => status.serious,
        data: statusChangeData,
      ),
      charts.Series<LinearStatusCases, int>(
        id: 'Recovered',
        colorFn: (LinearStatusCases status, _) => status.recovered % 2 == 0 ? blue[1] : blue[0],
        strokeWidthPxFn: (LinearStatusCases status, _) => status.strokeWidthPx,
        domainFn: (LinearStatusCases status, _) => status.cases,
        measureFn: (LinearStatusCases status, _) => status.recovered,
        data: statusChangeData,
      ),
    ];
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearStatusCases, int>> _layoutIntlData(List<Status> intl) {
    // Series of data with static dash pattern and stroke width. The colorFn
    // accessor will colorize each datum (for all three series).
    intl.removeWhere((val) => val == null);

    final intlChangeData = intl
        .map(
          (intl) => LinearStatusCases(
            deaths: int.tryParse(intl.totals != null && intl.totals.isLeft() ? intl.totals.value.deaths?.value : 'Pending') ?? 0,
            cases: int.tryParse(intl.totals != null && intl.totals.isLeft() ? intl.totals.value.cases?.value : 'Pending') ?? 0,
            serious: int.tryParse(intl.totals != null && intl.totals.isLeft() ? intl.totals.value.serious?.value : 'Pending') ?? 0,
            recovered: int.tryParse(intl.totals != null && intl.totals.isLeft() ? intl.totals.value.recovered?.value : 'Pending') ?? 0,
            strokeWidthPx: 2.0,
          ),
        )
        .toList();

    intlChangeData.sort((s1, s2) => s1.cases.compareTo(s2.cases));

    // Generate 2 shades of each color so that we can style the line segments.
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final green = charts.MaterialPalette.green.makeShades(2);
    final orange = charts.MaterialPalette.deepOrange.makeShades(2);

    return [
      charts.Series<LinearStatusCases, int>(
        id: 'Deaths',
        colorFn: (LinearStatusCases status, _) => status.deaths % 2 == 0 ? green[1] : green[0],
        strokeWidthPxFn: (LinearStatusCases status, _) => status.strokeWidthPx,
        domainFn: (LinearStatusCases status, _) => status.cases,
        measureFn: (LinearStatusCases status, _) => status.deaths,
        data: intlChangeData,
      ),
      charts.Series<LinearStatusCases, int>(
        id: 'Serious',
        colorFn: (LinearStatusCases status, _) => status.serious % 2 == 0 ? orange[1] : orange[0],
        strokeWidthPxFn: (LinearStatusCases status, _) => status.strokeWidthPx,
        domainFn: (LinearStatusCases status, _) => status.cases,
        measureFn: (LinearStatusCases status, _) => status.serious,
        data: intlChangeData,
      ),
      charts.Series<LinearStatusCases, int>(
        id: 'Recovered',
        colorFn: (LinearStatusCases status, _) => status.recovered % 2 == 0 ? blue[1] : blue[0],
        strokeWidthPxFn: (LinearStatusCases status, _) => status.strokeWidthPx,
        domainFn: (LinearStatusCases status, _) => status.cases,
        measureFn: (LinearStatusCases status, _) => status.recovered,
        data: intlChangeData,
      ),
    ];
  }
}

class LinearStatusCases {
  final int deaths;
  final int recovered;
  final int serious;
  final int cases;
  final double strokeWidthPx;

  LinearStatusCases({this.deaths, this.cases, this.serious, this.recovered, this.strokeWidthPx});
}
