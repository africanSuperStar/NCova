import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uncovid/core/error/failure.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/loading_indicator.dart';
import '../../../../common/pull_to_refresh/handle_refresh.dart';
import '../../../../common/pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../../../utils/colors.dart';
import '../../data/models/category_model.dart';
import '../../data/models/models.dart';
import '../bloc/news/bloc.dart';
import '../bloc/status/bloc.dart';

class StatusNewsScreen extends StatefulWidget {
  static bool isBeingRefreshed = false;

  @override
  _StatusNewsScreenState createState() => _StatusNewsScreenState();
}

class _StatusNewsScreenState extends State<StatusNewsScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _statusNewsRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _animationController.forward();
    _animation = Tween<double>(begin: 0, end: 1.0).animate(
      _animationController,
    );
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          flexibleSpace: FadeTransition(
            opacity: _animation,
            child: Container(
              child: LiquidPullToRefresh(
                height: 60,
                color: DaintyColors.primary,
                key: _statusNewsRefreshIndicatorKey,
                showChildOpacityTransition: false,
                onRefresh: () => handleRefresh(_statusNewsRefreshIndicatorKey, context),
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: mediaQuery.padding.top + 16.0,
                        bottom: 16.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              WidgetTitle(strToday),
                            ],
                          ),
                          // SizedBox(height: 8.0),
                          // buildWidgetSearch(),
                          // SizedBox(height: 12.0),
                          WidgetCategory(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          expandedHeight: 180,
        ),
        SliverToBoxAdapter(
          child: _buildWidgetLabelLatestNews(context),
        ),
        SliverToBoxAdapter(
          child: _buildWidgetSubtitleLatestNews(context),
        ),
        WidgetLatestNews(),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 100),
        ),
      ],
    );
  }

  Widget _buildWidgetSubtitleLatestNews(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DaintyColors.nearlyWhite,
        boxShadow: [
          BoxShadow(
            color: DaintyColors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Top stories at the moment',
              style: Theme.of(context).textTheme.caption.merge(
                    TextStyle(
                      color: DaintyColors.lightText,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetLabelLatestNews(BuildContext context) {
    return Container(
      color: DaintyColors.nearlyWhite,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10.0),
        child: Row(
          children: <Widget>[
            Text(
              'Latest News',
              style: Theme.of(context).textTheme.subtitle.merge(
                    TextStyle(
                      fontSize: 18.0,
                      color: DaintyColors.darkerText,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWidgetSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.only(
          left: 12.0,
          top: 8.0,
          right: 12.0,
          bottom: 8.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'What are you looking for?',
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
            ),
            Icon(
              Icons.search,
              size: 16.0,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(" ")[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + "st";
    } else if (strDay == '2') {
      strDay = strDay + "nd";
    } else if (strDay == '3') {
      strDay = strDay + "rd";
    } else {
      strDay = strDay + "th";
    }
    var strMonth = today.split(" ")[0];
    var strYear = today.split(" ")[2];
    return "$strDay $strMonth $strYear";
  }
}

class WidgetTitle extends StatelessWidget {
  final String strToday;

  WidgetTitle(this.strToday);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              height: 1.8,
            ),
            children: [
              TextSpan(
                text: 'News Today\n',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        color: DaintyColors.darkerText,
                        fontSize: 18,
                      ),
                    ),
              ),
              TextSpan(
                text: strToday,
                style: Theme.of(context).textTheme.caption.merge(
                      TextStyle(
                        color: Color(0xFF325384).withOpacity(0.8),
                        fontSize: 14.0,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WidgetCategory extends StatefulWidget {
  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  final listCategories = [
    Category(
      (b) => b
        ..title?.value
        ..image?.value,
    ),
    Category(
      (b) => b
        ..title?.value
        ..image.value,
    ),
    // Category('assets/images/corona.webp', 'Corona'),
    // Category('assets/images/sars.jpg', 'Sars'),
    // Category('assets/images/mers.jpg', 'Mers'),
    // Category('assets/images/virus.jpeg', 'Virus'),
  ];
  int indexSelectedCategory = 0;

  @override
  void initState() {
    BlocProvider.of<NewsBloc>(context).add(
      SetNewsCategory(
        category: listCategories[indexSelectedCategory].title?.value ?? '...',
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Container(
          height: 74,
          child: ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Category itemCategory = listCategories[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: index == listCategories.length - 1 ? 16.0 : 0.0,
                ),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          indexSelectedCategory = index;
                          BlocProvider.of<NewsBloc>(context).add(
                            SetNewsCategory(
                              category: listCategories[indexSelectedCategory].title?.value ?? '...',
                            ),
                          );
                        });
                      },
                      child: index == 0
                          ? Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFBDCDDE),
                                border: indexSelectedCategory == index
                                    ? Border.all(
                                        color: Colors.white,
                                        width: 5.0,
                                      )
                                    : null,
                              ),
                              child: Icon(
                                Icons.apps,
                                color: Colors.white,
                              ),
                            )
                          : Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                    itemCategory.image?.value ?? '',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: indexSelectedCategory == index
                                    ? Border.all(
                                        color: Colors.white,
                                        width: 5.0,
                                      )
                                    : null,
                              ),
                            ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      itemCategory.title?.value ?? '...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF325384),
                        fontWeight: indexSelectedCategory == index ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: listCategories.length,
          ),
        );
      },
    );
  }
}

class WidgetLatestNews extends StatefulWidget {
  WidgetLatestNews();

  @override
  _WidgetLatestNewsState createState() => _WidgetLatestNewsState();
}

class _WidgetLatestNewsState extends State<WidgetLatestNews> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return SliverPadding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      sliver: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return _buildWidgetContentLatestNews(state, mediaQuery);
        },
      ),
    );
  }

  Widget _buildWidgetContentLatestNews(NewsState state, MediaQueryData mediaQuery) {
    if (state is NewsLoading) {
      BlocProvider.of<StatusBloc>(context).add(LoadRssFeed());
      return SliverToBoxAdapter(
        child: LoadingIndicator(
          color: DaintyColors.primary,
        ),
      );
    } else if (state is NewsSuccessfullyDownloaded) {
      ResponseTopHeadlinesNews data = state.news;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            Article itemArticle = data.articles.fold((a) => a[index], (error) {
              Failure.debugPrint(error);
              return Article();
            });
            if (index == 0) {
              return Stack(
                children: <Widget>[
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: itemArticle?.urlToImage ?? '',
                      height: 192.0,
                      width: mediaQuery.size.width,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/img_not_found.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(itemArticle.url)) {
                        await launch(itemArticle.url);
                      } else {
                        // scaffoldState.currentState.showSnackBar(SnackBar(
                        //   content: Text('Could not launch news'),
                        // ));
                      }
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: 192.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.0,
                            0.7,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 12.0,
                          right: 12.0,
                        ),
                        child: Text(
                          itemArticle.title,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 4.0,
                          right: 12.0,
                        ),
                        child: Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.launch,
                              color: Colors.white.withOpacity(0.8),
                              size: 12.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '${itemArticle.source.name}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  if (await canLaunch(itemArticle.url)) {
                    await launch(itemArticle.url);
                  }
                },
                child: Container(
                  width: mediaQuery.size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 72.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                itemArticle.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF325384),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.launch,
                                    size: 12.0,
                                    color: Color(0xFF325384).withOpacity(0.5),
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    itemArticle.source.name,
                                    style: TextStyle(
                                      color: Color(0xFF325384).withOpacity(0.5),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ClipRRect(
                          /*child: Image.network(
                          itemArticle.urlToImage ??
                              'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                          width: 72.0,
                          height: 72.0,
                          fit: BoxFit.cover,
                        ),*/
                          child: CachedNetworkImage(
                            imageUrl: itemArticle?.urlToImage ?? '',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 72.0,
                                height: 72.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) => Container(
                              width: 72.0,
                              height: 72.0,
                              child: Center(
                                child: Platform.isAndroid ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/img_not_found.jpg',
                              fit: BoxFit.cover,
                              width: 72.0,
                              height: 72.0,
                            ),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          childCount: data.articles.fold((a) => a.length, (error) {
            Failure.debugPrint(error);
            return 0;
          }),
        ),
      );
    } else if (state is WHOSuccessfullyLoaded) {
      final data = state.rssFeed;

      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return Stack(
                children: <Widget>[
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: data.items[index].media?.embed?.url ?? '',
                      height: 192.0,
                      width: mediaQuery.size.width,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => LoadingIndicator(
                        color: DaintyColors.primary,
                      ),
                      errorWidget: (context, url, error) => FittedBox(
                        child: Image.asset(
                          'assets/images/img_not_found.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await canLaunch(data.items[index]?.link ?? '')) {
                        await launch(data.items[index]?.link ?? '');
                      } else {
                        // scaffoldState.currentState.showSnackBar(SnackBar(
                        //   content: Text('Could not launch news'),
                        // ));
                      }
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: 192.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0.0,
                            0.7,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 12.0,
                          right: 12.0,
                        ),
                        child: Text(
                          data.items[index]?.title ?? '',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12.0,
                          top: 4.0,
                          right: 12.0,
                        ),
                        child: Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.launch,
                              color: Colors.white.withOpacity(0.8),
                              size: 12.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '${data.items[index]?.link ?? ''}',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 11.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return GestureDetector(
                onTap: () async {
                  if (await canLaunch(data.items[index]?.link ?? '')) {
                    await launch(data.items[index]?.link ?? '');
                  }
                },
                child: Container(
                  width: mediaQuery.size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 140.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                data.items[index]?.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF325384),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.launch,
                                    size: 12.0,
                                    color: Color(0xFF325384).withOpacity(0.5),
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    data.items[index]?.link ?? '',
                                    style: TextStyle(
                                      color: Color(0xFF325384).withOpacity(0.5),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: ClipRRect(
                          /*child: Image.network(
                          itemArticle.urlToImage ??
                              'http://api.bengkelrobot.net:8001/assets/images/img_not_found.jpg',
                          width: 72.0,
                          height: 72.0,
                          fit: BoxFit.cover,
                        ),*/
                          child: CachedNetworkImage(
                            imageUrl: data.items[index]?.media?.embed?.url ?? '',
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 72.0,
                                height: 72.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            placeholder: (context, url) => Container(
                              width: 72.0,
                              height: 72.0,
                              child: Center(
                                  child: LoadingIndicator(
                                color: DaintyColors.primary,
                              )),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/img_not_found.jpg',
                              fit: BoxFit.cover,
                              width: 72.0,
                              height: 72.0,
                            ),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
          childCount: data.items.length,
        ),
      );
    } else {
      BlocProvider.of<StatusBloc>(context).add(LoadRssFeed());
      return LoadingIndicator(
        color: DaintyColors.primary,
      );
    }
  }
}
