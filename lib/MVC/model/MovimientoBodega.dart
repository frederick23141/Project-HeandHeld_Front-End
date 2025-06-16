class MovimientoBodega {
  final int? referencia;
  final String? tiket;
  final int? bodega;
  final int? nitEntrega;
  final int? nitRecibe;
  final DateTime? fecha;

  MovimientoBodega({
    this.referencia,
    this.tiket,
    this.bodega,
    this.nitEntrega,
    this.nitRecibe,
    this.fecha,
  });

  // Factoria para construir la instancia a partir del JSON
  factory MovimientoBodega.fromJson(Map<String, dynamic> json) {
    return MovimientoBodega(
      referencia: json['referencia'] as int?,
      tiket: json['Tiket'] as String?,
      bodega: json['bodega'] as int?,
      nitEntrega: json['nitEntrega'] as int?,
      nitRecibe: json['nitRecibe'] as int?,
      fecha: json['fecha'] != null ? DateTime.tryParse(json['fecha']) : null,
    );
  }

  // Método para establecer los valores mientras se ejecuta el procedimiento
  static Future<void> setMovimientoBodegaValues(
      String tiket, int nitEntrega, int nitRecibe, int bodega) async {
    // Guardamos los valores temporalmente en una clase Singleton
    var state = MovimientoBodegaState();
    state.nitEntrega = nitEntrega;
    state.nitRecibe = nitRecibe;
    state.tiket = tiket;
    state.bodega = bodega;
  }

  // Método para limpiar los valores después de la ejecución
  static void clearMovimientoBodegaValues() {
    var state = MovimientoBodegaState();
    state.clear();
  }
}

class MovimientoBodegaState {
  // Instancia Singleton para almacenar los valores
  static final MovimientoBodegaState _singleton =
      MovimientoBodegaState._internal();

  factory MovimientoBodegaState() {
    return _singleton;
  }

  MovimientoBodegaState._internal();

  // Variables para almacenar los valores
  String? tiket;
  int? nitEntrega;
  int? nitRecibe;
  int? bodega;

  // Método para limpiar los valores después de la operación
  void clear() {
    tiket = null;
    nitEntrega = null;
    nitRecibe = null;
    bodega = null;
  }
}
