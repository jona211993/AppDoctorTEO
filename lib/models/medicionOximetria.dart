class MedidaOximetria {
  final String id;
  final int saturacion;
  final DateTime creadoEn;
  final String comentario;
  final String unidad;
  final String id_paciente;

  MedidaOximetria({
    required this.id,
    required this.saturacion,
    required this.creadoEn,
    required this.comentario,
    required this.id_paciente,
    required this.unidad,
  });

  factory MedidaOximetria.fromJson(Map<dynamic, dynamic> json, ) {
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

    return MedidaOximetria(
      id: json['id'].toString(),
      saturacion: int.parse(json['saturacion'].toString()),
      creadoEn: adjustedDateTime,
      comentario: json['comentario'],
      id_paciente: json['id_paciente'],
      unidad: json['unidad'],
    );
  }
}
