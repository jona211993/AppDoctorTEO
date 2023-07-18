class MedidaFrecuencia {
  final String id;
  final int valor;
  final DateTime creadoEn;
  final String comentario;
  final String unidad;
  final String id_paciente;

  MedidaFrecuencia({
    required this.id,
    required this.valor,
    required this.creadoEn,
    required this.comentario,
    required this.id_paciente,
    required this.unidad,
  });

  factory MedidaFrecuencia.fromJson(Map<dynamic, dynamic> json, ) {
    final serverDateTime = DateTime.parse(json['creadoEn']);

    // Convertir la fecha y hora del servidor a la zona horaria local
    final localDateTime = serverDateTime.toLocal();

    // Crear un objeto DateTime ajustado a la zona horaria local
    final adjustedDateTime = DateTime(
      localDateTime.year,
      localDateTime.month,
      localDateTime.day,
      localDateTime.hour,
      localDateTime.minute,
      localDateTime.second,
    );

    return MedidaFrecuencia(
      id: json['id'].toString(),
      valor: int.parse(json['valor'].toString()),
      creadoEn: adjustedDateTime,
      comentario: json['comentario'],
      id_paciente: json['id_paciente'],
      unidad: json['unidad'],
    );
  }
}
