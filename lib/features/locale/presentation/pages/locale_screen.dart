import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../common/platform_action_sheet.dart';
import '../../../../common/pull_to_refresh/handle_refresh.dart';
import '../../../../common/pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../status/data/models/models.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import '../../../status/presentation/pages/status_screen.dart';
import '../../../status/presentation/widgets/circular_status_stack_icon.dart';
import '../../../status/presentation/widgets/status_card.dart';
import 'locale_detail_screen.dart';

class LocaleScreen extends StatefulWidget {
  static final GlobalKey<SliverAnimatedListState> animatedSliverListKey = GlobalKey<SliverAnimatedListState>();

  static bool isBeingRefreshed = false;

  @override
  _LocaleScreenState createState() => _LocaleScreenState();
}

class _LocaleScreenState extends State<LocaleScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _localeRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  NavigatorService _service;
  Animation _animation;
  Animation<double> favoriteAnimation;
  AnimationController _animationController;

  TextEditingController editingController = TextEditingController();

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
  dispose() {
    editingController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _showDetailPage({List<Status> statuses, Status selectedStatus}) {
    setState(() {
      _animationController.reverse();
      if (_service.previousPages.last is StatusScreen) {
        _service.previousPages.add(_service.currentPage);
      }
      _service.currentPage = LocaleDetailScreen(
        selectedStatus: selectedStatus,
        statuses: statuses,
      );
      BlocProvider.of<StatusBloc>(context).add(LoadStatusHistories(selectedStatus: selectedStatus));
    });
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        if (state is StatusesLoading || state is RssFeedLoaded || state is StatusHistoriesLoaded) {
          BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
          return LoadingIndicator(
            color: DaintyColors.primary,
          );
        } else if (state is StatusesLoaded) {
          state.cleanStatuses();
          return _localePage(state.statuses);
        } else if (state is StatusChartsLoaded) {
          return _localePage(state.statuses);
        } else {
          BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
          return LoadingIndicator(
            color: DaintyColors.primary,
          );
        }
      },
    );
  }

  void filterSearchResults(String query, List<Status> statuses) {
    final List<Status> duplicates = <Status>[];
    duplicates.addAll(statuses);

    if (query.isNotEmpty) {
      setState(() {
        final _chunk = statuses
            .where(
              (status) => status.name != null
                  ? !status.name.value.toLowerCase().contains(
                        query.toLowerCase(),
                      )
                  : '...',
            )
            .toList();

        statuses.retainWhere(
          (status) => status.name != null
              ? status.name.value.toLowerCase().contains(
                    query.toLowerCase(),
                  )
              : '...',
        );

        statuses.addAll(_chunk);
      });
    } else {
      setState(() {
        statuses.clear();
        statuses.addAll(duplicates);
      });
    }
  }

  Widget _cardItem({Status selectedStatus, List<Status> statuses, Animation<double> animation}) {
    return SizeTransition(
      axis: Axis.vertical,
      sizeFactor: animation,
      child: AbsorbPointer(
        absorbing: LocaleScreen.isBeingRefreshed,
        child: Center(
          child: LimitedBox(
            key: ValueKey(
              selectedStatus,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showDetailPage(statuses: statuses, selectedStatus: selectedStatus);
                });
              },
              key: ValueKey(_animation.value),
              child: StatusCard(
                status: selectedStatus,
                statuses: statuses,
                onTapCallback: () {
                  setState(() {
                    _onTapFavorite(selectedStatus: selectedStatus, statuses: statuses);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, Animation<double> animation) {
    return BlocBuilder<StatusBloc, StatusesState>(builder: (context, state) {
      if (state is StatusesLoaded) {
        if (state.statuses.isNotEmpty) {
          final favorites = state.statuses.where((status) => status.favorited == true);

          if (index < (state.statuses.length - favorites.length)) {
            final status = state.statuses[index].rebuild(
              (b) => b.favorited = state.statuses[index].favorited,
            );
            return _cardItem(selectedStatus: status, statuses: state.statuses, animation: animation);
          }
          return Container();
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    });
  }

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(Status status, BuildContext context, Animation<double> animation) {
    return BlocBuilder<StatusBloc, StatusesState>(builder: (context, state) {
      if (state is StatusesLoaded) {
        if (state.statuses.length > 0) {
          return _cardItem(selectedStatus: status, statuses: state.statuses, animation: animation);
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    });
  }

  void _onTapFavorite({Status selectedStatus, List<Status> statuses}) {
    final favorited = statuses.firstWhere((status) => status.name == selectedStatus.name)?.favorited ?? false;
    final int index = favorited == null ? statuses.length : statuses.indexWhere((status) => status.name == selectedStatus.name);

    if (favorited) {
      BlocProvider.of<StatusBloc>(context).add(
        RemoveFavorite(
          selectedStatus.rebuild(
            (b) => b.favorited = !favorited,
          ),
        ),
      );
      LocaleScreen.animatedSliverListKey.currentState.removeItem(
        index,
        (context, animation) {
          return _buildRemovedItem(selectedStatus, context, animation);
        },
        duration: Duration(milliseconds: 400),
      );
    } else {
      BlocProvider.of<StatusBloc>(context).add(
        InsertFavorite(
          selectedStatus.rebuild(
            (b) => b.favorited = !favorited,
          ),
        ),
      );
      LocaleScreen.animatedSliverListKey.currentState.insertItem(
        index,
        duration: Duration(milliseconds: 600),
      );
    }
    final newStatus = statuses.firstWhere((status) => status.name == selectedStatus.name).rebuild(
          (b) => b.favorited = !favorited,
        );
    statuses.removeWhere((status) => status.name == newStatus.name);
    statuses.insert(0, newStatus);

    BlocProvider.of<StatusBloc>(context).add(
      UpdateStatuses(
        statuses: statuses,
      ),
    );
  }

  //
  // TODO: All these sorting methods need to be moved to usecases. Also need to be made more generic.
  //
  void _filterCasesHighestToLowest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.cases != null) {
          if (status.totals.value.cases?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.cases?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.cases?.value);
          final bValue = int.tryParse(b.totals.value?.cases?.value);

          if (aValue != null && bValue != null) {
            return bValue.compareTo(aValue);
          }
          return -1;
        }
        return -1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterCasesLowestToHighest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.cases != null) {
          if (status.totals.value.cases?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.cases?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.cases?.value);
          final bValue = int.tryParse(b.totals.value?.cases?.value);

          if (aValue != null && bValue != null) {
            return aValue.compareTo(bValue);
          }
          return 1;
        }
        return 1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterDeathsHighestToLowest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.deaths != null) {
          if (status.totals.value.deaths?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.deaths?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.deaths?.value);
          final bValue = int.tryParse(b.totals.value?.deaths?.value);

          if (aValue != null && bValue != null) {
            return bValue.compareTo(aValue);
          }
          return -1;
        }
        return -1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterDeathsLowestToHighest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.deaths != null) {
          if (status.totals.value.deaths?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.deaths?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.deaths?.value);
          final bValue = int.tryParse(b.totals.value?.deaths?.value);

          if (aValue != null && bValue != null) {
            return aValue.compareTo(bValue);
          }
          return 1;
        }
        return 1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterSeriousHighestToLowest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.serious != null) {
          if (status.totals.value.serious?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.serious?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.serious?.value);
          final bValue = int.tryParse(b.totals.value?.serious?.value);

          if (aValue != null && bValue != null) {
            return bValue.compareTo(aValue);
          }
          return -1;
        }
        return -1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterSeriousLowestToHighest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.serious != null) {
          if (status.totals.value.serious?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.serious?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.serious?.value);
          final bValue = int.tryParse(b.totals.value?.serious?.value);

          if (aValue != null && bValue != null) {
            return aValue.compareTo(bValue);
          }
          return 1;
        }
        return 1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterRecoveredHighestToLowest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.recovered != null) {
          if (status.totals.value.recovered?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.recovered?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });

      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.recovered?.value);
          final bValue = int.tryParse(b.totals.value?.recovered?.value);

          if (aValue != null && bValue != null) {
            return bValue.compareTo(aValue);
          }
          return -1;
        }
        return -1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  void _filterRecoveredLowestToHighest({@required List<Status> statuses}) {
    setState(() {
      List<Status> __chunk = <Status>[];

      statuses.removeWhere((status) {
        if (status.totals != null && status.totals.value.recovered != null) {
          if (status.totals.value.recovered?.value == '0') {
            __chunk.add(status);
          }
          return status.totals.value.recovered?.value == '0';
        } else {
          __chunk.add(status);
          return true;
        }
      });
      Comparator<Status> statusComparator = (a, b) {
        if (a.totals != null && b.totals != null) {
          final aValue = int.tryParse(a.totals.value?.recovered?.value);
          final bValue = int.tryParse(b.totals.value?.recovered?.value);

          if (aValue != null && bValue != null) {
            return aValue.compareTo(bValue);
          }
          return 1;
        }
        return 1;
      };

      statuses.sort(statusComparator);
      statuses.addAll(__chunk);
    });
  }

  Widget _localePage(List<Status> statuses) {
    return SafeArea(
      child: FadeTransition(
        opacity: _animation,
        child: LimitedBox(
          child: LiquidPullToRefresh(
            height: 60,
            color: DaintyColors.primary,
            key: _localeRefreshIndicatorKey,
            showChildOpacityTransition: false,
            onRefresh: () => handleRefresh(_localeRefreshIndicatorKey, context),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  floating: true,
                  expandedHeight: 60,
                  backgroundColor: DaintyColors.primary.withOpacity(0.8),
                  flexibleSpace: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 16,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextField(
                            onChanged: (value) {
                              filterSearchResults(value, statuses);
                            },
                            style: TextStyle(color: DaintyColors.darkerText),
                            controller: editingController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusColor: DaintyColors.darkerText,
                              hoverColor: DaintyColors.primary,
                              hintText: 'Search Countries...',
                              contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 14.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                      _sortLocaleList(statuses),
                      _filterLocaleList(statuses),
                    ],
                  ),
                ),
                SliverAnimatedList(
                  key: LocaleScreen.animatedSliverListKey,
                  initialItemCount: statuses?.length,
                  itemBuilder: _buildItem,
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 80),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sortLocaleList(List<Status> statuses) {
    return Flexible(
      flex: 2,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: 60,
        height: 60,
        child: InkWell(
          onTap: () => PlatformActionSheet().displaySheet(
            context: context,
            title: Row(
              children: <Widget>[
                Text(
                  "Sort List According to:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            actions: [
              ActionSheetAction(
                asc: false,
                text: "Cases: Highest to Lowest",
                onPressed: () {
                  _filterCasesHighestToLowest(statuses: statuses);
                  Navigator.pop(context);
                },
                hasArrow: true,
              ),
              ActionSheetAction(
                asc: true,
                text: "Cases: Lowest to Highest",
                onPressed: () {
                  _filterCasesLowestToHighest(statuses: statuses);
                  Navigator.pop(context);
                },
                hasArrow: true,
              ),
              ActionSheetAction(
                asc: false,
                text: "Deaths: Highest to Lowest",
                onPressed: () {
                  _filterDeathsHighestToLowest(statuses: statuses);
                  Navigator.pop(context);
                },
              ),
              ActionSheetAction(
                asc: true,
                text: "Deaths: Lowest to Highest",
                onPressed: () {
                  _filterDeathsLowestToHighest(statuses: statuses);
                  Navigator.pop(context);
                },
                hasArrow: true,
              ),
              ActionSheetAction(
                asc: false,
                text: "Serious: Highest to Lowest",
                onPressed: () {
                  _filterSeriousHighestToLowest(statuses: statuses);
                  Navigator.pop(context);
                },
              ),
              ActionSheetAction(
                asc: true,
                text: "Serious: Lowest to Highest",
                onPressed: () {
                  _filterSeriousLowestToHighest(statuses: statuses);
                  Navigator.pop(context);
                },
                hasArrow: true,
              ),
              ActionSheetAction(
                asc: false,
                text: "Recovered: Highest to Lowest",
                onPressed: () {
                  _filterRecoveredHighestToLowest(statuses: statuses);
                  Navigator.pop(context);
                },
              ),
              ActionSheetAction(
                asc: true,
                text: "Recovered: Lowest to Highest",
                onPressed: () {
                  _filterRecoveredLowestToHighest(statuses: statuses);
                  Navigator.pop(context);
                },
                hasArrow: true,
              ),
              ActionSheetAction(
                text: "Cancel",
                onPressed: () => Navigator.pop(context),
                isCancel: true,
                defaultAction: true,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor: DaintyColors.nearlyWhite,
              child: Icon(Icons.sort_by_alpha),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterLocaleList(List<Status> statuses) {
    return Flexible(
      flex: 2,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: 60,
        height: 60,
        child: InkWell(
          onTap: () => _filterContainer(statuses),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              backgroundColor: DaintyColors.nearlyWhite,
              child: Icon(Icons.filter_list),
            ),
          ),
        ),
      ),
    );
  }

  Future<Wrap> _filterContainer(List<Status> statuses) {
    final orientation = MediaQuery.of(context).orientation;

    return showGeneralDialog(
      context: context,
      pageBuilder: (
        BuildContext buildContext,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: DaintyColors.nearlyWhite,
            child: Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                      child: Container(
                        child: AutoSizeText(
                          'Filter by Country:',
                          style: TextStyle(color: DaintyColors.darkerText, fontSize: 14.0),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.close),
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    itemCount: statuses.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 0.0,
                      childAspectRatio: 4,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: _countryChip(statuses[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      barrierDismissible: true,
      barrierLabel: 'Select a country:',
      transitionDuration: const Duration(milliseconds: 150),
      useRootNavigator: true,
    );
  }

  Widget _countryChip(Status status) {
    return InputChip(
      avatar: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: CircularStatusStackIcon(status: status),
      ),
      label: Text(status.name.value ?? 'Unknown'),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
      onPressed: () {},
      onDeleted: () {},
    );
  }
}
