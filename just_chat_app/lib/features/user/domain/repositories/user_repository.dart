import 'package:dartz/dartz.dart';
import 'package:just_chat_app/features/user/domain/entities/user_entitiy.dart';

import '../../../../core/errors/failures.dart';

abstract class UserRepository {
  Future<Either<Failure , UserEntity>> login(String email , String password);
  Future<Either<Failure , UserEntity>> signUp(String email , String password, String name);
  Future<Either<Failure , bool>> isAuthenticated();
  Future<Either<Failure , Null>> signOut();
}