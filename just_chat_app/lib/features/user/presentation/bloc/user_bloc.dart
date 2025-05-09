import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat_app/features/user/domain/entities/user_entitiy.dart';
import 'package:just_chat_app/features/user/domain/use_cases/login.dart';
import 'package:just_chat_app/features/user/domain/use_cases/sign_up.dart';

import '../../domain/use_cases/is_authenticated.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Login login;
  final IsAuthenticated isAuthenticated;
  final SignUp signUp;
  UserBloc(this.login , this.isAuthenticated , this.signUp) : super(UserInitial()) {

    on<CheckAuthentication>((event , emit) async{
      emit(UserLoading());
      final result = await isAuthenticated(NoParams());
      result.fold(
            (failure) => emit(UserFailure(failure.message)),
            (user) => emit(UserAuthenticated()),
      );
    });

    on<LoginEvent>((event, emit) async {
      emit(UserLoading());
      final result = await login(LoginParams(event.email, event.password));
      result.fold(
            (failure) => emit(UserFailure(failure.message)),
            (user) => emit(UserAuthenticated()),
      );
    });

    on<SignUpEvent>((event , emit) async {
      emit(UserLoading());
      final name = event.firstname + event.lastname;
      final result = await signUp(SignUpParams(event.password, event.email, name));
      result.fold(
            (failure) => emit(UserFailure(failure.message)),
            (user) => emit(UserLoaded()),
      );
    });
  }
}
