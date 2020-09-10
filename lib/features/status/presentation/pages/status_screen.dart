import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../common/pull_to_refresh/handle_refresh.dart';
import '../../../../common/pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../home/presentation/bloc/bloc.dart';
import '../../../home/presentation/bloc/home_event.dart';
import '../bloc/intl/bloc.dart';
import '../widgets/flexible_space.dart';
import '../widgets/global_stats_card.dart';
import '../widgets/global_status_card.dart';
import 'status_news_screen.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _statusRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  AnimationController _controller;
  Animation _animation;
  NavigatorService _service;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _controller.forward();
    _animation = Tween<double>(begin: 0, end: 1.0).animate(
      _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapNewCard() {
    setState(() {
      if (_animation.value < 400.0) {
        _controller.forward();
        _service.previousPages.add(_service.currentPage);
        _service.currentPage = StatusNewsScreen();
        BlocProvider.of<HomeBloc>(context).add(NavigateToStatusNews());
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return AnimatedBuilder(
      animation: _animation,
      child: _nestedScrollView(),
      builder: (context, child) {
        return child;
      },
    );
  }

  Widget _nestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: SliverAppBar(
              flexibleSpace: GestureDetector(
                onTap: () => _onTapNewCard(),
                child: FlexibleSpace(
                  animationController: _controller,
                ),
              ),
              backgroundColor: DaintyColors.primary,
              expandedHeight: 64,
              floating: true,
              snap: true,
            ),
          ),
        ];
      },
      body: BlocBuilder<IntlBloc, IntlState>(
        builder: (context, state) {
          if (state is IntlLoading) {
            BlocProvider.of<IntlBloc>(context).add(LoadIntl());
            return LoadingIndicator(
              color: DaintyColors.primary,
            );
          } else if (state is IntlLoaded) {
            state.cleanIntl();
            final intl = state.intl.first;

            return FadeTransition(
              opacity: _animation,
              child: Container(
                padding: EdgeInsets.only(bottom: 60),
                child: LiquidPullToRefresh(
                  height: 60,
                  color: DaintyColors.primary,
                  key: GlobalKey<RefreshIndicatorState>(),
                  showChildOpacityTransition: false,
                  onRefresh: () => handleRefresh(_statusRefreshIndicatorKey, context),
                  child: ListView(
                    padding: EdgeInsets.all(20),
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: GlobalStatusCard(
                          intl: intl,
                          animationController: _controller,
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(top: 10, bottom: 10),
                      //   child: GlobalStatsCard(
                      //     intl: intl,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            BlocProvider.of<IntlBloc>(context).add(LoadIntl());
            return LoadingIndicator(
              color: DaintyColors.primary,
            );
          }
        },
      ),
    );
  }
}
