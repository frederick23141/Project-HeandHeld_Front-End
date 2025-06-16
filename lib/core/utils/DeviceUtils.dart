import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeviceUtils {
  static Future<String> getDeviceName() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceName = 'Unknown Device';

    try {
      if (identical(0, 0.0)) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceName = androidInfo.model;
      } else {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceName = iosInfo.name;
      }
    } catch (e) {
      print('Error al obtener el nombre del dispositivo: $e');
    }
    return deviceName;
  }
}
