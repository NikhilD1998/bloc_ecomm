import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final bool isGuest;
  const Authenticated({this.isGuest = false});
  @override
  List<Object?> get props => [isGuest];
}

class Unauthenticated extends AuthState {
  final String? error;
  const Unauthenticated({this.error});
  @override
  List<Object?> get props => [error];
}
