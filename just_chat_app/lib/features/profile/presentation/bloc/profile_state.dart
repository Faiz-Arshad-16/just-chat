part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final String? username;
  final String? email;
  final String? profilePicUrl;
  final String? error;
  final bool? passwordChanged;
  final bool? isLoggedOut;

  const ProfileState({
    this.username,
    this.email,
    this.profilePicUrl,
    this.error,
    this.passwordChanged,
    this.isLoggedOut,
  });

  @override
  List<Object?> get props => [username, email, profilePicUrl, error, passwordChanged, isLoggedOut];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial()
      : super(
    username: 'User',
    email: 'example@domain.com',
    profilePicUrl: null,
    error: null,
    passwordChanged: false,
    isLoggedOut: false,
  );
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading() : super(username: null, email: null, profilePicUrl: null, error: null, passwordChanged: null, isLoggedOut: null);
}

final class ProfileUpdated extends ProfileState {
  const ProfileUpdated({
    required String? username,
    required String? email,
    required String? profilePicUrl,
    required bool passwordChanged,
    required bool isLoggedOut,
    String? error,
  }) : super(
    username: username,
    email: email,
    profilePicUrl: profilePicUrl,
    error: error,
    passwordChanged: passwordChanged,
    isLoggedOut: isLoggedOut,
  );
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure({
    required String error,
    String? username,
    String? email,
    String? profilePicUrl,
    bool? passwordChanged,
    bool? isLoggedOut,
  }) : super(
    username: username,
    email: email,
    profilePicUrl: profilePicUrl,
    error: error,
    passwordChanged: passwordChanged,
    isLoggedOut: isLoggedOut,
  );
}

final class ProfileLoggedOut extends ProfileState {
  const ProfileLoggedOut()
      : super(
    username: null,
    email: null,
    profilePicUrl: null,
    error: null,
    passwordChanged: false,
    isLoggedOut: true,
  );
}