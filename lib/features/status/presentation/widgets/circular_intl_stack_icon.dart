import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import 'avatar_glow.dart';

class CircularIntlStackIcon extends StatelessWidget {
  final String image;
  final AlignmentGeometry alignment;

  CircularIntlStackIcon(
    this.image,
    this.alignment,
  );

  @override
  Widget build(BuildContext context) {
    Offset _offset;

    if (alignment == Alignment.topLeft) {
      _offset = Offset(-58.0, -58.0);
    } else {
      _offset = Offset(58.0, -58.0);
    }

    return Transform.translate(
      offset: _offset,
      child: AvatarGlow(
        startDelay: Duration(milliseconds: 4000),
        glowColor: DaintyColors.primaryLight,
        endRadius: 100.0,
        duration: Duration(milliseconds: 2000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 4000),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: DaintyColors.primary, width: 5),
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
          child: ClipOval(
            child: _image(image),
          ),
        ),
      ),
    );
  }

  Widget _image(String asset) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: DaintyColors.grey, offset: Offset(5, 25), blurRadius: 25.0),
          ],
        ),
        child: Image.asset(
          asset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
