part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

class LoginRequested extends UserEvent{
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class SignupRequested extends UserEvent{
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  const SignupRequested(this.email, this.password, this.firstname, this.lastname);

  @override
  // TODO: implement props
  List<Object?> get props => [firstname, lastname, email, password];
}
