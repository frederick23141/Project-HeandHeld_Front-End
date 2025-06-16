import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:handheld_beta/MVC/Controller/DataBase/CambiodbController.dart';
import 'package:handheld_beta/MVC/Model/ObtenerPedidoGalvanizado.dart';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as http;

class GalvanizadoController {
  Future<List<ObtenerPedidoGalvanizado>> ObtenerPedidoGalvanizados(
      String devolver) async {
    final String url = '${Conexion.apiUrl}/ObtenerGalvanizado';
    try {
      int referencia = CambiodbController.getDatabaseReference();
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({"devolver": devolver, "referencia": referencia}),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data
            .map((json) => ObtenerPedidoGalvanizado.fromJson(json))
            .toList();
      } else {
        throw Exception(mGenericos.sinRespuestaApi);
      }
    } catch (error) {
      throw Exception(mGenericos.falloConexion);
    }
  }

  void salir(BuildContext context, Widget home) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => home),
    );
  }

  void actualizar(VoidCallback actualizarCallback) {
    actualizarCallback();
  }
}
