import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaService {
  Future<PermissionStatus> requestMediaPermission() async {
    if (Platform.isAndroid) {
      // We need to check the Android SDK version
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.request();
      } else {
        // Android 13+ (SDK 33) uses granular permissions (photos, videos)
        // We request both to ensure we can pick all media types
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
          Permission.videos,
        ].request();

        // Logic to determine overall status:
        // If either is granted, we can proceed.
        if (statuses[Permission.photos]!.isGranted ||
            statuses[Permission.videos]!.isGranted) {
          return PermissionStatus.granted;
        }

        // If either is permanently denied, we treat it as permanently denied
        if (statuses[Permission.photos]!.isPermanentlyDenied ||
            statuses[Permission.videos]!.isPermanentlyDenied) {
          return PermissionStatus.permanentlyDenied;
        }

        return PermissionStatus.denied;
      }
    } else {
      // iOS
      // Permission.photos handles the gallery access
      return await Permission.photos.request();
    }
  }

  /// Request Camera Permission
  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.request();
    if (status.isPermanentlyDenied) {
      log('Camera permission permanently denied');
      openAppSettings();
    }
    return status.isGranted;
  }

  Future<List<PlatformFile>> pickMedia() async {
    final status = await requestMediaPermission();

    // Check for granted or limited (iOS specific limited access)
    if (status.isGranted || status.isLimited) {
      try {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.media, // Allows images and videos
        );

        if (result != null) {
          return result.files;
        }
      } catch (e) {
        log('Error picking files: $e');
      }
    } else if (status.isPermanentlyDenied) {
      // Handle permission permanently denied - guide user to settings
      log('Permission permanently denied. Opening settings.');
      await openAppSettings();
    } else {
      // Handle permission denied (user clicked 'Deny' but not 'Don't ask again')
      log('Permission denied');
    }
    return [];
  }

  /// Pick generic documents (PDF, Doc, etc.)
  Future<List<PlatformFile>> pickDocuments() async {
    // Note: System file pickers (SAF on Android) often don't need explicit
    // storage permissions for "opening" documents, but it's good practice
    // to check or handle exceptions. We try picking directly.
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any, // Allows any file type
      );

      if (result != null) {
        // Filter out media types if you strictly want documents only,
        // or just return everything.
        return result.files;
      }
    } catch (e) {
      log('Error picking documents: $e');
      // If error is permission related, prompt settings
    }
    return [];
  }

  /// Take a photo using the Camera
  Future<PlatformFile?> takePhoto() async {
    final hasPermission = await requestCameraPermission();

    if (hasPermission) {
      try {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80, // Optional optimization
        );

        if (image != null) {
          // Convert XFile to PlatformFile
          // We calculate size manually if needed, or leave at 0 if not critical immediately
          int size = 0;
          try {
            size = await File(image.path).length();
          } catch (_) {}

          return PlatformFile(
            name: image.name,
            path: image.path,
            size: size,
            bytes: null,
            readStream: null,
          );
        }
      } catch (e) {
        log('Error taking photo: $e');
      }
    }
    return null;
  }
}
