part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();
}

final class UserInitial extends UserState {
  const UserInitial();
  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  const UserLoading();
  @override
  List<Object> get props => [];
}

final class UserLoaded extends UserState {
  const UserLoaded();
  @override
  List<Object> get props => [];
}

final class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);
  @override
  List<Object> get props => [message];
}

class UserAuthenticated extends UserState {
  final UserEntity? user;

  const UserAuthenticated({this.user});

  @override
  List<Object> get props => [user ?? ''];
}
