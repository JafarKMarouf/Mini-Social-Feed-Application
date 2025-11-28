import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/utils/helper/app_alert_dialog.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';
import 'package:mini_social_feed/features/auth/presentation/cubits/logout_cubit/logout_cubit.dart';
import 'package:mini_social_feed/features/profile/presentation/widget/profile_header.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    final isRtl = direction == TextDirection.rtl;
    final int quarterTurns = isRtl ? 2 : 0;

    final locale = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        top: AppHeightManager.h2,
        left: AppWidthManager.w5,
        right: AppWidthManager.w5,
      ),
      child: Column(
        children: [
          const ProfileHeader(),
          SizedBox(height: AppHeightManager.h2),

          GestureDetector(
            onTap: () {},
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColorManager.darkGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white),
                  const SizedBox(width: 25),
                  AppTextWidget(
                    text: locale.myAdsManagement,
                    style: AppTextStyle.styleUrbanistBold17(
                      context,
                    ).copyWith(color: AppColorManager.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: AppHeightManager.h2),
          const Divider(color: AppColorManager.darkGray),

          SizedBox(height: AppHeightManager.h2),
          Expanded(
            child: ListView(
              children: [
                _buildItem(
                  context,
                  title: locale.changePassword,
                  iconData: Icons.vpn_key_rounded,
                  onTap: () {},
                ),
                _buildItem(
                  context,
                  title: locale.changeLanguage,
                  iconData: Icons.translate,
                  onTap: () {
                    context.read<LocaleCubit>().toggleLocale();
                  },
                ),
                _buildItem(
                  context,
                  title: locale.aboutApp,
                  color: AppColorManager.primary,
                  iconData: Icons.info_outline,
                  onTap: () {},
                ),

                _buildItem(
                  context,
                  title: locale.privacyPolicy,
                  iconData: Icons.privacy_tip_outlined,
                  onTap: () {},
                ),
                _buildItem(
                  context,
                  title: locale.logout,
                  icon: RotatedBox(
                    quarterTurns: quarterTurns,
                    child: const Icon(
                      Icons.logout,
                      color: AppColorManager.primary,
                      size: 28,
                    ),
                  ),
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (contextBuilder) => appAlertDialog(
        contextBuilder,
        title: AppLocalizations().logout,
        subTitle: AppLocalizations().logoutConfirmation,
        icon: Icons.logout_outlined,
        onPressed: () {
          AppNavigator.pop();
          _performLogout(context);
        },
      ),
    );
  }

  Future<void> _performLogout(BuildContext context) async {
    await context.read<LogoutCubit>().logout();
  }

  Widget _buildItem(
    BuildContext context, {
    required String title,
    IconData? iconData,
    Widget? icon,
    Color? color,
    VoidCallback? onTap,
  }) {
    return Card(
      color: AppColorManager.inputFillColor,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        trailing:
            icon ?? Icon(iconData, color: color ?? AppColorManager.primary),
        title: AppTextWidget(
          textDirection: TextDirection.rtl,
          text: title,
          style: AppTextStyle.styleUrbanistBold17(
            context,
          ).copyWith(color: AppColorManager.dark),
        ),
        leading: const Icon(
          Icons.arrow_back_ios_new,
          size: 20,
          color: AppColorManager.primary,
        ),
      ),
    );
  }
}
