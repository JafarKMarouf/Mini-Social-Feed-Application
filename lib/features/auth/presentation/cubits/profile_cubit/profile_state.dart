part of 'profile_cubit.dart';

final class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileFailureState extends ProfileState {
  final String errMsg;
  final int? statusCode;

  ProfileFailureState({required this.errMsg, this.statusCode});
}

final class ProfileSuccessState extends ProfileState {
  final ApiResponse<UserModel> data;

  ProfileSuccessState({required this.data});
}
