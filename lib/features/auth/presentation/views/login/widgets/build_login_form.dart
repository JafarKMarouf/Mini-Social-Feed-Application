import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/utils/helper/validator.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/form_field/app_form_field.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/login_cubit/login_cubit.dart';

class BuildLoginForm extends StatelessWidget {
  const BuildLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final cubit = context.read<LoginCubit>();
        return Form(
          key: cubit.formKey,
          autovalidateMode: cubit.autoValidateMode,
          child: Column(
            children: [
              AppTextFormField(
                controller: cubit.emailController,
                width: AppWidthManager.w90,
                maxLines: 1,
                labelText: AppLocalizations.of(context).enterEmail,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: Validator.emailRequired,
              ),

              SizedBox(height: AppHeightManager.h3),

              AppTextFormField(
                controller: cubit.passwordController,
                obscureText: cubit.isPasswordHidden,
                width: AppWidthManager.w90,
                maxLines: 1,
                labelText: AppLocalizations.of(context).enterPassword,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                validator: Validator.passwordLogin,
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.remove_red_eye_outlined,
                    size: AppRadiusManager.r25,
                    color: AppColorManager.darkGray,
                  ),
                  onPressed: cubit.togglePasswordVisibility,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
