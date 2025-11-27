import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/data/repositories/auth_repository.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    var result = await getIt<AuthRepository>().logout();
    result.fold(
      (fail) => emit(LogoutFailure(fail.errMessage)),
      (success) => emit(LogoutSuccess()),
    );
  }
}
