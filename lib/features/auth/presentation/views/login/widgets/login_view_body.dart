import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/utils/helper/app_snackbar.dart';
import 'package:mini_social_feed/core/utils/helper/validator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/core/utils/widgets/buttons/app_primary_button.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/views/login/widgets/build_login_form.dart';

import '../../../../../../core/utils/widgets/loading/loading_overlay.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  void _dismissKeyboard(BuildContext context) =>
      FocusScope.of(context).unfocus();

  void _onLoginPressed(BuildContext context) {
    _dismissKeyboard(context);
    final cubit = context.read<LoginCubit>();

    if (Validator.validateForm(cubit.formKey)) {
      cubit.login(cubit.createLoginRequest());
    } else {
      cubit.autoValidateMode = AutovalidateMode.always;
    }
  }

  void _handleStateChanges(BuildContext context, LoginState state) {
    if (state is LoginSuccessState) {
      AppSnackBar.success(context, state.data.message);
      AppNavigator.pushNamedAndRemoveUntil(AppRoutePaths.home);
    }

    if (state is LoginFailureState) {
      AppSnackBar.error(context, state.errMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) => _handleStateChanges(context, state),
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppWidthManager.w4,
                      vertical: AppHeightManager.h5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context).welcomeLogin,
                          style: AppTextStyle.styleUrbanistBold30(
                            context,
                          ).copyWith(color: AppColorManager.white),
                          maxLines: 2,
                        ),
                        SizedBox(height: AppHeightManager.h8),
                        const BuildLoginForm(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppHeightManager.h2,
                            right: AppWidthManager.w3,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _dismissKeyboard(context);
                              // AppNavigator.pushNamed(
                              //   AppRoutePaths.forgetPassword,
                              // );
                            },
                            child: AppTextWidget(
                              text: AppLocalizations.of(context).forgetPassword,
                              style: AppTextStyle.styleUrbanistSemiBold15(
                                context,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppHeightManager.h5),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            return AppPrimaryButton(
                              backgroundColor: AppColorManager.primary,
                              text: state is LoginLoadingState
                                  ? AppLocalizations.of(context).loading
                                  : AppLocalizations.of(context).login,
                              width: AppWidthManager.w90,
                              onPressed: () => _onLoginPressed(context),
                            );
                          },
                        ),
                        SizedBox(height: AppHeightManager.h1),
                        _registerPrompt(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return buildLoadingOverlay(state is LoginLoadingState);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerPrompt(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppHeightManager.h2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              AppNavigator.pushReplacementNamed(AppRoutePaths.register);
            },
            child: Text.rich(
              TextSpan(
                text: AppLocalizations.of(context).dontHaveAccount,
                style: AppTextStyle.styleUrbanistBold17(
                  context,
                ).copyWith(color: AppColorManager.white),
                children: <TextSpan>[
                  TextSpan(
                    text: AppLocalizations.of(context).register,
                    style: AppTextStyle.styleUrbanistBold17(
                      context,
                    ).copyWith(color: AppColorManager.primary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
