part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  final String category;

  const NewsEvent({@required this.category}) : assert(category != null);
}

class SetNewsCategory extends NewsEvent {
  SetNewsCategory({@required String category}) : super(category: category);

  @override
  List<Object> get props => [];
}
