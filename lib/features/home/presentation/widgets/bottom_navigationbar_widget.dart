import 'package:flutter/material.dart';

import '../../data/models/tab_icons.dart';
import 'bottom_navigationbar_view.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final AnimationController animationController;

  BottomNavigationBarWidget({Key key, this.animationController}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> with SingleTickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(),
          ),
          BottomNavigationBarView(
            tabs: tabIconsList,
            initialSelection: 1,
            key: bottomNavigationKey,
            animationController: widget.animationController,
          ),
        ],
      ),
    );
  }
}
