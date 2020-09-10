import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webfeed/webfeed.dart';

import '../../../data/models/models.dart';
import '../../../domain/repository/news_repository.dart';
import '../status/bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;
  final BuildContext _context;

  NewsBloc({@required NewsRepository newsRepository, @required BuildContext context})
      : assert(newsRepository != null),
        assert(context != null),
        _newsRepository = newsRepository,
        _context = context;

  @override
  NewsState get initialState => NewsLoading();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    final categoryLowerCase = event.category.toLowerCase();
    switch (categoryLowerCase) {
      case 'all':
        // final news = await _newsRepository.fetchTopHeadlinesNews();
        // if (news.error == null) {
        //   yield NewsSuccessfullyDownloaded(news: news);
        // } else {
        //   yield NewsDownloadFailed('Failed to fetch data');
        // }
        yield* _mapWHOToState();
        break;
      case 'who':
        yield* _mapWHOToState();
        break;
      case 'corona':
        final news = await _newsRepository.fetchTopCoronaHeadlinesNews();
        if (news.error == null) {
          yield NewsSuccessfullyDownloaded(news: news);
        } else {
          yield NewsDownloadFailed(news.error);
        }
        break;
      case 'sars':
        final news = await _newsRepository.fetchTopSarsHeadlinesNews();
        if (news.error == null) {
          yield NewsSuccessfullyDownloaded(news: news);
        } else {
          yield NewsDownloadFailed(news.error);
        }
        break;
      case 'mers':
        final news = await _newsRepository.fetchTopMersHeadlinesNews();
        if (news.error == null) {
          yield NewsSuccessfullyDownloaded(news: news);
        } else {
          yield NewsDownloadFailed(news.error);
        }
        break;
      case 'virus':
        final news = await _newsRepository.fetchTopVirusHeadlinesNews();
        if (news.error == null) {
          yield NewsSuccessfullyDownloaded(news: news);
        } else {
          yield NewsDownloadFailed(news.error);
        }
        break;
      default:
        yield NewsDownloadFailed('Unknown category');
    }
  }

  Stream<NewsState> _mapWHOToState() async* {
    final state = BlocProvider.of<StatusBloc>(_context).state;
    if (state is RssFeedLoaded) {
      yield WHOSuccessfullyLoaded(rssFeed: state.rssFeed);
    } else {
      BlocProvider.of<StatusBloc>(_context).add(LoadRssFeed());
      yield NewsLoading();
    }
  }
}
