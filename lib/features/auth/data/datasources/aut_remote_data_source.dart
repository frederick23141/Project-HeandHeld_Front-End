import 'dart:convert';
import 'package:handheld_beta/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:handheld_beta/core/config/Conexion.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> verifyUser(int nit);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> verifyUser(int nit) async {
    final url = Uri.parse('${Conexion.apiUrl}/User');
    final referencia = 1; // Puedes traerla desde CambiodbController si quieres
    final response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nit": nit.toString(), "referencia": referencia}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return UserModel.fromJson(jsonData);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
