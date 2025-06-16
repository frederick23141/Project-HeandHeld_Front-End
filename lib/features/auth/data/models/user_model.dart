import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required int nit, required String nombre})
      : super(nit: nit, nombre: nombre);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nit: json['nit'] ?? 0,
      nombre: json['nombres'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nit': nit,
      'nombres': nombre,
    };
  }
}
