class ObtenerPedidoGalvanizado {
  final int? numero;
  final int? idDetalle;
  final DateTime? fecha;
  final String? codigo;
  final int? pendiente;
  final String? descripcion;

  ObtenerPedidoGalvanizado({
    this.numero,
    this.idDetalle,
    this.fecha,
    this.codigo,
    this.pendiente,
    this.descripcion,
  });

  factory ObtenerPedidoGalvanizado.fromJson(Map<String, dynamic> json) {
    return ObtenerPedidoGalvanizado(
      numero: json['numero'] as int?,
      idDetalle: json['id_detalle'] as int?,
      fecha: json['fecha'] != null ? DateTime.tryParse(json['fecha']) : null,
      codigo: json['codigo'] as String?,
      pendiente: json['pendiente'] as int?,
      descripcion: json['descripcion'] as String?,
    );
  }
}