part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final ApiResponse<LoginData> data;

  LoginSuccessState({required this.data});
}

final class LoginFailureState extends LoginState {
  final String errMsg;
  final int? statusCode;

  LoginFailureState({required this.errMsg, this.statusCode});
}

class PasswordVisibilityChanged extends LoginState {
  final bool isHidden;

  PasswordVisibilityChanged({required this.isHidden});
}
