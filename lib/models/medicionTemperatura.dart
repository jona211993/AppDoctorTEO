class MedidaTemp {
  final String id;
  final double nivel_temperatura;
  final DateTime creadoEn;
  final String comentario;
  final String unidad;
  final String id_paciente;

  MedidaTemp({
    required this.id,
    required this.nivel_temperatura,
    required this.creadoEn,
    required this.comentario,
    required this.id_paciente,
    required this.unidad,
  });

  factory MedidaTemp.fromJson(Map<dynamic, dynamic> json, ) {
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

    return MedidaTemp(
      id: json['id'].toString(),
      nivel_temperatura: double.parse(json['nivel_temperatura'].toString()),
      creadoEn: adjustedDateTime,
      comentario: json['comentario'],
      id_paciente: json['id_paciente'],
      unidad: json['unidad'],
    );
  }
}
