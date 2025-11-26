import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_social_feed/core/l10n/l10n.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/font_manager.dart';
import 'package:mini_social_feed/core/utils/resources/image_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizeManager.s20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 1),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.8,
              child: SvgPicture.asset(
                AppImageManager.imagesIntro1,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizeManager.s64),
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 3,
              text: TextSpan(
                style: TextStyle(
                  height: AppHeightManager.h02,
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w500,
                  color: AppColorManager.white,
                ),
                children: <TextSpan>[
                  TextSpan(text: '${AppLocalizations.of(context).intro1} \n'),
                ],
              ),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
