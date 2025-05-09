import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_chat_app/features/user/data/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String email , String password , String name);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  final Uri uri = Uri.parse("https://famous-anthea-alladin-db67a8f9.koyeb.app/auth/signin");

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse("https://famous-anthea-alladin-db67a8f9.koyeb.app/auth/signin"),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(responseBody);
      return userModel;
    } else {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final errorMessage = responseBody['message'] ?? 'An Error Occurred while Signing In';
      throw ServerException("$errorMessage");
    }
  }

  @override
  Future<UserModel> signUp(String email, String password, String name) async {
    final response = await client.post(
      Uri.parse("https://famous-anthea-alladin-db67a8f9.koyeb.app/auth/signup"),
      body: jsonEncode({'email': email, 'password': password , 'name' : name}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final userModel = UserModel.fromJson(responseBody);
      return userModel;
    } else {
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      final errorMessage = responseBody['message'] ?? 'An Error Occurred while Signing In';
      throw ServerException("$errorMessage");
    }
  }
}
