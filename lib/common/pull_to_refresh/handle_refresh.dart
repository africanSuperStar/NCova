import 'dart:async';

import 'package:flutter/material.dart';

import '../../features/locale/presentation/pages/locale_screen.dart';
import '../../navigator_service.dart';

Future<void> handleRefresh(GlobalKey<RefreshIndicatorState> refreshIndicatorKey, BuildContext context) {
  final Completer<void> completer = Completer<void>();
  GlobalKey<ScaffoldState> _scaffoldKey = NavigatorProvider.of(context).scaffoldKey;

  LocaleScreen.isBeingRefreshed = true;

  Timer(const Duration(seconds: 1), () {
    LocaleScreen.isBeingRefreshed = false;
    completer.complete();
  });

  // BlocProvider.of<StatusBloc>(context).add(LoadStatuses());

  return completer.future.then<void>(
    (_) {
      // TODO: Fix this doesn't work currently.
      _scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              refreshIndicatorKey.currentState.show();
            },
          ),
        ),
      );
    },
  );
}
