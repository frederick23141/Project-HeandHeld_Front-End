class Usuario {
  final String? nombres;
  final int? nit;

  Usuario({this.nombres, this.nit});


  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombres: json['nombres'] as String?,
      nit: json['nit']as int?,
    );
  }

  // Convertir instancia de Usuario a JSON para la correcta lectura del Back
  Map<String, dynamic> toJson() {
    return {
      'nombres': nombres,
      'nit': nit,
    };
  }
}
