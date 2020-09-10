import 'dart:async';

import '../../data/models/models.dart';

abstract class NewsRepository {
  Future<ResponseTopHeadlinesNews> fetchTopHeadlinesNews();
  Future<ResponseTopHeadlinesNews> fetchTopCoronaHeadlinesNews();
  Future<ResponseTopHeadlinesNews> fetchTopSarsHeadlinesNews();
  Future<ResponseTopHeadlinesNews> fetchTopMersHeadlinesNews();
  Future<ResponseTopHeadlinesNews> fetchTopVirusHeadlinesNews();
}
