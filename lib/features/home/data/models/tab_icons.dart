import 'package:flutter/material.dart';

class TabIconData {
  final UniqueKey key = UniqueKey();

  int index;
  String title;
  String imagePath;
  bool selected;
  Function onclick;
  AnimationController animationController;

  TabIconData({
    this.index = 0,
    this.title = '',
    this.imagePath = '',
    this.selected = false,
    this.animationController,
  });

  static List<TabIconData> tabIconsList = [
    TabIconData(
      title: 'Locale',
      imagePath: 'assets/images/local.png',
      index: 0,
      selected: true,
      animationController: null,
    ),
    TabIconData(
      title: 'Status',
      imagePath: 'assets/images/ncova.circle.png',
      index: 1,
      selected: false,
      animationController: null,
    ),
    TabIconData(
      title: 'Info',
      imagePath: 'assets/images/info.png',
      index: 2,
      selected: false,
      animationController: null,
    ),
  ];
}
