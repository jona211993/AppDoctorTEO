import 'dart:convert';
import 'package:aplication_teo/services/local_storage.dart';
import 'package:http/http.dart' as http;
import '../components/graph_widget.dart';
import '../components/URL.dart';


//Defino mi host de mi server en la nube
const String apiUrl = myHost.url;

// ---- PARA los POSTS -----
Future<void> registrarGlucosa(
     int glucose, String comment, context) async {
  final id = LocalStorage.prefs.getString("id") ?? "";
  final response = await http.post(
    Uri.parse('$apiUrl/api/glucosa/registrarMedicion'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id_paciente': id,
      'nivel_glucosa': glucose,
      'comentario': comment,
    }),
  );

  if (response.statusCode == 200) {
    // La petición fue exitosa
    print('Petición exitosa!');
  } else {
    // La petición falló
    print('Petición fallida!');
  }
}

Future<void> registrarTemperatura( double valorTemp, String comment, context) async {
  final id = LocalStorage.prefs.getString("id") ?? "";
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/api/temperatura/registrarMedicion'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_paciente': id,
        'nivel_temperatura': valorTemp,
        'comentario': comment,
      }),
    );
    if (response.statusCode == 200) {
      // La petición fue exitosa
      print('Petición exitosa!');
     
       
    } else {
      // La petición falló
      print('Petición fallida!');
    }
  } catch (error) {
    // Manejo de la excepción
    print('Ocurrió un error: $error');
  }
}

Future<void> registrarOximetria( int valorSaturacion, String comment, context) async {
  final id = LocalStorage.prefs.getString("id") ?? "";
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/api/oximetria/registrarMedicion'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_paciente': id,
        'saturacion': valorSaturacion,
        'comentario': comment,
      }),
    );
    if (response.statusCode == 200) {
      // La petición fue exitosa
      print('Petición exitosa!');
     
       
    } else {
      // La petición falló
      print('Petición fallida!');
    }
  } catch (error) {
    // Manejo de la excepción
    print('Ocurrió un error: $error');
  }
}

Future<void> registrarFrecuencia( int valor, String comment, context) async {
  final id = LocalStorage.prefs.getString("id") ?? "";
  try {
    final response = await http.post(
      Uri.parse('$apiUrl/api/frecienciaC/registrarMedicion'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_paciente': id,
        'valor': valor,
        'comentario': comment,
      }),
    );
    if (response.statusCode == 200) {
      // La petición fue exitosa
      print('Petición exitosa!');
     
       
    } else {
      // La petición falló
      print('Petición fallida!');
    }
  } catch (error) {
    // Manejo de la excepción
    print('Ocurrió un error: $error');
  }
}

// ---- PARA los GETS -----

Future<List<Medida>> obtenerMedidasTemperatura() async {
  final response = await http.get(Uri.parse('$apiUrl/api/temperatura/obtenerMediciones'));
  if (response.statusCode == 200) {
    Iterable data = json.decode(response.body);
    List<Medida> medidas = data.map((m) => Medida.fromJson(m)).toList();
    return medidas;
  } else {
    throw Exception('No se pudo obtener las medidas del servidor');
  }
}

// ---- PARA los Deletes -----
Future<void> deleteMedicionGlucosa(String id_medicion, context) async {
  try {
    final response = await http.delete(
      Uri.parse('$apiUrl/api/glucosa/eliminarMedicion/' + id_medicion),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // La petición fue exitosa
      print('Petición exitosa!');
    } else {
      // La petición falló
      print('Petición fallida!');
    }
  } on Exception catch (e) {
   print("Hubo un fallo al eliminar medicion glucosa");
  }
}
Future<void> deleteMedicionTemperatura(String id_medicion, context) async {
  try {
    final response = await http.delete(
      Uri.parse('$apiUrl/api/temperatura/eliminarMedicion/' + id_medicion),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // La petición fue exitosa
      print('Petición exitosa!');
    } else {
      // La petición falló
      print('Petición fallida!');
    }
  } on Exception catch (e) {
   print("Hubo un fallo al eliminar medicion glucosa");
  }
}


