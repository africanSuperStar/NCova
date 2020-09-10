import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/time.dart';
import '../../../home/presentation/bloc/bloc.dart';
import '../../data/models/models.dart';
import '../bloc/intl/bloc.dart';
import '../pages/status_charts_screen.dart';
import '../pages/status_detail_screen.dart';

class GlobalStatusCard extends StatefulWidget {
  final AnimationController animationController;
  final Status intl;

  GlobalStatusCard({@required this.intl, @required this.animationController})
      : assert(intl != null),
        assert(animationController != null);

  @override
  _GlobalStatusCardState createState() => _GlobalStatusCardState();
}

class _GlobalStatusCardState extends State<GlobalStatusCard> with SingleTickerProviderStateMixin {
  NavigatorService _service;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  void _showGlobalDetailPage({List<Status> intl}) {
    setState(() {
      widget.animationController.reverse();
      _service.previousPages.add(_service.currentPage);
      _service.currentPage = GlobalDetailScreen(
        currentIntl: intl.last,
      );
      BlocProvider.of<HomeBloc>(context).add(NavigateToStatus());
    });
  }

  void _showGlobalChartsPage(IntlState state) {
    setState(() {
      widget.animationController.reverse();
      _service.previousPages.add(_service.currentPage);
      _service.currentPage = GlobalChartsScreen();
      if (state is IntlLoaded) {
        BlocProvider.of<HomeBloc>(context).add(
          NavigateToGlobalCharts(intl: state.intl),
        );
      } else if (state is GlobalIntlHistoriesLoaded) {
        BlocProvider.of<HomeBloc>(context).add(
          NavigateToGlobalCharts(intl: state.intl),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return BlocBuilder<IntlBloc, IntlState>(
      builder: (context, state) {
        if (state is IntlLoaded) {
          return _intlStatusCard(state);
        } else if (state is GlobalIntlDetailsLoaded) {
          return _intlStatusCard(state);
        } else if (state is GlobalIntlHistoriesLoaded) {
          return _intlStatusCard(state);
        } else if (state is GlobalIntlChartsLoaded) {
          _showGlobalChartsPage(state);
          return GlobalChartsScreen();
        } else {
          BlocProvider.of<IntlBloc>(context).add(LoadIntl());
          return LoadingIndicator(
            color: DaintyColors.primary,
          );
        }
      },
    );
  }

  Widget _intlStatusCard(IntlState state) {
    return GestureDetector(
      onTap: () => _showGlobalDetailPage(intl: state.intl),
      child: Center(
        child: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: DaintyColors.nearlyWhite,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0), topRight: Radius.circular(30.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: DaintyColors.grey.withOpacity(0.2), offset: Offset(1.1, 1.1), blurRadius: 10.0),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    _topCardDetailedSection(),
                    _midSectionGridView(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _topCardDetailedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8, top: 16),
              child: AutoSizeText(
                'COVID-19',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: DaintyColors.primary),
                minFontSize: 14,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
              child: AutoSizeText(
                'Last Changed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: DaintyColors.lightText,
                ),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 16, bottom: 4.0),
              child: AutoSizeText(
                'Last Checked At',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: DaintyColors.lightText,
                ),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: DaintyColors.grey.withOpacity(0.5),
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: AutoSizeText(
                          ReadTimestamp.readTimestamp(int.tryParse(widget.intl.createdAt?.value ?? '0')),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.0,
                            color: DaintyColors.lightText,
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: DaintyColors.grey.withOpacity(0.5),
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: AutoSizeText(
                          ReadTimestamp.readTimestamp(int.tryParse(widget.intl.checkedAt?.value ?? '0')),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            letterSpacing: 0.0,
                            color: DaintyColors.lightText,
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _midSectionGridView() {
    return SizedBox(
      height: 140,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 5,
        crossAxisCount: 2,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 17),
            child: _leftMidSectionColumn(),
          ),
          _rightMidSectionColumn(),
        ],
      ),
    );
  }

  Widget _leftMidSectionColumn() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AutoSizeText(
              widget.intl.totals != null && widget.intl.totals.value?.cases != null && widget.intl.totals.value.cases.value.isNotEmpty ? widget.intl.totals.value.cases?.value ?? '0' : '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: DaintyColors.darkerText,
              ),
            ),
            AutoSizeText(
              'cases',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.2,
                color: DaintyColors.lightText,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AutoSizeText(
              widget.intl.totals != null && widget.intl.totals.value?.deaths != null && widget.intl.totals.value.deaths.value.isNotEmpty ? widget.intl.totals.value.deaths?.value ?? '0' : '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: DaintyColors.darkerText,
              ),
            ),
            AutoSizeText(
              'deaths',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.2,
                color: DaintyColors.lightText,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AutoSizeText(
              widget.intl.totals != null && widget.intl.totals.value?.recovered != null && widget.intl.totals.value.recovered.value.isNotEmpty ? widget.intl.totals.value.recovered?.value ?? '0' : '0',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: -0.2,
                color: DaintyColors.darkText,
              ),
            ),
            AutoSizeText(
              'recovered',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.2,
                color: DaintyColors.lightText,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AutoSizeText(
              widget.intl.totals != null && widget.intl.totals.value?.serious != null && widget.intl.totals.value.serious.value.isNotEmpty ? widget.intl.totals.value.serious?.value ?? '0' : '0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                letterSpacing: -0.2,
                color: DaintyColors.darkText,
              ),
            ),
            AutoSizeText(
              'serious',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.2,
                color: DaintyColors.lightText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _rightMidSectionColumn() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AutoSizeText(
                'Day',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: DaintyColors.darkerText,
                ),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AutoSizeText(
                'Week',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: DaintyColors.darkerText,
                ),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: AutoSizeText(
                'Month',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: DaintyColors.darkerText,
                ),
                minFontSize: 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // cases
        _dayWeekMonthDiffView(
          widget.intl.diffs != null && widget.intl.diffs.value?.day != null ? widget.intl.diffs.value.day.value.cases?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.week != null ? widget.intl.diffs.value.week.value.cases?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.month != null ? widget.intl.diffs.value.month.value.cases?.value : '...',
        ),
        // deaths
        _dayWeekMonthDiffView(
          widget.intl.diffs != null && widget.intl.diffs.value?.day != null ? widget.intl.diffs.value.day.value.deaths?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.week != null ? widget.intl.diffs.value.week.value.deaths?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.month != null ? widget.intl.diffs.value.month.value.deaths?.value : '...',
        ),
        // recovered
        _dayWeekMonthDiffView(
          widget.intl.diffs != null && widget.intl.diffs.value?.day != null ? widget.intl.diffs.value.day.value.recovered?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.week != null ? widget.intl.diffs.value.week.value.recovered?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.month != null ? widget.intl.diffs.value.month.value.recovered?.value : '...',
        ),
        // serious
        _dayWeekMonthDiffView(
          widget.intl.diffs != null && widget.intl.diffs.value?.day != null ? widget.intl.diffs.value.day.value.serious?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.week != null ? widget.intl.diffs.value.week.value.serious?.value : '...',
          widget.intl.diffs != null && widget.intl.diffs.value?.month != null ? widget.intl.diffs.value.month.value.serious?.value : '...',
        ),
      ],
    );
  }

  Widget _dayWeekMonthDiffView(String day, String week, String month) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 9.5, left: 2, right: 2),
          child: AutoSizeText(
            day != null && day != 'false' ? day : '...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: DaintyColors.darkerText,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.5, left: 2, right: 2),
          child: AutoSizeText(
            week != null && week != 'false' ? week : '...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: DaintyColors.darkerText,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 9.5, left: 2, right: 2),
          child: AutoSizeText(
            month != null && month != 'false' ? month : '...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: DaintyColors.darkerText,
            ),
          ),
        ),
      ],
    );
  }
}
