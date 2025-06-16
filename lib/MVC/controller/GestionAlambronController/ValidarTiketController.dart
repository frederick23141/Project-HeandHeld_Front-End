import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as http;

import '../../model/ValidarTiket.dart';
import '../DataBase/CambiodbController.dart';

class ValidarTiketController {
  static String tiket = '';

  final String url = '${Conexion.apiUrl}/ValidarTiket';

  Future<List<ValidarTiket>> validarTiket(String tiket) async {
    try {
      int referencia = CambiodbController.getDatabaseReference();
      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode({"Tiket": tiket, "referencia": referencia}));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => ValidarTiket.fromJson(json)).toList();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(mEscaneo.codigo);
    }
  }

  static String getTiketReference() {
    return tiket = '';
  }
}
