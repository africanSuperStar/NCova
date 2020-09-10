import 'package:flutter/material.dart';
import 'package:uncovid/core/error/failure.dart';
import 'package:uncovid/features/status/data/models/models.dart';

class StatusColors {
  final Status status;

  StatusColors({this.status});

  Color cases() {
    final String cases = status.totals != null && status.totals.isLeft() ? status.totals.value.cases?.value : '';
    final casesInt = cases.replaceAll(RegExp(r','), '');
    final casesCount = int.tryParse(casesInt) ?? 0;
    if (casesCount <= 0) {
      return Color(0xFF1A936F);
    } else if (casesCount > 0 && casesCount <= 5) {
      return Color(0xFFE8C25C);
    } else if (casesCount > 5 && casesCount <= 50) {
      return Color(0xFFF49D55);
    } else if (casesCount > 50 && casesCount <= 200) {
      return Color(0xFFE86443);
    } else if (casesCount > 200) {
      return Color(0xFFDB3A34);
    } else {
      return Colors.green;
    }
  }
}
