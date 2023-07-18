import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../API/api_service.dart';
import '../models/medicion.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import '../components/URL.dart';

import 'boton_aceptar.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _MedicionesGrafica createState() => _MedicionesGrafica();
}

class _MedicionesGrafica extends State<LineChartSample2> {
  List<Medida> medidasPorMes = [];
  final _glucoseController = TextEditingController();
  final _commentController = TextEditingController();
  var URL=myHost.url;
  var ID_PACIENTE='649a1f5c58ac0deb48135625';
  List<String> months = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];
  String selectedMonth = 'Julio';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    refrescarPaginaGlucosa();
  }

  Future refrescarPaginaGlucosa() async {
    Uri uri = Uri.parse(URL+'/api/glucosa/obtenerMediciones/'+ID_PACIENTE);
    final response = await http.get(uri);
    Map<String, dynamic> jsonRespuesta = json.decode(response.body);
    List<dynamic> body = jsonRespuesta['data'];
    
    this.medidasPorMes = body.map((item) {
      return Medida(
        id: item['_id'],
        comentario: item['comentario'],
        creadoEn: (DateTime.parse(item['creadoEn'])),
        id_paciente: item['id_paciente'],
        nivel_glucosa: int.parse(item['nivel_glucosa'].toString()),
        unidad: item['unidad'],
      );
    }).toList();
    print(medidasPorMes[0].id_paciente);
    print(medidasPorMes[0].id);
    print(medidasPorMes.length);
    print(medidasPorMes[0].creadoEn);

    setState(() {
      this.medidasPorMes = medidasPorMes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double halfHeight = MediaQuery.of(context).size.height / 2;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Seleccione el Mes a ver '),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 191, 22, 10),
        actions: <Widget>[
          Container(
            color: Color.fromARGB(255, 53, 51, 51),
            child: DropdownButton(
              padding: const EdgeInsets.only(left: 20),
              underline: SizedBox(),
              value: selectedMonth,
              iconEnabledColor: Color.fromARGB(255, 23, 22, 22),
              dropdownColor: Color.fromARGB(255, 22, 83, 134),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              items: months.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value, selectionColor: Colors.white),
                );
              }).toList(),
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    selectedMonth = value;
                  });
                }
                else{

                }
              },
            ),
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
                title: Text('Ingresar datos'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _glucoseController,
                      decoration: InputDecoration(
                        labelText: 'Nivel de glucosa',
                      ),
                    ),
                    TextField(
                      controller: _commentController,
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
                    child: Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Guardar los datos ingresados
                      var glucose = int.tryParse(_glucoseController.text);
                      var comment = _commentController.text;
                      var id = ID_PACIENTE;
                      if (glucose != null && glucose >= 1 && glucose <= 500) {
                        Navigator.of(context).pop();
                        registrarGlucosa(id, glucose, comment, context);
                      } else {
                        // El valor ingresado no es válido
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "El valor ingresado para el nivel de glucosa no es válido."),
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
                    child: Text('Guardar'),
                  ),
                ],
              );
            },
          )
        },
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: refrescarPaginaGlucosa,
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Glucómetro",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Text(
                  "Todas las Mediciones",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            Container(
              width: screenWidth,
              child: SizedBox(
                height: halfHeight,
                child: charts.TimeSeriesChart(
                  _createSeriesData(),
                  animate: true,                  
                  dateTimeFactory: const charts.LocalDateTimeFactory(),
                  defaultRenderer: charts.LineRendererConfig(
                    includeArea: true,
                    includePoints: true,
                    roundEndCaps: true, // Rounding the end caps of the line
                    strokeWidthPx: 4, // Setting the stroke width of the line
                    // Interpolating the data to achieve a curve in the line
                  ),
                ),
              ),
            ),
            _list()
          ],
        ),
      ),
    );
  }

  List<charts.Series<Medida, DateTime>> _createSeriesData() {
    return [
      new charts.Series<Medida, DateTime>(
        id: 'mediciones',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Medida medicion, _) => medicion.creadoEn,
        measureFn: (Medida medicion, _) => medicion.nivel_glucosa,
        data: medidasPorMes,
        strokeWidthPxFn: (_, __) => 4,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.red),
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Colors.red.withOpacity(0.3)),
        displayName: "mediciones",
        
      ),
    ];
  }
 
  Widget _item(String fecha, String message, int value, String id) {
    return ListTile(
      leading: Icon(
        Icons.pending_actions,
        size: 32,
        color: Color.fromARGB(250, 52, 50, 50),
      ),
      title: Text(
        fecha,
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
                "$value mg/h",
                style: TextStyle(
                  color: Color.fromARGB(255, 33, 89, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
           SizedBox(
              width: 8), 
           IconButton(
            onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmar eliminación'),
                content: Text('¿Estás seguro de que quieres eliminar este elemento?'),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancelar'),
                     style: TextButton.styleFrom(
                      backgroundColor: Colors.red, // Establecer el color de fondo verde
                      primary: Colors.white, // Establecer el color del texto en blanco
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Confirmar'),
                     style: TextButton.styleFrom(
                      backgroundColor: Colors.green, // Establecer el color de fondo verde
                      primary: Colors.white, // Establecer el color del texto en blanco
                    ),
                    onPressed: () {
                      print("Recibo con id : "+ id);
                      deleteMedicionGlucosa(id, context);                    
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
            icon: Icon(Icons.delete,color: Colors.red),           
            
            )
         
        ],
      ),
    );
  }

  Widget _list() {
    List<Widget> itemList = [];
    List<Medida> medicionesDesdeLaMasReciente = this.medidasPorMes.toList();
    initializeDateFormatting();
    //print(medicionesDesdeLaMasReciente);
    medicionesDesdeLaMasReciente.forEach((medida) {
      final limaTimeZone = Duration(hours: -5);
      final limaDateTime = medida.creadoEn.add(limaTimeZone);
      final formattedDateTime =
          DateFormat('dd/MM/yyyy').add_Hm().format(limaDateTime);
      Widget item = _item(
        formattedDateTime.toString(),
        medida.comentario,
        medida.nivel_glucosa,
        medida.id
      );
      itemList.add(item);
      print(medida.creadoEn);
    });
    return Expanded(
      child: ListView(children: itemList),
    );
  }





}

