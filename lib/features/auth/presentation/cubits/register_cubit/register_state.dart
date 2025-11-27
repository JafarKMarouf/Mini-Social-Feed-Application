part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final ApiResponse<RegisterData> data;

  RegisterSuccessState({required this.data});
}

class RegisterFailureState extends RegisterState {
  final String errMsg;
  final int? statusCode;

  RegisterFailureState({required this.errMsg, this.statusCode});
}

class PasswordVisibilityChanged extends RegisterState {
  final bool isHidden;

  PasswordVisibilityChanged({required this.isHidden});
}
