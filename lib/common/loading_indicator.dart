import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final Color color;

  LoadingIndicator({@required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(this.color),
      ),
    );
  }
}
