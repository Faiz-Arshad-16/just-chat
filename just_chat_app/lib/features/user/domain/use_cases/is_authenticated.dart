import 'package:dartz/dartz.dart';
import 'package:just_chat_app/core/errors/failures.dart';
import 'package:just_chat_app/core/usecases/usecase.dart';
import 'package:just_chat_app/features/user/domain/repositories/user_repository.dart';

class IsAuthenticated implements UseCase<bool , NoParams> {
  final UserRepository repository;
  IsAuthenticated(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
   return await repository.isAuthenticated();
  }
}

class NoParams {}