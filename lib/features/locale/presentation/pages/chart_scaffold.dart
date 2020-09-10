import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../home/presentation/bloc/bloc.dart';
import '../../../status/data/models/models.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import 'locale_screen.dart';

typedef Widget GalleryWidgetBuilder();

/// Helper to build gallery.
class GalleryScaffold extends StatefulWidget {
  /// The widget used for leading in a [ListTile].
  final Widget listTileIcon;
  final String title;
  final String subtitle;
  final Status selectedStatus;
  final GalleryWidgetBuilder childBuilder;

  GalleryScaffold({
    this.listTileIcon,
    this.title,
    this.subtitle,
    this.selectedStatus,
    this.childBuilder,
  });

  /// Gets the gallery
  Widget buildGalleryListTile(BuildContext context) => new ListTile(
        leading: listTileIcon,
        title: new Text(title),
        subtitle: new Text(subtitle),
      );

  @override
  _GalleryScaffoldState createState() => new _GalleryScaffoldState();
}

class _GalleryScaffoldState extends State<GalleryScaffold> with SingleTickerProviderStateMixin {
  NavigatorService _service;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    _animationController.forward();
    _animation = Tween<double>(begin: 0, end: 1.0).animate(
      _animationController,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        return Scaffold(
          body: FadeTransition(
            opacity: _animation,
            child: Scaffold(
              appBar: AppBar(title: new Text(widget.title)),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    Card(
                      color: DaintyColors.grey,
                      child: ListTile(
                        title: Center(
                          child: Text('Country Specific Statistics Coming Soon.'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _animationController.reverse();
                        if (state is StatusChartsLoaded) {
                          _service.previousPages.removeLast();
                          _service.currentPage = LocaleScreen();
                          BlocProvider.of<HomeBloc>(context).add(NavigateToLocale());
                        } else {
                          BlocProvider.of<StatusBloc>(context).add(
                            LoadStatusCharts(selectedStatus: widget.selectedStatus),
                          );
                        }
                      },
                      child: Card(
                        color: DaintyColors.nearlyWhite,
                        child: ListTile(
                          title: Center(
                            child: Text(
                              'Locale',
                              style: TextStyle(color: DaintyColors.darkerText),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: SizedBox(height: 450.0, child: widget.childBuilder()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
