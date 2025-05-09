part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class LoginEvent extends UserEvent{
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class CheckAuthentication extends UserEvent {
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends UserEvent{
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  const SignUpEvent(this.email, this.password, this.firstname, this.lastname);

  @override
  // TODO: implement props
  List<Object?> get props => [firstname, lastname, email, password];
}
