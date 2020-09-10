part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isSignedIn;

  const AuthState({@required this.isSignedIn}) : assert(isSignedIn != null);
}

class AuthLoaded extends AuthState {
  AuthLoaded({@required bool isSignedIn}) : super(isSignedIn: isSignedIn);

  @override
  List<Object> get props => [isSignedIn];

  @override
  String toString() => 'AuthLoaded { isSignedIn: $isSignedIn }';
}
