class Permisostraslado {
  final int? nit;
  final String? permiso;
  final String? modulo;

  Permisostraslado({
    this.nit,
    this.permiso,
    this.modulo});

  factory Permisostraslado.fromJson(Map<String, dynamic> json) {
    return Permisostraslado(
      nit: json['nit'] as int,
      permiso: json['permiso'] as String,
      modulo: json['modulo'] as String
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'nit': nit,
      'permiso': permiso,
      'modulo': modulo
    };
  }
  
}
