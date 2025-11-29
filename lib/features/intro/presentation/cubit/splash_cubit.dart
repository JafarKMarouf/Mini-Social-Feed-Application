import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/services/secure_storage_service.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAppStatus() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 4));

    String? accessToken = await SecureStorageService.getAccessToken();
    String? refreshToken = await SecureStorageService.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      emit(SplashUnAuthenticated());
    } else {
      emit(SplashAuthenticated());
    }
  }
}
