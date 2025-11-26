import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/routes/app_navigator.dart';
import 'package:mini_social_feed/core/routes/app_router_constants.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/intro_page1.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/intro_page2.dart';
import 'package:mini_social_feed/features/intro/presentation/pages/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void navigateToNextPage(
  PageController controller,
  int currentPageIndex,
  int totalPages,
  BuildContext context,
) {
  if (currentPageIndex < totalPages - 1) {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController controller = PageController();
  int currentPageIndex = 0;
  final int totalPages = 3;

  void _dismissKeyboard() => FocusScope.of(context).unfocus();

  @override
  Widget build(BuildContext context) {
    final bool isLast = currentPageIndex == 2;

    return Scaffold(
      backgroundColor: AppColorManager.background,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _dismissKeyboard,
          child: Stack(
            children: [
              PageView(
                controller: controller,
                onPageChanged: (value) =>
                    setState(() => currentPageIndex = value),
                children: const [IntroPage1(), IntroPage2(), IntroPage3()],
              ),

              Align(
                alignment: const Alignment(0, 0.75),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: totalPages,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 7,
                    dotWidth: 16,
                    spacing: 4.0,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColorManager.gray,
                blurRadius: 8.0,
                spreadRadius: 1.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: () {
              if (isLast) {
                AppNavigator.pushReplacement(context, AppRoutePaths.login);
              } else {
                navigateToNextPage(
                  controller,
                  currentPageIndex,
                  totalPages,
                  context,
                );
              }
            },
            elevation: 8,
            shape: const CircleBorder(),
            child: Icon(
              isLast ? Icons.check : Icons.arrow_forward,
              size: 39,
              color: AppColorManager.background,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
