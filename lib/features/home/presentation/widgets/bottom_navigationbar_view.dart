import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../info/presentation/pages/info_screen.dart';
import '../../../locale/presentation/pages/locale_detail_screen.dart';
import '../../../locale/presentation/pages/locale_screen.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import '../../../status/presentation/pages/status_news_screen.dart';
import '../../../status/presentation/pages/status_screen.dart';
import '../../data/models/tab_icons.dart';
import '../bloc/bloc.dart';
import 'internal/tab_bar.dart';
import 'paint/half_clipper.dart';
import 'paint/half_painter.dart';

const double CIRCLE_SIZE = 60;
const double ARC_HEIGHT = 70;
const double ARC_WIDTH = 90;
const double CIRCLE_OUTLINE = 10;
const double SHADOW_ALLOWANCE = 20;
const double BAR_HEIGHT = 60;

class BottomNavigationBarView extends StatefulWidget {
  BottomNavigationBarView({
    @required this.tabs,
    @required this.key,
    @required this.animationController,
    this.initialSelection = 0,
  })  : assert(animationController != null),
        assert(tabs != null),
        assert(tabs.length > 1 && tabs.length < 5);

  final AnimationController animationController;
  final List<TabIconData> tabs;
  final int initialSelection;

  static void Function(DragEndDetails details) onHorizontalDragEnd;

  static int tabSelection = 1;

  final Key key;

  @override
  BottomNavigationBarViewState createState() => BottomNavigationBarViewState();
}

class BottomNavigationBarViewState extends State<BottomNavigationBarView> with TickerProviderStateMixin, RouteAware {
  String nextIcon = "assets/images/tab_1.png";
  String activeIcon = "assets/images/tab_1.png";

  int currentSelected = 0;
  double _circleAlignX = 0;
  double _circleIconAlpha = 1;

  Color circleColor;
  Color activeIconColor;
  Color inactiveIconColor;
  Color barBackgroundColor;
  Color textColor;

