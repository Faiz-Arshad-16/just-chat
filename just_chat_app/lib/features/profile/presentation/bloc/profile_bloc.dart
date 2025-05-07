import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateUsernameRequested>((event, emit) {
      try {
        const usernamePattern = r'^[a-zA-Z\s-]+$';
        final regex = RegExp(usernamePattern);
        if (event.username.isEmpty) {
          throw Exception('Please enter a username');
        } else if (!regex.hasMatch(event.username)) {
          throw Exception(
            'Username must only contain letters, spaces or hyphens',
          );
        }
        emit(
          ProfileUpdated(
            username: event.username,
            email: state.username != null ? state.email! : 'example@domain.com',
            profilePicUrl: state.profilePicUrl,
            error: null,
            passwordChanged: state.passwordChanged ?? false,
            isLoggedOut: state.isLoggedOut ?? false,
          ),
        );
      } catch (e) {
        emit(
          ProfileFailure(
            username: state.username,
            email: state.email,
            profilePicUrl: state.profilePicUrl,
            error: e.toString(),
            passwordChanged: state.passwordChanged,
            isLoggedOut: state.isLoggedOut,
          ),
        );
      }
    });

    on<ChangePasswordRequested>((event, emit) {
      try {
        const passwordPattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
        final regex = RegExp(passwordPattern);
        if (event.currentPassword.isEmpty) {
          throw Exception('Please enter current password');
        } else if (event.newPassword.isEmpty) {
          throw Exception('Please enter a new password');
        } else if (!regex.hasMatch(event.newPassword)) {
          throw Exception(
            'Password must be 8+ characters with letters and numbers',
          );
        } else if (event.newPassword != event.confirmPassword) {
          throw Exception('Passwords do not match');
        }
        emit(
          ProfileUpdated(
            username: state.username ?? 'User',
            email: state.email ?? 'example@domain.com',
            profilePicUrl: state.profilePicUrl,
            error: null,
            passwordChanged: true,
            isLoggedOut: state.isLoggedOut ?? false,
          ),
        );
      } catch (e) {
        emit(
          ProfileFailure(
            username: state.username,
            email: state.email,
            profilePicUrl: state.profilePicUrl,
            error: e.toString(),
            passwordChanged: state.passwordChanged,
            isLoggedOut: state.isLoggedOut,
          ),
        );
      }
    });
    on<ClearPasswordChanged>((event, emit) {
      emit(ProfileUpdated(
        username: state.username ?? 'User',
        email: state.email ?? 'example@domain.com',
        profilePicUrl: state.profilePicUrl,
        error: null,
        passwordChanged: false,
        isLoggedOut: false,
      ));
    });

    on<LogoutRequested>((event, emit) {
      try {
        emit(const ProfileLoggedOut());
      } catch (e) {
        emit(ProfileFailure(
          username: state.username,
          email: state.email,
          profilePicUrl: state.profilePicUrl,
          error: e.toString(),
          passwordChanged: state.passwordChanged,
          isLoggedOut: state.isLoggedOut,
        ));
      }
    });

    on<UpdateProfilePicRequested>((event, emit){
      try{
        if(event.imagePath.isEmpty){
          throw Exception('No image selected');
        }
        emit(ProfileUpdated(
          username: state.username ?? 'User',
          email: state.email ?? 'example@domain.com',
          profilePicUrl: event.imagePath,
          error: null,
          passwordChanged: state.passwordChanged ?? false,
          isLoggedOut: state.passwordChanged ?? false,)
        );
      } catch (e) {
        emit(ProfileFailure(
          username: state.username,
          email: state.email,
          profilePicUrl: state.profilePicUrl,
          error: e.toString(),
          passwordChanged: state.passwordChanged,
          isLoggedOut: state.isLoggedOut,
        ));
      }
    });
  }
}
