import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../status/data/models/models.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../utils/colors.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import 'chart_scaffold.dart';
import 'segmented_line_chart.dart';

class LocaleChartsScreen extends StatelessWidget {
  final Status selectedStatus;

  LocaleChartsScreen({@required this.selectedStatus}) : assert(selectedStatus != null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        if (state is StatusChartsLoaded) {
          return GalleryScaffold(
            listTileIcon: Icon(Icons.insert_chart),
            title: 'Global Measures vs Number of Cases',
            selectedStatus: selectedStatus,
            childBuilder: () => new SegmentsLineChart.withStatusData(state.statuses),
          );
        } else {
          BlocProvider.of<StatusBloc>(context).add(
            LoadStatusCharts(selectedStatus: selectedStatus),
          );
          return LoadingIndicator(
            color: DaintyColors.primary,
          );
        }
      },
    );
  }
}
