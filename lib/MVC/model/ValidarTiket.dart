class ValidarTiket {
  final String? nit_proveedor;
  final num? num_importacion;
  final int? id_solicitud_det;
  final int? numero_rollo;
  final num? peso;
  final String? codigo;
  final String? descripcion;
  final String? movimiento;

  ValidarTiket({
    this.nit_proveedor,
    this.num_importacion,
    this.id_solicitud_det,
    this.numero_rollo,
    this.peso,
    this.codigo,
    this.descripcion,
    this.movimiento,
  });

  factory ValidarTiket.fromJson(Map<String, dynamic> json) {
    return ValidarTiket(
      nit_proveedor: json['nit_proveedor'] as String?,
      num_importacion: json['num_importacion'] as num?,
      id_solicitud_det: json['id_solicitud_det'] as int?,
      numero_rollo: json['numero_rollo'] as int?,
      peso: json['peso'] as num?,
      codigo: json['codigo'] as String?,
      descripcion: json['descripcion'] as String?,
      movimiento: json['movimientos'] as String?
    );
  }
}
