import 'package:dartz/dartz.dart';
import 'package:just_chat_app/core/errors/failures.dart';
import 'package:just_chat_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:just_chat_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:just_chat_app/features/user/domain/entities/user_entitiy.dart';
import 'package:just_chat_app/features/user/domain/repositories/user_repository.dart';

import '../../../../core/errors/exceptions.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  UserRepositoryImpl(this.userRemoteDataSource, this.userLocalDataSource);
  @override
  Future<Either<Failure, bool>> isAuthenticated() async{
    try{
      final token = await userLocalDataSource.getToken();
      return Right(token != null);
    } catch(e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final user = await userRemoteDataSource.login(email, password);
      await userLocalDataSource.cacheToken(user.token);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Null>> signOut() async{
   throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password , String name) async {
    try{
      final user = await userRemoteDataSource.signUp(email, password, name);
      await userLocalDataSource.cacheToken(user.token);
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
