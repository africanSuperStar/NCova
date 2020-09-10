part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object> get props => [];
}

class WHOSuccessfullyLoaded extends NewsState {
  final RssFeed rssFeed;

  const WHOSuccessfullyLoaded({@required this.rssFeed}) : assert(rssFeed != null);

  @override
  List<Object> get props => [];
}

class WHOLoaded extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsSuccessfullyDownloaded extends NewsState {
  final ResponseTopHeadlinesNews news;

  NewsSuccessfullyDownloaded({@required this.news}) : assert(news != null);

  @override
  List<Object> get props => [news];
}

class NewsDownloadFailed extends NewsState {
  final String errorMessage;

  NewsDownloadFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
