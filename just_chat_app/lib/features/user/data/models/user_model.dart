import 'package:just_chat_app/features/user/domain/entities/user_entitiy.dart';

class UserModel extends UserEntity {
  UserModel({required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['data']['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
