import 'package:get_it/get_it.dart';
import 'package:just_chat_app/features/user/data/data_sources/user_local_data_source.dart';
import 'package:just_chat_app/features/user/data/data_sources/user_remote_data_source.dart';
import 'package:just_chat_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:just_chat_app/features/user/domain/repositories/user_repository.dart';
import 'package:just_chat_app/features/user/domain/use_cases/is_authenticated.dart';
import 'package:just_chat_app/features/user/domain/use_cases/login.dart';
import 'package:just_chat_app/features/user/domain/use_cases/sign_up.dart';

void initUser(GetIt getIt) {
  // data sources
  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSourceImpl(getIt()));
  
  // repositories
  
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt(), getIt()));
  
  // use cases
  getIt.registerLazySingleton(() => Login(repository: getIt()));
  getIt.registerLazySingleton(() => SignUp(getIt()));
  getIt.registerLazySingleton(() => IsAuthenticated(getIt()));
}