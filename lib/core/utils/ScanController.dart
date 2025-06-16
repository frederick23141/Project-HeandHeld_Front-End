import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:native_barcode_scanner/barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../MVC/model/Config_Gener/ScanModel/ScanModel.dart';

class ScanController {
  final ScanModel model;

  ScanController(this.model);

  Future<void> scanAndUpdate(TextEditingController controller) async {
    try {
      final result = await BarcodeScanner.startScanner();

      if (result != null && result.isNotEmpty) {
        model.updateCode(result);
        controller.text = result;
      } else {
        throw Exception(mEscaneo.errorEscaneo);
      }
    } catch (e) {
      throw Exception('Error al escanear: $e');
    }
  }
}
