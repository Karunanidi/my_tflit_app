import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class PermissionsHelper {
  static Future<void> requestMediaPermissions() async {
    final int sdkVersion = await _getSdkVersion();

    // Android 14 (Upside Down Cake) and above
    if (sdkVersion >= 34) {
      await _requestPermissions([
        // Hypothetical for Android 14+, use the correct permissions if available
        Permission.mediaLibrary,
        Permission.camera,
      ]);
    } else if (sdkVersion >= 33) {
      // Android 13 (Tiramisu)
      await _requestPermissions([
        Permission.photos,
        Permission.videos,
      ]);
    } else {
      // Android 12 and below
      await _requestPermissions([
        Permission.storage,
      ]);
    }
  }

  static Future<int> _getSdkVersion() async {
    const MethodChannel platform =
        MethodChannel('com.example.my_tflit_app/PERMISSION');
    try {
      final int sdkVersion = await platform.invokeMethod('getVersion');
      log('sdkVersion: $sdkVersion');
      return sdkVersion;
    } catch (e) {
      return 0;
    }
  }

  static Future<void> _requestPermissions(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> statuses = await permissions.request();
    statuses.forEach((permission, status) {
      if (status.isDenied || status.isPermanentlyDenied) {
        // Directs user to app settings to manually enable permission
        openAppSettings();
      }
    });
  }
}
