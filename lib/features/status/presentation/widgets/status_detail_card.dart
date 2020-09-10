import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/time.dart';
import '../../data/models/models.dart';
import '../bloc/status/bloc.dart';
import 'status_colors.dart';

class StatusDetailCard extends StatefulWidget {
  final Status status;
  final List<Status> statuses;
  final Function onTapCallback;

  const StatusDetailCard({
    Key key,
    this.onTapCallback,
    @required this.status,
    @required this.statuses,
  }) : super(key: key);

  @override
  _StatusDetailCardState createState() => _StatusDetailCardState();
}

class _StatusDetailCardState extends State<StatusDetailCard> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  IconData favoritedIcon;

  final MAX_CASES = 50000;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(seconds: 1), vsync: this);

    animation = Tween<double>(begin: 40.0, end: 100).animate(
      animationController,
    )..addListener(
        () {
          setState(() {});
        },
      );

    animationController.forward(from: 0.0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onTapSource() async {
    final link = widget.status.source != null && widget.status.source.value != null && widget.status.source.value.isNotEmpty ? widget.status.source.value ?? '' : '';

    if (await canLaunch(link)) {
      await launch(link);
    } else {
      final snackBar = SnackBar(content: Text('Unable to launch the source url!'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        Widget _detailWidget;

        if (state is StatusHistoriesLoaded) {
          _detailWidget = Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: _rightMidSectionColumn(widget.status),
          );
        } else {
          _detailWidget = Container();
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              color: DaintyColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(color: DaintyColors.grey.withOpacity(0.2), offset: Offset(1.1, 1.1), blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _rightHandColumn(_detailWidget),
                  ],
                ),
                (state is StatusHistoriesLoaded) ? _sourceHandle(widget.status) : LimitedBox(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _sourceHandle(Status status) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: _onTapSource,
        child: Container(
          width: MediaQuery.of(context).size.width - 100,
          child: AutoSizeText(
            widget.status.source != null && widget.status.source.value != null && widget.status.source.value.isNotEmpty ? widget.status.source.value ?? 'Source Unavailable' : 'Source Unavailable',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 18,
              letterSpacing: -0.2,
              color: StatusColors(status: status).cases(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _rightHandColumn(Widget detailWidget) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    widget.status.name?.value ?? '',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, letterSpacing: -0.1, color: DaintyColors.darkText),
                  ),
                ),
              ],
            ),
            Container(height: 8.0),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Wrap(
                  children: <Widget>[
                    AutoSizeText(
                      'Last Changed',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.0,
                        color: DaintyColors.grey.withOpacity(0.8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: AutoSizeText(
                        ReadTimestamp.readTimestamp(int.tryParse(widget.status.createdAt != null && widget.status.createdAt.isLeft() ? widget.status.createdAt?.value : '') ?? 0),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: 0.0,
                          color: DaintyColors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(width: 10),
                Wrap(
                  children: <Widget>[
                    AutoSizeText(
                      'Last Checked',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 0.0,
                        color: DaintyColors.grey.withOpacity(0.8),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: AutoSizeText(
                        ReadTimestamp.readTimestamp(int.tryParse(widget.status.checkedAt != null && widget.status.checkedAt.isLeft() ? widget.status.checkedAt?.value : '') ?? 0),
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          letterSpacing: 0.0,
                          color: DaintyColors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                AutoSizeText(
                  widget.status.totals != null && widget.status.totals.value?.cases != null && widget.status.totals.value.cases.value.isNotEmpty ? widget.status.totals.value.cases?.value ?? '0' : '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
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
                    color: DaintyColors.darkerText,
                  ),
                ),
                AutoSizeText(
                  widget.status.totals != null && widget.status.totals.value?.deaths != null && widget.status.totals.value.deaths.value.isNotEmpty
                      ? widget.status.totals.value.deaths?.value ?? '0'
                      : '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: StatusColors(status: widget.status).cases(),
                  ),
                ),
                AutoSizeText(
                  'deaths',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: StatusColors(status: widget.status).cases(),
                  ),
                ),
                AutoSizeText(
                  widget.status.totals != null && widget.status.totals.value?.serious != null && widget.status.totals.value.serious.value.isNotEmpty
                      ? widget.status.totals.value.serious?.value ?? '0'
                      : '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    letterSpacing: -0.2,
                    color: DaintyColors.darkText,
                  ),
                ),
                AutoSizeText(
                  'Serious',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: DaintyColors.grey.withOpacity(0.5),
                  ),
                ),
                AutoSizeText(
                  widget.status.totals != null && widget.status.totals.value?.recovered != null && widget.status.totals.value.recovered.value.isNotEmpty
                      ? widget.status.totals.value.recovered?.value ?? '0'
                      : '0',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: DaintyColors.darkText,
                  ),
                ),
                AutoSizeText(
                  'Recovered',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: DaintyColors.grey.withOpacity(0.5),
                  ),
                ),
              ],
            ),
            detailWidget,
          ],
        ),
      ),
    );
  }

  Widget _rightMidSectionColumn(Status status) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: AutoSizeText(
                'Last',
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
              padding: const EdgeInsets.only(left: 4.0),
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
              padding: const EdgeInsets.only(left: 4.0),
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
              padding: const EdgeInsets.only(left: 4.0, right: 10),
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
          'Cases:',
          status.diffs != null && status.diffs.value?.last != null ? status.diffs.value.last.value.cases?.value : '...',
          status.diffs != null && status.diffs.value?.day != null ? status.diffs.value.day.value.cases?.value : '...',
          status.diffs != null && status.diffs.value?.week != null ? status.diffs.value.week.value.cases?.value : '...',
          status.diffs != null && status.diffs.value?.month != null ? status.diffs.value.month.value.cases?.value : '...',
        ),
        // deaths
        _dayWeekMonthDiffView(
          'Deaths:',
          status.diffs != null && status.diffs.value?.last != null ? status.diffs.value.last.value.deaths?.value : '...',
          status.diffs != null && status.diffs.value?.day != null ? status.diffs.value.day.value.deaths?.value : '...',
          status.diffs != null && status.diffs.value?.week != null ? status.diffs.value.week.value.deaths?.value : '...',
          status.diffs != null && status.diffs.value?.month != null ? status.diffs.value.month.value.deaths?.value : '...',
        ),
        // recovered
        _dayWeekMonthDiffView(
          'Recovered:',
          status.diffs != null && status.diffs.value?.last != null ? status.diffs.value.last.value.recovered?.value : '...',
          status.diffs != null && status.diffs.value?.day != null ? status.diffs.value.day.value.recovered?.value : '...',
          status.diffs != null && status.diffs.value?.week != null ? status.diffs.value.week.value.recovered?.value : '...',
          status.diffs != null && status.diffs.value?.month != null ? status.diffs.value.month.value.recovered?.value : '...',
        ),
        // serious
        _dayWeekMonthDiffView(
          'Serious:',
          status.diffs != null && status.diffs.value?.last != null ? status.diffs.value.last.value.serious?.value : '...',
          status.diffs != null && status.diffs.value?.day != null ? status.diffs.value.day.value.serious?.value : '...',
          status.diffs != null && status.diffs.value?.week != null ? status.diffs.value.week.value.serious?.value : '...',
          status.diffs != null && status.diffs.value?.month != null ? status.diffs.value.month.value.serious?.value : '...',
        ),
      ],
    );
  }

  Widget _dayWeekMonthDiffView(String title, String last, String day, String week, String month) {
    return Row(
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.only(top: 9.5, left: 15, right: 10),
          child: AutoSizeText(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: StatusColors(status: widget.status).cases(),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 9.5, left: 15),
                child: AutoSizeText(
                  last != null && last != 'false' ? last : '...',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: DaintyColors.darkerText,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 9.5, right: 2),
                child: AutoSizeText(
                  day != null && day != 'false' ? day : '...',
                  textAlign: TextAlign.left,
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
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: DaintyColors.darkerText,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 9.5, left: 2, right: 20),
                child: AutoSizeText(
                  month != null && month != 'false' ? month : '...',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: DaintyColors.darkerText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
