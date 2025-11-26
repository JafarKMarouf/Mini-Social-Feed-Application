import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAppStatus() async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 4));
    emit(SplashLoaded());
  }

  @override
  void onChange(Change<SplashState> change) {
    log('${change.currentState}, ${change.nextState}');
    super.onChange(change);
  }
}
