import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uncovid/features/status/presentation/pages/status_screen.dart';

import '../../../../common/carousel_slider.dart';
import '../../../../common/loading_indicator.dart';
import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../bloc/status/bloc.dart';

class FlexibleSpace extends StatefulWidget {
  final AnimationController animationController;

  FlexibleSpace({
    this.animationController,
  });

  @override
  _FlexibleSpaceState createState() => _FlexibleSpaceState();
}

class _FlexibleSpaceState extends State<FlexibleSpace> with SingleTickerProviderStateMixin {
  NavigatorService _service;

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        if (state is StatusesLoading || state is StatusHistoriesLoaded) {
          BlocProvider.of<StatusBloc>(context).add(LoadRssFeed());
          return LoadingIndicator(
            color: DaintyColors.nearlyWhite,
          );
        } else if (state is StatusesLoaded && _service.currentPage is StatusScreen) {
          BlocProvider.of<StatusBloc>(context).add(LoadRssFeed());
          return LoadingIndicator(
            color: DaintyColors.nearlyWhite,
          );
        } else if (state is RssFeedLoaded) {
          return CarouselSlider.builder(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            enableInfiniteScroll: true,
            itemCount: state.rssFeed.items.length,
            itemBuilder: (context, index) {
              return ListView(
                children: <Widget>[
                  Card(
                    elevation: 3,
                    color: DaintyColors.nearlyWhite,
                    child: ListTile(
                      title: Text(
                        state.rssFeed.items[index].title,
                        style: TextStyle(color: DaintyColors.darkerText),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          BlocProvider.of<StatusBloc>(context).add(LoadRssFeed());
          return LoadingIndicator(
            color: DaintyColors.nearlyWhite,
          );
        }
      },
    );
  }
}
