import 'package:dartz/dartz.dart';
import 'package:just_chat_app/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}