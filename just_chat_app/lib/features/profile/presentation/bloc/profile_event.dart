part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class UpdateUsernameRequested extends ProfileEvent{
  final String username;

  const UpdateUsernameRequested(this.username);

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

final class ChangePasswordRequested extends ProfileEvent{
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordRequested(this.currentPassword, this.newPassword, this.confirmPassword);

  @override
  // TODO: implement props
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}

final class ClearPasswordChanged extends ProfileEvent{
  const ClearPasswordChanged();
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

final class LogoutRequested extends ProfileEvent{
  const LogoutRequested();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class UpdateProfilePicRequested extends ProfileEvent{
  final String imagePath;

  const UpdateProfilePicRequested(this.imagePath);

  @override
  // TODO: implement props
  List<Object?> get props => [imagePath];
}
