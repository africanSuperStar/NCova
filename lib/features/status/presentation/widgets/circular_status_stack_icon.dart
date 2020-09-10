import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/colors.dart';
import '../../data/models/models.dart';
import 'status_colors.dart';

class CircularStatusStackIcon extends StatelessWidget {
  final Status status;
  final Offset offset;

  CircularStatusStackIcon({this.offset = Offset.zero, @required this.status}) : assert(status != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: offset,
        child: Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: StatusColors(status: status).cases(), width: 2),
            borderRadius: BorderRadius.all(Radius.circular(200)),
          ),
          child: ClipOval(
            child: FutureBuilder(
              future: _futureIcon(status.a3?.value ?? ''),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _svgImage(snapshot.data);
                } else {
                  return Container(
                    width: 30,
                    height: 30,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<Image> _futureIcon(String a3) async {
    final path = 'assets/icons/flags/webp/$a3.webp';

    return rootBundle.load(path).then((value) {
      return Image.memory(
        value.buffer.asUint8List(),
        fit: BoxFit.fitHeight,
      );
    }).catchError((_) {
      return Image.asset(
        'assets/images/info.png',
        fit: BoxFit.fitHeight,
      );
    });
  }

  Widget _svgImage(Image icon) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(color: DaintyColors.grey, offset: Offset(5, 25), blurRadius: 25.0),
          ],
        ),
        child: icon,
      ),
    );
  }
}
