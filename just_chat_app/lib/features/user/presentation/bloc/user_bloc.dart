import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat_app/features/user/domain/use_cases/login.dart';

import '../../domain/use_cases/is_authenticated.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final Login login;
  final IsAuthenticated isAuthenticated;
  UserBloc(this.login , this.isAuthenticated) : super(UserInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(UserLoading());
      final result = await login(LoginParams(event.email, event.password));
      result.fold(
            (failure) => emit(UserFailure(failure.message)),
            (user) => emit(UserLoaded()),
      );
    });
  }
}
