import 'package:dio/dio.dart';

import '../../domain/repository/news_repository.dart';
import '../models/models.dart';

class NewsRepositoryImpl extends NewsRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://newsapi.org/v2/top-headlines?country=us&category=health';

  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future<ResponseTopHeadlinesNews> fetchTopHeadlinesNews() async {
    try {
      final response = await _dio.get(_baseUrl);
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> fetchTopCoronaHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&q=corona');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> fetchTopSarsHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&q=sars');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> fetchTopMersHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&q=mers');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }

  Future<ResponseTopHeadlinesNews> fetchTopVirusHeadlinesNews() async {
    try {
      final response = await _dio.get('$_baseUrl&q=virus');
      return ResponseTopHeadlinesNews.fromJson(response.data);
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return ResponseTopHeadlinesNews.withError('$error');
    }
  }
}
