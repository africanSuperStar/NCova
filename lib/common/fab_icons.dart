import 'package:flutter/material.dart';

import '../utils/colors.dart';

class FavoriteFAB extends StatelessWidget {
  final Animation animation;
  final Function onPressed;

  FavoriteFAB({this.animation, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 70),
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        icon: Icon(
          Icons.star,
          color: DaintyColors.nearlyWhite,
        ),
        backgroundColor: Colors.orangeAccent,
        label: Text('Favorites'),
        elevation: animation.value,
        heroTag: 'favorites',
      ),
    );
  }
}

class SelectFavoritesFAB extends StatelessWidget {
  final Animation animation;
  final Function onPressed;

  SelectFavoritesFAB({
    this.animation,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 70),
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orangeAccent,
        elevation: animation.value,
        heroTag: 'add_favorites',
      ),
    );
  }
}
