import 'package:flutter/material.dart';

import '../../data/models/models.dart';

class HideStatusSnackBar extends SnackBar {
  HideStatusSnackBar({
    Key key,
    @required Status status,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Hidden Status with id: ${status.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: onUndo,
          ),
        );
}
