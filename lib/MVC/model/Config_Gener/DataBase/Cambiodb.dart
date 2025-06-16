class Cambiodb {
  final int? referencia;

  Cambiodb({this.referencia});

  factory Cambiodb.fromJson(Map<String, dynamic> json) {
    return Cambiodb(

      referencia: json['referencia'] != null ? int.tryParse(json['referencia'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'referencia': referencia ?? 1,
    };
  }
}
