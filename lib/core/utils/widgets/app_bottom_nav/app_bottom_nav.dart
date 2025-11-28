// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mini_social_feed/core/bloc/localization/locale_cubit.dart';
// import 'package:mini_social_feed/core/bloc/navigation_cubit/navigation_cubit.dart';
// import 'package:mini_social_feed/core/services/service_locator.dart';
// import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
//
// import '../../resources/icon_manger.dart';
//
// class AppBottomNav extends StatefulWidget {
//   final StatefulNavigationShell navigationShell;
//
//   const AppBottomNav({super.key, required this.navigationShell});
//
//   @override
//   State<AppBottomNav> createState() => _AppBottomNavState();
// }
//
// class _AppBottomNavState extends State<AppBottomNav> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }
//
//   Future<void> _initializeApp() async {
//     final localeCubit = context.read<LocaleCubit>();
//
//     await Future.wait([localeCubit.setInitialLocale()]);
//
//     if (mounted) {}
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<NavigationCubit>(),
//       child: AppBottomNavBody(navigationShell: widget.navigationShell),
//     );
//   }
// }
//
// class AppBottomNavBody extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;
//
//   const AppBottomNavBody({super.key, required this.navigationShell});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<NavigationCubit, NavigationState>(
//       listener: (context, state) {
//         navigationShell.goBranch(state.selectedIndex);
//       },
//       child: BlocBuilder<NavigationCubit, NavigationState>(
//         builder: (context, state) {
//           return Scaffold(
//             body: navigationShell,
//             bottomNavigationBar: NavigationBar(
//               selectedIndex: state.selectedIndex,
//               onDestinationSelected: (index) =>
//                   context.read<NavigationCubit>().setIndex(index),
//               indicatorColor: Colors.transparent,
//               elevation: 0,
//               destinations: [
//                 NavigationDestination(
//                   icon: SvgPicture.asset(AppIconManager.home),
//                   label: '',
//                   selectedIcon: SvgPicture.asset(
//                     AppIconManager.home,
//                     colorFilter: const ColorFilter.mode(
//                       AppColorManager.primary,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//                 NavigationDestination(
//                   icon: SvgPicture.asset(AppIconManager.chat),
//                   label: '',
//                   selectedIcon: SvgPicture.asset(
//                     AppIconManager.chat,
//                     colorFilter: const ColorFilter.mode(
//                       AppColorManager.primary,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//                 NavigationDestination(
//                   icon: SvgPicture.asset(AppIconManager.create),
//                   label: '',
//                   selectedIcon: SvgPicture.asset(
//                     AppIconManager.create,
//                     colorFilter: const ColorFilter.mode(
//                       AppColorManager.primary,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//                 NavigationDestination(
//                   icon: SvgPicture.asset(AppIconManager.alert),
//                   label: '',
//                   selectedIcon: SvgPicture.asset(
//                     AppIconManager.alert,
//                     colorFilter: const ColorFilter.mode(
//                       AppColorManager.primary,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//
//                 NavigationDestination(
//                   icon: SvgPicture.asset(AppIconManager.profile),
//                   label: '',
//                   selectedIcon: SvgPicture.asset(
//                     AppIconManager.profile,
//                     colorFilter: const ColorFilter.mode(
//                       AppColorManager.primary,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_social_feed/core/bloc/navigation_cubit/navigation_cubit.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';

import '../../resources/icon_manger.dart';

class AppBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppBottomNav({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationCubit, NavigationState>(
      listener: (context, state) {
        navigationShell.goBranch(state.selectedIndex);
      },
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          const Color selectedColor = AppColorManager.primary;
          const Color unSelectedColor = AppColorManager.white;

          return Scaffold(
            backgroundColor: AppColorManager.background,
            body: navigationShell,
            bottomNavigationBar: NavigationBar(
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (index) =>
                  context.read<NavigationCubit>().setIndex(index),
              indicatorColor: Colors.transparent,
              elevation: 0,
              backgroundColor: AppColorManager.dark,
              destinations: [
                _buildNavDestination(
                  context,
                  AppIconManager.home,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                ),
                _buildNavDestination(
                  context,
                  AppIconManager.chat,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                ),
                _buildNavDestination(context, AppIconManager.create),
                _buildNavDestination(
                  context,
                  AppIconManager.alert,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                ),
                _buildNavDestination(
                  context,
                  AppIconManager.profile,
                  selectedColor: selectedColor,
                  unSelectedColor: unSelectedColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  NavigationDestination _buildNavDestination(
    BuildContext context,
    String iconPath, {
    Color? selectedColor,
    Color? unSelectedColor,
  }) {
    return NavigationDestination(
      icon: SvgPicture.asset(
        iconPath,
        colorFilter: unSelectedColor != null
            ? ColorFilter.mode(unSelectedColor, BlendMode.srcIn)
            : null,
        width: 14,
        height: 30,
      ),
      label: '',
      selectedIcon: SvgPicture.asset(
        iconPath,
        colorFilter: selectedColor != null
            ? ColorFilter.mode(selectedColor, BlendMode.srcIn)
            : null,
        width: 14,
        height: 30,
      ),
    );
  }
}
