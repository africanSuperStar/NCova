import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../common/pull_to_refresh/handle_refresh.dart';
import '../../../../common/pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/time.dart';
import '../../data/models/models.dart';
import '../bloc/intl/bloc.dart';
import '../widgets/global_status_card.dart';

class GlobalDetailScreen extends StatefulWidget {
  final Status currentIntl;

  GlobalDetailScreen({this.currentIntl});

  @override
  _GlobalDetailScreenState createState() => _GlobalDetailScreenState();
}

class _GlobalDetailScreenState extends State<GlobalDetailScreen> with TickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _globalDetailRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  NavigatorService _service;
  Animation _animation;
  AnimationController _animationController;
  ScrollController _scrollController;

  GlobalKey<AnimatedListState> _key = GlobalKey();

  double CARD_HEIGHT = 70;
  double CARD_PADDING = 10;
  int CARD_INDEX = 0;

  @override
  void initState() {
    _scrollController = ScrollController();
    _animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      _animationController,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return SafeArea(
      child: BlocBuilder<IntlBloc, IntlState>(
        builder: (context, state) {
          if (state is GlobalIntlHistoriesLoaded) {
            _service.previousPages.add(_service.currentPage);
            state.cleanIntl();

            Status _headlineIntl;
            if (state.intl.length == 0) {
              _headlineIntl = widget.currentIntl;
            } else {
              _headlineIntl = state.intl.reversed.toList()[CARD_INDEX];
            }

            return FadeTransition(
              opacity: _animation,
              child: LiquidPullToRefresh(
                height: 60,
                color: DaintyColors.primary,
                key: _globalDetailRefreshIndicatorKey,
                showChildOpacityTransition: false,
                onRefresh: () => handleRefresh(_globalDetailRefreshIndicatorKey, context),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        width: 375,
                        height: 270,
                        color: DaintyColors.primary,
                        child: detailCard(_headlineIntl),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 60),
                      sliver: SliverToBoxAdapter(
                        child: draggableColumn(state),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            BlocProvider.of<IntlBloc>(context).add(LoadGlobalIntlHistories());
            return Padding(
              padding: EdgeInsets.all(10),
              child: LoadingIndicator(
                color: DaintyColors.primary,
              ),
            );
          }
        },
      ),
    );
  }

  Widget draggableColumn(IntlState state) {
    if (state is GlobalIntlHistoriesLoaded) {
      return Container(
        height: MediaQuery.of(context).size.height - 300,
        child: Column(
          children: <Widget>[
            Expanded(
              child: localePage(
                state.intl.reversed.toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      BlocProvider.of<IntlBloc>(context).add(LoadGlobalIntlHistories());
      return LoadingIndicator(color: DaintyColors.primary);
    }
  }

  int _calculateScrollableIndex(ScrollMetrics scrollmetrics) {
    return (_scrollController.offset / (CARD_HEIGHT - CARD_PADDING)).round();
  }

  Widget localePage(List<Status> intl) {
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
                  CARD_INDEX = 0;
                } else if (cardIndex > intl.length - 1) {
                  CARD_INDEX = intl.length - 1;
                } else {
                  CARD_INDEX = cardIndex;
                }
                return true;
              });
            }
            return false;
          },
          child: Center(
            child: ListView.builder(
              key: _key,
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 300 - CARD_HEIGHT),
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: intl.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _animation,
                  child: Container(
                    height: 60,
                    child: _animatedBuilderChild(intl, index),
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
      ),
    );
  }

  Widget _animatedBuilderChild(List<Status> intl, int index) {
    return Card(
      color: DaintyColors.nearlyWhite,
      key: ValueKey(
        intl?.elementAt(index),
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
                  ReadTimestamp.readTimestamp(int.tryParse(intl.elementAt(index).createdAt?.value.toString() ?? '0')),
                  style: TextStyle(color: DaintyColors.lightText, fontSize: 12),
                ),
              ),
            ),
            _titleAndValue('Cases:', intl.elementAt(index).totals != null ? intl.elementAt(index).totals.value.cases?.value : 'Pending'),
            _titleAndValue('Deaths: ', intl.elementAt(index).totals != null ? intl.elementAt(index).totals.value.deaths?.value : 'Pending'),
            _titleAndValue('Serious: ', intl.elementAt(index).totals != null ? intl.elementAt(index).totals.value.serious?.value : 'Pending'),
            _titleAndValue('Recovered: ', intl.elementAt(index).totals != null ? intl.elementAt(index).totals.value.recovered?.value : 'Pending'),
          ],
        ),
      ),
    );
  }

  Widget _titleAndValue(String title, String value) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: TextStyle(color: Colors.black87),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            value,
            style: TextStyle(color: DaintyColors.primary),
          ),
        ),
      ],
    );
  }

  Widget detailCard(Status intl) {
    return Center(
      child: SizedBox(
        width: 375,
        height: 300,
        key: ValueKey(
          intl,
        ),
        child: GlobalStatusCard(
          intl: intl,
          animationController: _animationController,
        ),
      ),
    );
  }
}
