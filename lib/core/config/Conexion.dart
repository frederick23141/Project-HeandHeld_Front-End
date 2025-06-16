import 'dart:developer';
import 'dart:io';

import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as https;

class Conexion {
  //static const apiUrl = 'https://10.10.10.133:7029';
  static const apiUrl = 'https://10.10.10.137:7029';
  static void init() {
    HttpOverrides.global = MyHttpOverrides();
  }

  static Future<void> makeRequest() async {
    try {
      final response = await https.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        mGenericos.rExitosa;
      } else {
        mGenericos.errorGenerico;
      }
    } catch (e) {
      mGenericos.sinRespuestaApi;
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
