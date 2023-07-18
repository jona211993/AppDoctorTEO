class Medida {
  final String id;
  final int nivel_glucosa;
  final DateTime creadoEn;
  final String comentario;
  final String unidad;
  final String id_paciente;

  Medida({
    required this.id,
    required this.nivel_glucosa,
    required this.creadoEn,
    required this.comentario,
    required this.id_paciente,
    required this.unidad,
  });

  factory Medida.fromJson(Map<dynamic, dynamic> json, ) {
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

    return Medida(
      id: json['id'].toString(),
      nivel_glucosa: int.parse(json['nivel_glucosa'].toString()),
      creadoEn: adjustedDateTime,
      comentario: json['comentario'],
      id_paciente: json['id_paciente'],
      unidad: json['unidad'],
    );
  }
}
