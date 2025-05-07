import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoginRequested>((event, emit) async {
      try {
        emit(UserLoading());
        await Future.delayed(Duration(seconds: 1));
        if (event.email.isNotEmpty && event.password.isNotEmpty) {
          emit(UserLoaded());
        } else {
          throw Exception('Invalid email or password');
        }
      } catch(e){
        emit(UserFailure(e.toString()));
      }
    });

    on<SignupRequested>((event, emit) async {
      try{
        emit(UserLoading());
        await Future.delayed(Duration(seconds: 1));
        if(event.firstname.isNotEmpty && event.lastname.isNotEmpty && event.email.isNotEmpty && event.password.isNotEmpty){
          emit(UserLoaded());
        } else {
          throw Exception('All fields are required');
        }
      } catch(e){
        emit(UserFailure(e.toString()));
      }
    });
  }
}
