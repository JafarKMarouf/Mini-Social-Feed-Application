import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/image_manager.dart';

class AppPatternBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? borderRadius;

  const AppPatternBackground({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A6430), Color(0xFF0C8C53), Color(0xFF66BB6A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius:
            borderRadius ??
            const BorderRadius.vertical(bottom: Radius.circular(20)),
        image:  const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(AppImageManager.pattern,),
          colorFilter: ColorFilter.mode(AppColorManager.primary, BlendMode.srcIn),
          repeat: ImageRepeat.repeat,
          opacity: 0.07,
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }
}
