import 'dart:convert';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as https;
import 'package:handheld_beta/MVC/Controller/DataBase/CambiodbController.dart';
import 'package:handheld_beta/MVC/Model/Usuario.dart';

class UserController {
  final bool isTestDatabase;
  UserController(this.isTestDatabase);

  Future<Usuario?> verifyUsuario(int nit) async {
    final String url = '${Conexion.apiUrl}/User';
    try {
      int referencia = CambiodbController.getDatabaseReference();
      final response = await https.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"nit": nit.toString(), "referencia": referencia}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Usuario.fromJson(data);
      } else {
        mGenericos.falloConexion;
        return null;
      }
    } catch (e) {
      throw Exception('Error de Conexion: ${e.toString()}');
    }
  }
}
