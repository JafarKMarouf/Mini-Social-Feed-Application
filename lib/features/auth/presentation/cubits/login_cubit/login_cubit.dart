import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/data/models/login_data.dart';
import 'package:mini_social_feed/features/auth/data/repositories/auth_repository.dart';
import 'package:mini_social_feed/features/auth/data/requests/login_user_request.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    _initializeControllers();
  }

  // Text editing controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  late AutovalidateMode autoValidateMode;

  // Password visibility state
  bool _isPasswordHidden = true;

  bool get isPasswordHidden => _isPasswordHidden;

  void _initializeControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    autoValidateMode = AutovalidateMode.disabled;
  }

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    emit(PasswordVisibilityChanged(isHidden: _isPasswordHidden));
  }

  Future<void> login(LoginUserRequest request) async {
    emit(LoginLoadingState());

    var result = await getIt<AuthRepository>().login(request: request);
    result.fold(
      (fail) {
        emit(
          LoginFailureState(
            errMsg: fail.errMessage,
            statusCode: fail.statusCode,
          ),
        );
      },
      (success) async {
        clearForm();
        emit(LoginSuccessState(data: success));
      },
    );
  }

  LoginUserRequest createLoginRequest() {
    return LoginUserRequest(
      email: emailController.text.trim().toLowerCase(),
      password: passwordController.text,
    );
  }

  void clearForm() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
