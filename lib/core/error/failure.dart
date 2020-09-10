import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String error;

  Failure([List properties = const <dynamic>[], this.error]) : super();

  static debugPrint(String error) {
    print(error);
  }
}
