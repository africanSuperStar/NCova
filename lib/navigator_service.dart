import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'utils/colors.dart';

class NavigatorProvider extends InheritedWidget {
  final NavigatorService service = NavigatorService();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  NavigatorProvider({Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static NavigatorProvider of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<NavigatorProvider>();
}

class NavigatorService {
  Function recyclingPopHandler = () {};

  CollectionReference statusCollection = Firestore.instance.collection('statusJHU');

  Widget currentPage = Container(
    color: DaintyColors.background,
  );

  List<Widget> previousPages = <Widget>[];

  var scrollController = ScrollController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
