import 'package:dartz/dartz.dart';
import 'package:just_chat_app/features/user/domain/entities/user_entitiy.dart';
import 'package:just_chat_app/features/user/domain/repositories/user_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class Login implements UseCase<UserEntity , LoginParams> {
  final UserRepository repository;
  Login({required this.repository});

  @override
  Future<Either<Failure , UserEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams {
  String email;
  String password;
  LoginParams(this.email , this.password);
}