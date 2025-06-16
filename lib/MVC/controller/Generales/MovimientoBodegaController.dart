import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as http;

import '../../model/MovimientoBodega.dart';
import '../../model/ValidarTiket.dart';
import '../DataBase/CambiodbController.dart';
import '../Generales/PermisosTrasladoController.dart';
import '../GestionAlambronController/ValidarTiketController.dart';

class MovimientoBodegaController {
  final String url = '${Conexion.apiUrl}/MovimientoBodega';

  Future<List<MovimientoBodega>> MovimientoBodegas(
    BuildContext context,
    String tiket,
    String vistaOrigen,
    int gBodega,
    int nitEntrega,
    int nitRecibe,
    String deviceName,
  ) async {
    try {
      int referencia = CambiodbController.getDatabaseReference();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "referencia": referencia,
          "tiket": tiket,
          "gBodega": gBodega,
          "nitEntrega": nitEntrega,
          "nitRecibe": nitRecibe,
          "deviceName": deviceName,
        }),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => MovimientoBodega.fromJson(json)).toList();
      } else {
        throw Exception(mGenericos.sinRespuestaApi);
      }
    } catch (error) {
      throw Exception(mGenericos.falloConexion);
    }
  }
}
