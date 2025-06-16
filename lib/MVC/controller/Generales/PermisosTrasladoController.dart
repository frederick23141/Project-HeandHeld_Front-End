import 'dart:convert';
import 'package:handheld_beta/core/config/Conexion.dart';
import 'package:handheld_beta/core/constants/CustomMessages.dart';
import 'package:http/http.dart' as http;

import '../DataBase/CambiodbController.dart';

class PermisostrasladoController {
  final String url = '${Conexion.apiUrl}/Permisostraslado';
  Future<bool> verifyPermisostraslado(int nitEntrega, int nitRecibe) async {
    try {
      int referencia = CambiodbController.getDatabaseReference();
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'nitEntrega': nitEntrega,
          'nitRecibe': nitRecibe,
          'referencia': referencia
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String permisoEntrega = data['nitEntrega']['permiso'];
        String permisoRecibe = data['nitRecibe']['permiso'];

        bool esValido = (permisoEntrega == 'E' && permisoRecibe == 'R');

        if (!esValido) {
          if (permisoEntrega != 'E') {
            throw Exception(mPermisos.permisoEntregaIncorrecto);
          }
          if (permisoRecibe != 'R') {
            throw Exception(mPermisos.permisoRecibeIncorrecto);
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
