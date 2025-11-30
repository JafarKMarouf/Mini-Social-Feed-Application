import 'package:flutter/material.dart';
import 'package:mini_social_feed/core/utils/resources/app_color_manager.dart';
import 'package:mini_social_feed/core/utils/resources/size_manager.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPostView extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPostView({super.key, required this.videoUrl});

  @override
  State<VideoPlayerPostView> createState() => _VideoPlayerPostViewState();
}

class _VideoPlayerPostViewState extends State<VideoPlayerPostView> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    try {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize()
            .then((_) {
              if (mounted) {
                setState(() {
                  _isInitialized = true;
                });
              }
            })
            .catchError((error) {
              debugPrint('Video Player Error: $error');
              debugPrint('Failed URL: ${widget.videoUrl}');

              if (mounted) {
                setState(() {
                  _hasError = true;
                });
              }
            });

      _controller.addListener(() {
        if (mounted && _controller.value.isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = _controller.value.isPlaying;
          });
        }
      });
    } catch (e) {
      debugPrint('General Exception: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    } else if (!_isInitialized) {
      return _buildPlaceholder(
        child: const Center(
          child: CircularProgressIndicator(color: AppColorManager.primary),
        ),
      );
    } else if (_isInitialized && _controller.value.isInitialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            // Calculates height automatically
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),

                // Overlay Play Button
                if (!_isPlaying && !_controller.value.isBuffering)
                  Container(
                    color: Colors.black26,
                    // Darken background slightly when paused
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                      size: 60.0,
                    ),
                  ),

                // Loading Indicator
                if (_controller.value.isBuffering)
                  const CircularProgressIndicator(
                    color: AppColorManager.primary,
                  ),
              ],
            ),
          ),
          // child: SizedBox(
          //   width: double.infinity,
          //   child: Stack(
          //     alignment: Alignment.center,
          //     children: [
          //       VideoPlayer(_controller),
          //       if (!_isPlaying && !_controller.value.isBuffering)
          //         Container(
          //           color: AppColorManager.dark,
          //           alignment: Alignment.center,
          //           child: const Icon(
          //             Icons.play_circle_fill,
          //             color: Colors.white,
          //             size: 60.0,
          //           ),
          //         ),
          //       if (_controller.value.isBuffering)
          //         const CircularProgressIndicator(
          //           color: AppColorManager.primary,
          //         ),
          //     ],
          //   ),
          // ),
        ),
      );
    } else {
      return _buildErrorWidget();
    }
  }

  Widget _buildPlaceholder({Widget? child}) {
    return Container(
      height: AppHeightManager.h27,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColorManager.darkGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  Widget _buildErrorWidget() {
    return _buildPlaceholder(
      child: const Center(
        child: Icon(Icons.error, color: AppColorManager.gray),
      ),
    );
  }
}
