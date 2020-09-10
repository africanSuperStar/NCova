import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../utils/colors.dart';
import '../../../locale/presentation/pages/chart_scaffold.dart';
import '../../../locale/presentation/pages/segmented_line_chart.dart';
import '../bloc/intl/bloc.dart';

class GlobalChartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IntlBloc, IntlState>(
      builder: (context, state) {
        if (state is GlobalIntlChartsLoaded) {
          return GalleryScaffold(
            listTileIcon: Icon(Icons.insert_chart),
            title: 'Global Measures vs Number of Cases',
            childBuilder: () => new SegmentsLineChart.withIntlData(state.intl),
          );
        } else {
          BlocProvider.of<IntlBloc>(context).add(
            LoadGlobalIntlCharts(),
          );
          return LoadingIndicator(
            color: DaintyColors.primary,
          );
        }
      },
    );
  }
}