  NavigatorService _service;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeIcon = widget.tabs[currentSelected].imagePath;
    circleColor = DaintyColors.primary;
    activeIconColor = Colors.white;
    barBackgroundColor = Colors.white;
    textColor = DaintyColors.darkerText;
    inactiveIconColor = DaintyColors.primary;
  }

  @override
  void initState() {
    BottomNavigationBarView.onHorizontalDragEnd = _onHorizontalDragEnd;

    super.initState();
    _setSelected(widget.tabs[widget.initialSelection].key);
  }

  _setSelected(UniqueKey key) {
    int selected = widget.tabs.indexWhere((tabData) => tabData.key == key);

    if (mounted) {
      setState(() {
        currentSelected = selected;
        _circleAlignX = -1 + (2 / (widget.tabs.length - 1) * selected);
        nextIcon = widget.tabs[selected].imagePath;
      });
    }
  }

  void _setTabItemState(UniqueKey uniqueKey) {
    setState(() {
      if (BottomNavigationBarView.tabSelection == 0) {
        widget.animationController.reverse().then((data) {
          if (!mounted) return;
          setState(() {
            if (_service.currentPage is! InfoScreen && _service.currentPage is! LocaleScreen) {
              _service.previousPages.add(_service.currentPage);
            }
            _service.currentPage = LocaleScreen();
            BlocProvider.of<HomeBloc>(context).add(NavigateToLocale());
            BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
          });
        });
      } else if (BottomNavigationBarView.tabSelection == 1) {
        widget.animationController.reverse().then((data) {
          if (!mounted) return;
          setState(() {
            _service.previousPages.clear();
            _service.previousPages.add(_service.currentPage);
            _service.currentPage = StatusScreen();
            BlocProvider.of<HomeBloc>(context).add(NavigateToStatus());
          });
        });
      } else if (BottomNavigationBarView.tabSelection == 2) {
        widget.animationController.reverse().then((data) {
          if (!mounted) return;
          setState(() {
            if (_service.currentPage is! LocaleScreen) {
              _service.previousPages.add(_service.currentPage);
            }
            _service.currentPage = InfoScreen(
              animationController: widget.animationController,
            );
            BlocProvider.of<HomeBloc>(context).add(NavigateToInfo());
          });
        });
      }
    });
    _setSelected(uniqueKey);
    _initAnimationAndStart(_circleAlignX, 1);
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity > 10) {
      setState(() {
        if (BottomNavigationBarView.tabSelection == 1) {
          BottomNavigationBarView.tabSelection = 0;
          widget.animationController.reverse().then((data) {
            if (!mounted) return;
            setState(() {
              if (_service.currentPage is! InfoScreen && _service.currentPage is! LocaleScreen) {
                _service.previousPages.add(_service.currentPage);
              }
              _service.currentPage = LocaleScreen();
              BlocProvider.of<HomeBloc>(context).add(NavigateToLocale());
              BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
            });
          });
        } else if (BottomNavigationBarView.tabSelection == 2) {
          BottomNavigationBarView.tabSelection = 1;
          widget.animationController.reverse().then((data) {
            if (!mounted) return;
            setState(() {
              _service.previousPages.clear();
              _service.previousPages.add(_service.currentPage);
              _service.currentPage = StatusScreen();
              BlocProvider.of<HomeBloc>(context).add(NavigateToStatus());
            });
          });
        }
      });
    } else if (details.primaryVelocity < -10) {
      setState(() {
        if (BottomNavigationBarView.tabSelection == 0) {
          BottomNavigationBarView.tabSelection = 1;
          widget.animationController.reverse().then((data) {
            if (!mounted) return;
            setState(() {
              _service.previousPages.clear();
              _service.previousPages.add(_service.currentPage);
              _service.currentPage = StatusScreen();
              BlocProvider.of<HomeBloc>(context).add(NavigateToStatus());
            });
          });
        } else if (BottomNavigationBarView.tabSelection == 1) {
          BottomNavigationBarView.tabSelection = 2;
          widget.animationController.reverse().then((data) {
            if (!mounted) return;
            setState(() {
              if (_service.currentPage is! LocaleScreen) {
                _service.previousPages.add(_service.currentPage);
              }
              _service.currentPage = InfoScreen(
                animationController: widget.animationController,
              );
              BlocProvider.of<HomeBloc>(context).add(NavigateToInfo());
            });
          });
        }
      });
    }
    _setSelected(widget.tabs[BottomNavigationBarView.tabSelection].key);
    _initAnimationAndStart(_circleAlignX, 1);
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        _service.recyclingPopHandler = () => _onWillPop(
              context: context,
              state: state,
              service: _service,
              tabs: widget.tabs,
            );

        return WillPopScope(
          child: Stack(
            overflow: Overflow.visible,
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Container(
                height: BAR_HEIGHT,
                decoration: BoxDecoration(color: barBackgroundColor, boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)]),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: widget.tabs
                      .map(
                        (t) => TabItem(
                          uniqueKey: t.key,
                          selected: t.key == widget.tabs[currentSelected].key,
                          imagePath: t.imagePath,
                          title: t.title,
                          iconColor: inactiveIconColor,
                          textColor: textColor,
                          callbackFunction: (uniqueKey) {
                            // TODO: Fix this mess.
                            //
                            BottomNavigationBarView.tabSelection = widget.tabs.indexWhere((tabData) => tabData.key == uniqueKey);

                            _setTabItemState(uniqueKey);
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
              Positioned.fill(
                top: -(CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE) / 2,
                child: Container(
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: ANIM_DURATION),
                    curve: Curves.easeOut,
                    alignment: Alignment(_circleAlignX, 1),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: FractionallySizedBox(
                        widthFactor: 1 / widget.tabs.length,
                        child: GestureDetector(
                          onTap: widget.tabs[currentSelected].onclick,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE,
                                width: CIRCLE_SIZE + CIRCLE_OUTLINE + SHADOW_ALLOWANCE,
                                child: ClipRect(
                                    clipper: HalfClipper(),
                                    child: Container(
                                      child: Center(
                                        child: Container(
                                          width: CIRCLE_SIZE + CIRCLE_OUTLINE,
                                          height: CIRCLE_SIZE + CIRCLE_OUTLINE,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                  height: ARC_HEIGHT,
                                  width: ARC_WIDTH,
                                  child: CustomPaint(
                                    painter: HalfPainter(barBackgroundColor),
                                  )),
                              SizedBox(
                                height: CIRCLE_SIZE,
                                width: CIRCLE_SIZE,
                                child: Container(
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: ANIM_DURATION ~/ 5),
                                      opacity: _circleIconAlpha,
                                      child: Image.asset(activeIcon),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          onWillPop: _service.recyclingPopHandler,
        );
      },
    );
  }

  _initAnimationAndStart(double from, double to) {
    _circleIconAlpha = 0;

    Future.delayed(Duration(milliseconds: ANIM_DURATION ~/ 5), () {
      setState(() {
        activeIcon = nextIcon;
      });
    }).then((_) {
      Future.delayed(Duration(milliseconds: (ANIM_DURATION ~/ 5 * 3)), () {
        setState(() {
          _circleIconAlpha = 1;
        });
      });
    });
  }

  Future<bool> _onWillPop({
    BuildContext context,
    StatusesState state,
    NavigatorService service,
    List<TabIconData> tabs,
  }) {
    if (service.previousPages.length > 1) {
      service.currentPage = service.previousPages.last;
      service.previousPages.removeLast();
      if (service.currentPage is StatusScreen) {
        BottomNavigationBarView.tabSelection = 1;
        _setTabItemState(tabs[1].key);
        BlocProvider.of<HomeBloc>(context).add(NavigateToStatus());
      } else if (service.currentPage is StatusNewsScreen) {
        BlocProvider.of<HomeBloc>(context).add(NavigateToStatusNews());
      } else if (service.currentPage is LocaleScreen) {
        BottomNavigationBarView.tabSelection = 0;
        _setTabItemState(tabs[0].key);
        BlocProvider.of<HomeBloc>(context).add(NavigateToLocale());
      } else if (service.currentPage is LocaleDetailScreen) {
        service.currentPage = service.previousPages.last;
        service.previousPages.removeLast();
        BlocProvider.of<HomeBloc>(context).add(NavigateToLocale());
        BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
      } else if (service.currentPage is InfoScreen) {
        BottomNavigationBarView.tabSelection = 2;
        _setTabItemState(tabs[2].key);
        BlocProvider.of<HomeBloc>(context).add(NavigateToInfo());
      } else {
        BottomNavigationBarView.tabSelection = 1;
        _setTabItemState(tabs[1].key);
        BlocProvider.of<HomeBloc>(context).add(NavigateToStatus());
      }
      return Future.value(false);
    } else {
      return showDialog(
            context: context,
            builder: (context) => Platform.isIOS
                ? CupertinoAlertDialog(
                    title: Text(
                      'Are you sure want to close the unCOVID app?',
                      style: TextStyle(color: DaintyColors.darkerText),
                    ),
                    actions: <Widget>[
                      CupertinoButton(
                        child: Text(
                          "Keep Open",
                          style: TextStyle(color: DaintyColors.primary),
                        ),
                        onPressed: () => service.navigatorKey.currentState.pop(false),
                      ),
                      CupertinoButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: DaintyColors.primary),
                        ),
                        onPressed: () => exit(0),
                      ),
                    ],
                  )
                : AlertDialog(
                    title: Text(
                      'Are you sure want to close the unCOVID app?',
                      style: TextStyle(color: DaintyColors.darkerText),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Keep Open",
                          style: TextStyle(color: DaintyColors.primary),
                        ),
                        onPressed: () => service.navigatorKey.currentState.pop(false),
                      ),
                      FlatButton(
                        child: Text(
                          "Close",
                          style: TextStyle(color: DaintyColors.primary),
                        ),
                        onPressed: () => service.navigatorKey.currentState.pop(true),
                      ),
                    ],
                  ),
          ) ??
          false;
    }
  }
}
