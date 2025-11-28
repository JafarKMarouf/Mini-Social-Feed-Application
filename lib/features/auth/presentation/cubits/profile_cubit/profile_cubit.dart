import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/network/api_response.dart';
import 'package:mini_social_feed/core/services/service_locator.dart';
import 'package:mini_social_feed/features/auth/data/models/user_model.dart';

import '../../../data/repositories/auth_repository.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitialState());

  Future<void> getMyInfos() async {
    if (isClosed) return;

    var result = await getIt<AuthRepository>().getMyInfos();
    if (isClosed) return;
    result.fold(
      (fail) {
        if (!isClosed) {
          emit(
            ProfileFailureState(
              errMsg: fail.errMessage,
              statusCode: fail.statusCode,
            ),
          );
        }
      },
      (success) async {
        if (!isClosed) {
          emit(ProfileSuccessState(data: success));
        }
      },
    );
  }
}
