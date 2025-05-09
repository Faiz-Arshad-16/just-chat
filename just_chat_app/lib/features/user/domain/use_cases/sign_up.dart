import 'package:dartz/dartz.dart';
import 'package:just_chat_app/core/errors/failures.dart';
import 'package:just_chat_app/core/usecases/usecase.dart';
import 'package:just_chat_app/features/user/domain/entities/user_entitiy.dart';
import 'package:just_chat_app/features/user/domain/repositories/user_repository.dart';

class SignUp implements UseCase<UserEntity, SignUpParams> {
  final UserRepository repository;

  SignUp(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async{
    return await repository.signUp(params.email, params.password, params.name);
  }
}

class SignUpParams {
  String email;
  String password;
  String name;

  SignUpParams(this.password, this.email, this.name);
}
