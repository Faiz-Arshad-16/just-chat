import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getToken();
  Future<void> removeToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheToken(String token) async {
    await sharedPreferences.setString("auth_token", token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString("auth_token");
  }

  @override
  Future<void> removeToken() async {
    await sharedPreferences.remove("auth_token");
  }
  
}