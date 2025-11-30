import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/features/posts/data/requests/fetch_post_list_request.dart';

class BuildFilterChips extends StatelessWidget {
  final String? selectedMediaType;
  final ValueChanged<String?> onFilterSelected;

  const BuildFilterChips({
    super.key,
    required this.selectedMediaType,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'label': 'Photos', 'value': MediaType.image.name, 'icon': Icons.image},
      {
        'label': 'Videos',
        'value': MediaType.video.name,
        'icon': Icons.videocam,
      },
      {
        'label': 'Audio',
        'value': MediaType.audio.name,
        'icon': Icons.audiotrack,
      },
      {
        'label': 'Docs',
        'value': MediaType.document.name,
        'icon': Icons.article,
      },
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final type = filter['value'] as String;

          final isSelected = selectedMediaType == type;

          return GestureDetector(
            onTap: () => onFilterSelected(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColorManager.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColorManager.primary
                      : Colors.grey[700]!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    filter['icon'] as IconData,
                    size: 16,
                    color: isSelected ? Colors.white : Colors.grey[400],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    filter['label'] as String,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
