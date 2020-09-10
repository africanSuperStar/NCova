import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import '../../../status/presentation/pages/status_screen.dart';
import '../bloc/bloc.dart';
import '../widgets/bottom_navigationbar_view.dart';
import '../widgets/bottom_navigationbar_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  HomeBloc _homeBloc;

  AnimationController _animationController;

  NavigatorService _service;
  BottomNavigationBarWidget _bottomBar;

  @override
  initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _bottomBar = BottomNavigationBarWidget(
      animationController: _animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    if (_service.previousPages.isEmpty) {
      _service.previousPages.add(_service.currentPage);
      _service.currentPage = StatusScreen();
    }

    return BlocBuilder(
      bloc: _homeBloc,
      builder: (BuildContext context, HomeState state) {
        return buildHomePage(context);
      },
    );
  }

  Widget buildHomePage(BuildContext context) {
    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: DaintyColors.background,
          body: FutureBuilder(
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  GestureDetector(
                    onHorizontalDragEnd: BottomNavigationBarView.onHorizontalDragEnd,
                    child: _service.currentPage,
                  ),
                  _bottomBar,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
