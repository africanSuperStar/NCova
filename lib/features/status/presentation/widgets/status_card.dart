import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/time.dart';
import '../../data/models/models.dart';
import '../bloc/status/bloc.dart';
import 'circular_status_stack_icon.dart';
import 'status_colors.dart';

class StatusCard extends StatefulWidget {
  final Status status;
  final List<Status> statuses;
  final Function onTapCallback;

  const StatusCard({
    Key key,
    this.onTapCallback,
    @required this.status,
    @required this.statuses,
  }) : super(key: key);

  @override
  _StatusCardState createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> with TickerProviderStateMixin {
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

    if (widget.statuses.isNotEmpty) {
      final isFavorite = widget.statuses?.firstWhere((status) => status.name == widget.status.name)?.favorited ?? false;
      favoritedIcon = isFavorite ? Icons.star : Icons.star_border;
    }

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              color: DaintyColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(color: DaintyColors.grey.withOpacity(0.2), offset: Offset(1.1, 1.1), blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    widget.statuses.isNotEmpty
                        ? Center(
                            child: IconButton(
                              icon: Icon(
                                favoritedIcon,
                                color: Colors.orangeAccent,
                                size: 25,
                              ),
                              onPressed: widget.onTapCallback,
                            ),
                          )
                        : Container(),
                    _rightHandColumn(),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircularStatusStackIcon(status: widget.status),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _rightHandColumn() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: AutoSizeText(
                    widget.status.name?.value ?? '',
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, letterSpacing: -0.1, color: DaintyColors.darkText),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.access_time,
                        color: DaintyColors.grey.withOpacity(0.5),
                        size: 12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: AutoSizeText(
                        ReadTimestamp.readTimestamp(int.tryParse(widget.status.createdAt != null && widget.status.createdAt.isLeft() ? widget.status.createdAt?.value : '') ?? 0),
                        textAlign: TextAlign.center,
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
          ),
          Flexible(
            flex: 3,
            child: Table(
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    AutoSizeText(
                      widget.status.totals != null && widget.status.totals.value?.cases != null && widget.status.totals.value.cases.value.isNotEmpty
                          ? widget.status.totals.value.cases?.value ?? '0'
                          : '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: DaintyColors.darkerText,
                      ),
                    ),
                    AutoSizeText(
                      'cases',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
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
                        fontSize: 12,
                        color: StatusColors(status: widget.status).cases(),
                      ),
                    ),
                    AutoSizeText(
                      'deaths',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: StatusColors(status: widget.status).cases(),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    AutoSizeText(
                      widget.status.totals != null && widget.status.totals.value?.serious != null && widget.status.totals.value.serious.value.isNotEmpty
                          ? widget.status.totals.value.serious?.value ?? '0'
                          : '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: -0.2,
                        color: DaintyColors.darkText,
                      ),
                    ),
                    AutoSizeText(
                      'serious',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: DaintyColors.grey.withOpacity(0.5),
                      ),
                    ),
                    AutoSizeText(
                      widget.status.totals != null && widget.status.totals.value?.recovered != null && widget.status.totals.value.recovered.value.isNotEmpty
                          ? widget.status.totals.value.recovered?.value ?? '0'
                          : '0',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        letterSpacing: -0.2,
                        color: DaintyColors.darkText,
                      ),
                    ),
                    AutoSizeText(
                      'recovered',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: DaintyColors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
