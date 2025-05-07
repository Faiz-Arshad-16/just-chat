import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:just_chat_app/features/user/di/user_injection.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => http.Client());

  initUser(getIt); // Initialize user feature
}