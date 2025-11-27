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
import 'package:mini_social_feed/core/utils/widgets/loading/loading_overlay.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:mini_social_feed/features/auth/presentation/views/register/widgets/build_register_form.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  void _dismissKeyboard(BuildContext context) =>
      FocusScope.of(context).unfocus();

  void _onRegisterPressed(BuildContext context) {
    _dismissKeyboard(context);
    final cubit = context.read<RegisterCubit>();

    if (Validator.validateForm(cubit.formKey)) {
      cubit.register(cubit.createRegisterRequest());
    } else {
      cubit.autoValidateMode = AutovalidateMode.always;
    }
  }

  void _handleStateChanges(BuildContext context, RegisterState state) {
    if (state is RegisterSuccessState) {
      AppSnackBar.success(context, state.data.message);
      AppNavigator.pushNamedAndRemoveUntil(AppRoutePaths.home);
    }
    if (state is RegisterFailureState) {
      AppSnackBar.error(context, state.errMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
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
                      children: [
                        AppTextWidget(
                          text: AppLocalizations.of(context).welcomeRegister,
                          style: AppTextStyle.styleUrbanistBold30(
                            context,
                          ).copyWith(color: AppColorManager.white),
                          maxLines: 2,
                        ),
                        SizedBox(height: AppHeightManager.h8),
                        const BuildRegisterForm(),
                        SizedBox(height: AppHeightManager.h5),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            return AppPrimaryButton(
                              backgroundColor: AppColorManager.primary,
                              text: state is RegisterLoadingState
                                  ? AppLocalizations.of(context).loading
                                  : AppLocalizations.of(context).register,
                              width: AppWidthManager.w90,
                              onPressed: () => _onRegisterPressed(context),
                            );
                          },
                        ),
                        SizedBox(height: AppHeightManager.h1),
                        _loginPrompt(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return buildLoadingOverlay(state is RegisterLoadingState);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginPrompt(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppHeightManager.h2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              AppNavigator.pushReplacementNamed(AppRoutePaths.login);
            },
            child: Text.rich(
              TextSpan(
                text: AppLocalizations.of(context).alreadyHaveAccount,
                style: AppTextStyle.styleUrbanistBold17(
                  context,
                ).copyWith(color: AppColorManager.white),
                children: <TextSpan>[
                  TextSpan(
                    text: AppLocalizations().login,
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
