import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/features/auth/presentation/widgets/login_widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void _dismissKeyboard(BuildContext context) =>
      FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.background,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _dismissKeyboard(context),
        child: const LoginViewBody(),
      ),
    );
  }
}
