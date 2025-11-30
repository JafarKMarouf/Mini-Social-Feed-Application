import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MediaService {
  Future<PermissionStatus> requestMediaPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt <= 32) {
        return await Permission.storage.request();
      } else {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.photos,
          Permission.videos,
        ].request();

        if (statuses[Permission.photos]!.isGranted ||
            statuses[Permission.videos]!.isGranted) {
          return PermissionStatus.granted;
        }

        if (statuses[Permission.photos]!.isPermanentlyDenied ||
            statuses[Permission.videos]!.isPermanentlyDenied) {
          return PermissionStatus.permanentlyDenied;
        }

        return PermissionStatus.denied;
      }
    } else {
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

    if (status.isGranted || status.isLimited) {
      try {
        final result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.media,
        );

        if (result != null) {
          return result.files;
        }
      } catch (e) {
        log('Error picking files: $e');
      }
    } else if (status.isPermanentlyDenied) {
      log('Permission permanently denied. Opening settings.');
      await openAppSettings();
    } else {
      log('Permission denied');
    }
    return [];
  }

  /// Pick generic documents (PDF, Doc, etc.)
  Future<List<PlatformFile>> pickDocuments() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );

      if (result != null) {
        return result.files;
      }
    } catch (e) {
      log('Error picking documents: $e');
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
          imageQuality: 80,
        );

        if (image != null) {
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
