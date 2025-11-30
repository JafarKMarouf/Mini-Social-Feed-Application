import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/app_text_style.dart';
import 'package:mini_social_feed/core/utils/resources/image_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:mini_social_feed/core/utils/widgets/app_text/app_text_widget.dart';

class ChangeLangLoading extends StatelessWidget {
  const ChangeLangLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Positioned.fill(
            child: Container(
              color: AppColorManager.background,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      width: 90,
                      height: 90,
                      AppImageManager.branding,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: AppHeightManager.h2),

                    AppTextWidget(
                      text: '${AppLocalizations().changeLanguage}...',
                      style: AppTextStyle.styleUrbanistBold17(
                        context,
                      ).copyWith(color: AppColorManager.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
