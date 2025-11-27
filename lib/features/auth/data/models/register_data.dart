import 'package:mini_social_feed/features/auth/data/models/token_model.dart';
import 'package:mini_social_feed/features/auth/data/models/user_model.dart';

class RegisterData {
  RegisterData();

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('tokens')) {
      return RegisterSuccess.fromJson(json);
    } else if (json.containsKey('errors')) {
      return RegisterFailure.fromJson(json);
    } else {
      throw Exception('error');
    }
  }
}

class RegisterSuccess extends RegisterData {
  final UserModel userModel;
  final TokenModel tokenModel;

  RegisterSuccess({required this.userModel, required this.tokenModel});

  factory RegisterSuccess.fromJson(Map<String, dynamic> json) {
    return RegisterSuccess(
      userModel: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      tokenModel: TokenModel.fromJson(json['tokens'] as Map<String, dynamic>),
    );
  }
}

class RegisterFailure extends RegisterData {
  final String message;
  final Map<String, String> errors;

  RegisterFailure({required this.message, required this.errors});

  factory RegisterFailure.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> errorMapDynamic =
        json['errors'] as Map<String, dynamic>;
    final Map<String, String> validationErrors = {};

    errorMapDynamic.forEach((key, value) {
      if (value is List && value.isNotEmpty) {
        validationErrors[key] = value.first.toString();
      }
    });

    return RegisterFailure(
      message: json['message'] as String,
      errors: validationErrors,
    );
  }
}
