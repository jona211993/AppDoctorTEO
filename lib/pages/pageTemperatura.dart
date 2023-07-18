import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../API/api_service.dart';
import '../components/boton_aceptar.dart';
import '../models/medicionTemperatura.dart';
import '../components/URL.dart';

const String apiUrl = myHost.url;
var ID_PACIENTE = '649a1f5c58ac0deb48135625';

class HomePageTemperatura extends StatefulWidget {
  const HomePageTemperatura({Key? key}) : super(key: key);

  @override
  _HomePageTemperaturaState createState() => _HomePageTemperaturaState();
}

class _HomePageTemperaturaState extends State<HomePageTemperatura> {
  
  late Future<List<MedidaTemp>> mediciones;
  late Future<Widget> listado;
  final url = '$apiUrl/api/temperatura/obtenerMediciones/' + ID_PACIENTE;
  var MES_ELEGIDO = DateTime.now().month;
  final _temperaturaController = TextEditingController();
  final _comentarioController = TextEditingController();
  double porcentaje = 0.0;
  double valorCentro = 0.0;
  late Widget l = Container();

  Future<List<MedidaTemp>> getMediciones() async {
    http.Response response = await http.get(Uri.parse(url));
    List<MedidaTemp> listTemp = [];
    final data = json.decode(response.body);
    setState(() {
      data['data'];
    });
    //LLENANDO  LA LISTA
    // print(data['data'][0]);
    for (var item in data['data']) {
      // print(item['creadoEn']);
      DateTime fecha = DateTime.parse(item['creadoEn']);
      int mes = fecha.month;
      // print(mes);
      if (mes == MES_ELEGIDO) {
        listTemp.add(MedidaTemp(
            id: item["_id"],
            nivel_temperatura:
                double.parse((item["nivel_temperatura"]).toString()),
            creadoEn: DateTime.parse(item["creadoEn"]),
            comentario: item["comentario"],
            id_paciente: item["id_paciente"],
            unidad: item["unidad"]));
      }
    }
    // print(listTemp[0].nivel_temperatura);
    return listTemp;
  }

  Future<Widget> _list() async {
    List<Widget> itemList = [];
    List<MedidaTemp> lista = await getMediciones();

    lista.forEach((medida) {
      final limaTimeZone = Duration(hours: -5);
      final limaDateTime = medida.creadoEn.add(limaTimeZone);
      final formattedDateTime =
          DateFormat('dd/MM/yyyy').add_Hm().format(limaDateTime);
      Widget item = _item(formattedDateTime.toString(), medida.comentario,
          medida.nivel_temperatura, medida.id);
      itemList.add(item);
      // print(medida.creadoEn);
    });

    return Expanded(
      child: ListView(children: itemList),
    );
  }

  @override
  void initState() {
    super.initState();
    mediciones = getMediciones();
    listado = _list();
    mediciones.then((mediciones) {
      if (mediciones.isNotEmpty) {
        var primerElemento = mediciones[0];
        var valorCampo = primerElemento
            .nivel_temperatura; // Reemplaza 'campo' por el nombre del campo que deseas obtener
        setState(() {
          porcentaje = valorCampo * 0.01; // Actualizar el valor del percent
          valorCentro = valorCampo;
        });
      }
    });

    // Para mostrar las tajetas abajo
    listado.then((listado) {
      setState(() {
        l = listado;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Mediciones de la Temperatura'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 220, 83, 14),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('Enero'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('Febrero'),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text('Marzo'),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text('Abril'),
                ),
                const PopupMenuItem<int>(
                  value: 5,
                  child: Text('Mayo'),
                ),
                const PopupMenuItem<int>(
                  value: 6,
                  child: Text('Junio'),
                ),
                const PopupMenuItem<int>(
                  value: 7,
                  child: Text('Julio'),
                ),
                const PopupMenuItem<int>(
                  value: 8,
                  child: Text('Agosto'),
                ),
                const PopupMenuItem<int>(
                  value: 9,
                  child: Text('Setiembre'),
                ),
                // Agrega más opciones según los meses que desees mostrar
              ],
              onSelected: (int value) {
                // Realiza alguna acción cuando se selecciona una opción
                print('Mes seleccionado: $value');
                setState(() {
                  MES_ELEGIDO = value;
                  // print(MES_ELEGIDO);
                  mediciones =
                      getMediciones(); // Llama a getMediciones() nuevamente
                  // print("nuevas mediciones son:");
                  mediciones.then((mediciones) {
                    // var olo = mediciones[0].nivel_temperatura;
                    // print(olo);
                    if (mediciones.isNotEmpty) {
                      var primerElemento = mediciones[0];
                      var valorCampo = primerElemento
                          .nivel_temperatura; // Reemplaza 'campo' por el nombre del campo que deseas obtener
                      setState(() {
                        porcentaje = valorCampo *
                            0.01; // Actualizar el valor del percent
                        valorCentro = valorCampo;
                      });
                    }
                  });
                });
                listado = _list(); // Actualiza también el listado
                listado.then((listado) {
                  setState(() {
                    l = listado;
                  });
                });
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Nuevo registro'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _temperaturaController,
                        decoration: InputDecoration(
                          labelText: 'Nivel de temperatura',
                        ),
                      ),
                      TextField(
                        controller: _comentarioController,
                        decoration: InputDecoration(
                          labelText: 'Comentario',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Guardar los datos ingresados
                        var temperatura =
                            double.tryParse(_temperaturaController.text);
                        var comment = _comentarioController.text;
                        var id = ID_PACIENTE;
                        if (temperatura != null &&
                            temperatura >= 1 &&
                            temperatura <= 40) {
                          Navigator.of(context).pop();
                          registrarTemperatura(
                              id, temperatura, comment, context);
                        } else {
                          // El valor ingresado no es válido
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text(
                                    "El valor ingresado para el nivel de temperatura no es válido."),
                                actions: <Widget>[
                                  ElevateButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: 'Aceptar',
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                );
              },
            )
          },
          backgroundColor: Colors.blue,
        ),
        body: RefreshIndicator(
            onRefresh: _list,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Temperatura Cº",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  CircularPercentIndicator(
                    animation: true,
                    animationDuration: 2000,
                    radius: 250,
                    lineWidth: 30,
                    percent: porcentaje,
                    progressColor: Colors.orange,
                    backgroundColor: Colors.orange.shade100,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '$valorCentro°C ',
                      style: TextStyle(
                          fontSize: 50, color: Color.fromARGB(255, 100, 51, 7)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  l
                ],
              ),
            )));
  }

  Widget _item(String nombre, String message, double value, String id) {
    return ListTile(
      leading: Icon(
        Icons.pending_actions,
        size: 32,
        color: Color.fromARGB(250, 52, 50, 50),
      ),
      title: Text(
        nombre,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      subtitle: Text(message),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 138, 174, 237).withOpacity(0.6),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$value°C ",
                style: TextStyle(
                  color: Color.fromARGB(255, 33, 89, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmar eliminación'),
                    content: Text(
                        '¿Estás seguro de que quieres eliminar este elemento?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Colors.red, // Establecer el color de fondo verde
                          primary: Colors
                              .white, // Establecer el color del texto en blanco
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Confirmar'),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors
                              .green, // Establecer el color de fondo verde
                          primary: Colors
                              .white, // Establecer el color del texto en blanco
                        ),
                        onPressed: () {
                          print("Recibo con id : " + id);
                          deleteMedicionTemperatura(id, context);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: Colors.red),
          )
        ],
      ),
    );
  }
}
