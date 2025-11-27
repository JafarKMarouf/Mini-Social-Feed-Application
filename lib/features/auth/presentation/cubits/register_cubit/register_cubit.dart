import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/data/models/register_data.dart';
import 'package:mini_social_feed/features/auth/data/repositories/auth_repository.dart';
import 'package:mini_social_feed/features/auth/data/requests/register_user_request.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial()) {
    _initializeControllers();
  }

  // Text editing controllers
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;
  late AutovalidateMode autoValidateMode;

  // Password visibility state
  bool _isPasswordHidden = true;

  bool get isPasswordHidden => _isPasswordHidden;

  void _initializeControllers() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    autoValidateMode = AutovalidateMode.disabled;
  }

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    emit(PasswordVisibilityChanged(isHidden: _isPasswordHidden));
  }

  Future<void> register(RegisterUserRequest request) async {
    emit(RegisterLoadingState());

    var result = await getIt<AuthRepository>().register(request: request);
    result.fold(
      (fail) {
        emit(
          RegisterFailureState(
            errMsg: fail.errMessage,
            statusCode: fail.statusCode,
          ),
        );
      },
      (success) {
        clearForm();
        emit(RegisterSuccessState(data: success));
      },
    );
  }

  RegisterUserRequest createRegisterRequest() {
    return RegisterUserRequest(
      name: nameController.text.trim(),
      email: emailController.text.trim().toLowerCase(),
      password: passwordController.text,
    );
  }

  void clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
