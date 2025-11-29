import 'package:flutter/material.dart';

class MediaToolBar extends StatelessWidget {
  final VoidCallback? pickMedia;
  final VoidCallback? takePhoto;
  final VoidCallback? pickFile;

  const MediaToolBar({
    super.key,
    this.pickMedia,
    this.takePhoto,
    this.pickFile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.08),
          ),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white70, size: 20),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMediaIcon(Icons.image_outlined, onTap: pickMedia),
              _buildMediaIcon(Icons.camera_alt_outlined, onTap: takePhoto),
              _buildMediaIcon(Icons.attach_file, onTap: pickFile),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMediaIcon(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(icon, color: Colors.white70, size: 22),
      ),
    );
  }
}
