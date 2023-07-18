import 'dart:convert';
import 'package:aplication_teo/API/api_service.dart';
import 'package:aplication_teo/models/medicionFrecuenciaCardiaca.dart';
import 'package:aplication_teo/models/medicionOximetria.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:http/http.dart' as http;
import '../components/URL.dart';
import '../components/boton_aceptar.dart';

const String apiUrl = myHost.url;
var ID_PACIENTE = '649a1f5c58ac0deb48135625';

class HomePageFrecuencia extends StatefulWidget {
  const HomePageFrecuencia({Key? key}) : super(key: key);

  @override
  _HomePageFrecuenciaState createState() => _HomePageFrecuenciaState();
}

class _HomePageFrecuenciaState extends State<HomePageFrecuencia> {
  late Future<List<MedidaFrecuencia>> mediciones;
  late Future<Widget> listado;
  final url = '$apiUrl/api/frecuenciaC/obtenerMediciones/' + ID_PACIENTE;
  var MES_ELEGIDO = DateTime.now().month;
  final _bpmController = TextEditingController();
  final _comentarioController = TextEditingController();
  double porcentaje = 0.0;
  int valorCentro = 0;
  late Widget l = Container();

  Future<List<MedidaFrecuencia>> getMediciones() async {
    http.Response response = await http.get(Uri.parse(url));
    List<MedidaFrecuencia> listTemp = [];
    final data = json.decode(response.body);
    setState(() {
      data['data'];
    });
    //LLENANDO  LA LISTA
    for (var item in data['data']) {
      // print(item['creadoEn']);
      DateTime fecha = DateTime.parse(item['creadoEn']);
      int mes = fecha.month;
      // print(mes);
      if (mes == MES_ELEGIDO) {
        listTemp.add(MedidaFrecuencia(
            id: item["_id"],
            valor: int.parse((item["valor"]).toString()),
            creadoEn: DateTime.parse(item["creadoEn"]),
            comentario: item["comentario"],
            id_paciente: item["id_paciente"],
            unidad: item["unidad"]));
      }
    }
  
    return listTemp;
  }

  Future<Widget> _list() async {
    List<Widget> itemList = [];
    List<MedidaFrecuencia> lista = await getMediciones();

    lista.forEach((medida) {
      final limaTimeZone = Duration(hours: -5);
      final limaDateTime = medida.creadoEn.add(limaTimeZone);
      final formattedDateTime =
          DateFormat('dd/MM/yyyy').add_Hm().format(limaDateTime);
      Widget item = _item(formattedDateTime.toString(), medida.comentario,
          medida.valor, medida.id);
      itemList.add(item);
   
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
            .valor; // Reemplaza 'campo' por el nombre del campo que deseas obtener
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
          title: Text('Frecuencia Cardiaca'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 238, 55, 101),
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
                          .valor; // Reemplaza 'campo' por el nombre del campo que deseas obtener
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
                        controller: _bpmController,
                        decoration: InputDecoration(
                          labelText: 'Numero de pulsaciones',
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
                        var valorBpm =
                            int.tryParse(_bpmController.text);
                        var comment = _comentarioController.text;
                        var id = ID_PACIENTE;
                        if (valorBpm != null &&
                            valorBpm >= 0 &&
                            valorBpm <= 100) {
                          Navigator.of(context).pop();
                          registrarFrecuencia(
                              id, valorBpm, comment, context);
                        } else {
                          // El valor ingresado no es válido
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Error"),
                                content: const Text(
                                    "El valor ingresado para el numero de pulsaciones no es válido."),
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
                      "PR BPM",
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
                    progressColor: Color.fromARGB(255, 238, 55, 101),
                    backgroundColor: Color.fromARGB(255, 233, 195, 212),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      '$valorCentro',
                      style: TextStyle(fontSize: 50, color: Color.fromARGB(255, 74, 17, 51)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(top: 20.0)),
                  l
                ],
              ),
            )));
  }

  Widget _item(String nombre, String message, int value, String id) {
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
      trailing: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 138, 174, 237).withOpacity(0.6),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "$value Bpm",
              style: TextStyle(
                  color: Color.fromARGB(255, 33, 89, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )),
    );
  }
}
