import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/pull_to_refresh/handle_refresh.dart';
import '../../../../common/pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/time.dart';
import '../../../status/data/models/models.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import '../../../status/presentation/widgets/circular_status_stack_icon.dart';
import '../../../status/presentation/widgets/status_colors.dart';
import '../../../status/presentation/widgets/status_detail_card.dart';

class LocaleDetailScreen extends StatefulWidget {
  final Status selectedStatus;
  final List<Status> statuses;

  static int cardIndex;

  LocaleDetailScreen({this.statuses, this.selectedStatus});

  @override
  _LocaleDetailScreenState createState() => _LocaleDetailScreenState();
}

class _LocaleDetailScreenState extends State<LocaleDetailScreen> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _localeDetailRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  NavigatorService _service;
  Animation _animation;
  AnimationController _animationController;
  ScrollController _scrollController;

  GlobalKey<AnimatedListState> _key = GlobalKey();

  double CARD_HEIGHT = 70;
  double CARD_PADDING = 10;

  @override
  void initState() {
    _scrollController = ScrollController();
    _animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      _animationController,
    );
    _animationController.forward();
    LocaleDetailScreen.cardIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    _animationController.reverse();
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return SafeArea(
      child: BlocBuilder<StatusBloc, StatusesState>(
        builder: (context, state) {
          if (state is StatusHistoriesLoaded) {
            if (_service.currentPage != _service.previousPages.last) {
              _service.previousPages.add(_service.currentPage);
            }
            state.cleanStatuses();

            Status _headlineStatus;

            if (LocaleDetailScreen.cardIndex == 0 || state.statuses.length == 0) {
              _headlineStatus = widget.selectedStatus;
            } else {
              _headlineStatus = state.statuses.reversed.toList()[LocaleDetailScreen.cardIndex - 1];
            }

            return FadeTransition(
              opacity: _animation,
              child: LiquidPullToRefresh(
                height: 60,
                color: DaintyColors.primary,
                key: _localeDetailRefreshIndicatorKey,
                showChildOpacityTransition: false,
                onRefresh: () => handleRefresh(_localeDetailRefreshIndicatorKey, context),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        width: 375,
                        color: DaintyColors.primary,
                        child: detailCard(_headlineStatus),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 60),
                      sliver: SliverToBoxAdapter(
                        child: draggableColumn(widget.selectedStatus, state),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            _animationController.reverse();
            Timer(
              const Duration(milliseconds: 400),
              () {
                _animationController.forward();
                BlocProvider.of<StatusBloc>(context).add(LoadStatusHistories(selectedStatus: widget.selectedStatus));
              },
            );

            // To prevent glitching. Provide and empty state card.
            return FadeTransition(
              opacity: _animation,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      width: 375,
                      color: DaintyColors.primary,
                      child: detailCard(Status()),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: 60),
                    sliver: SliverToBoxAdapter(
                      child: draggableColumn(widget.selectedStatus, state),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget draggableColumn(Status status, StatusesState state) {
    if (state is StatusHistoriesLoaded) {
      return Container(
        height: MediaQuery.of(context).size.height - 300,
        child: Column(
          children: <Widget>[
            Expanded(
              child: localePage(
                state.statuses.reversed.toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      BlocProvider.of<StatusBloc>(context).add(LoadStatusHistories(selectedStatus: status));
      return Container();
    }
  }

  int _calculateScrollableIndex(ScrollMetrics scrollmetrics) {
    return (_scrollController.offset / (CARD_HEIGHT - CARD_PADDING)).round();
  }

  Widget localePage(List<Status> statuses) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
            } else if (scrollNotification is ScrollUpdateNotification) {
              setState(() {
                final cardIndex = _calculateScrollableIndex(scrollNotification.metrics);
                if (cardIndex < 0) {
                  LocaleDetailScreen.cardIndex = 0;
                } else if (cardIndex > statuses.length - 1) {
                  LocaleDetailScreen.cardIndex = statuses.length - 1;
                } else {
                  LocaleDetailScreen.cardIndex = cardIndex;
                }
                return true;
              });
            }
            return false;
          },
          child: ListView.builder(
            key: _key,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 300 - CARD_HEIGHT),
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            itemCount: statuses.length,
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _animation,
                child: Container(
                  height: 60,
                  child: _animatedBuilderChild(statuses, index),
                ),
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: child,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _animatedBuilderChild(List<Status> statuses, int index) {
    return Card(
      color: DaintyColors.nearlyWhite,
      key: ValueKey(
        statuses?.elementAt(index),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  statuses.elementAt(index).createdAt != null
                      ? ReadTimestamp.readTimestamp(
                          int.tryParse(
                            statuses.elementAt(index).createdAt?.value.toString() ?? '0',
                          ),
                        )
                      : '...',
                  style: TextStyle(color: DaintyColors.lightText, fontSize: 12),
                ),
              ),
            ),
            _titleAndValue(
              'Cases:',
              statuses.elementAt(index).totals != null && statuses.elementAt(index).totals.isLeft() ? statuses.elementAt(index).totals.value.cases?.value : '...',
              statuses.elementAt(index),
            ),
            _titleAndValue(
              'Deaths: ',
              statuses.elementAt(index).totals != null && statuses.elementAt(index).totals.isLeft() ? statuses.elementAt(index).totals.value.deaths?.value : '...',
              statuses.elementAt(index),
            ),
            _titleAndValue(
              'Serious: ',
              statuses.elementAt(index).totals != null && statuses.elementAt(index).totals.isLeft() ? statuses.elementAt(index).totals.value.serious?.value : '...',
              statuses.elementAt(index),
            ),
            _titleAndValue(
              'Recovered: ',
              statuses.elementAt(index).totals != null && statuses.elementAt(index).totals.isLeft() ? statuses.elementAt(index).totals.value.recovered?.value : '...',
              statuses.elementAt(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleAndValue(String title, String value, Status status) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title ?? '',
            style: TextStyle(color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            value ?? '',
            style: TextStyle(color: StatusColors(status: status).cases()),
          ),
        ),
      ],
    );
  }

  Widget detailCard(Status status) {
    return Stack(
      children: <Widget>[
        Center(
          child: LimitedBox(
            key: ValueKey(
              status,
            ),
            child: StatusDetailCard(
              status: status,
              statuses: [],
            ),
          ),
        ),
        CircularStatusStackIcon(offset: Offset(MediaQuery.of(context).size.width / 2 - 40, 15.0), status: status),
      ],
      overflow: Overflow.clip,
    );
  }
}
