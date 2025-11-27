part of 'logout_cubit.dart';

sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutFailure extends LogoutState {
  final String errMsg;

  LogoutFailure(this.errMsg);
}

final class LogoutSuccess extends LogoutState {}
