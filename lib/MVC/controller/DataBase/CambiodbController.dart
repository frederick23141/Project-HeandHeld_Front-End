import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as http;

import '../../Model/Usuario.dart';

class CambiodbController {
  static bool isTestDatabase = true;

  static void setDatabaseState(bool state) {
    isTestDatabase = state;
  }

  static int getDatabaseReference() {
    return isTestDatabase ? 1 : 2;
  }

  final String url = '${Conexion.apiUrl}/Permisostraslado/Cambiodb';
  Future<bool> verifyUsuarioCambiodb(int nitCambiobd) async {
    try {
      int referencia = CambiodbController.getDatabaseReference();
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body:
            json.encode({'nitCambiobd': nitCambiobd, 'referencia': referencia}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String permisoCambiobd = data['nitCambiobd']['permiso'];

        bool esValido = (permisoCambiobd == 'V');

        if (!esValido) {
          if (permisoCambiobd != 'V') {
            throw Exception(mPermisos.permisoCambiobdIncorrecto);
          }
        }
        return esValido;
      } else {
        throw Exception(mGenericos.documentosNoEncontrados);
      }
    } catch (error) {
      throw Exception(mGenericos.verificarCedulas);
    }
  }
}
