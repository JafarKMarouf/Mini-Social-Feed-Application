import 'package:mini_social_feed/features/auth/data/models/token_model.dart';
import 'package:mini_social_feed/features/auth/data/models/user_model.dart';

class LoginData {
  LoginData();

  factory LoginData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('tokens')) {
      return LoginSuccess.fromJson(json);
    } else {
      throw Exception('Unknown login response type');
    }
  }
}

class LoginSuccess extends LoginData {
  final UserModel userModel;
  final TokenModel tokenModel;

  LoginSuccess({required this.userModel, required this.tokenModel});

  factory LoginSuccess.fromJson(Map<String, dynamic> json) {
    return LoginSuccess(
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tokenModel: TokenModel.fromJson(json['tokens'] as Map<String, dynamic>),
    );
  }
}
