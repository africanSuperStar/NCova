import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';
import '../../data/models/models.dart';

class GlobalStatsCard extends StatelessWidget {
  final Status intl;

  GlobalStatsCard({this.intl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: DaintyColors.nearlyWhite,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0), topRight: Radius.circular(80.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(color: DaintyColors.grey.withOpacity(0.2), offset: Offset(1.1, 1.1), blurRadius: 10.0),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Text(
                      'Global Stats',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25, letterSpacing: -0.1, color: DaintyColors.primary),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 80),
                          child: Text(
                            'R0:',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: DaintyColors.nearlyBlack),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${intl.stats != null ? intl.stats.value.r0?.value : '...'}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: DaintyColors.primary, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 18),
                          child: Text(
                            'Death  Rate:',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: DaintyColors.nearlyBlack),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${intl.stats != null ? intl.stats.value.deathRate.value : '...'}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: DaintyColors.primary, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 2,
                    color: DaintyColors.primary,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            'Total countries affected:',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: DaintyColors.nearlyBlack),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${intl.stats != null ? intl.stats.value.countries.value : '...'}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: DaintyColors.primary, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            'Incubation Period:',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: DaintyColors.nearlyBlack),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${intl.stats != null ? intl.stats.value.incubation.value : '...'}',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: DaintyColors.primary, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
