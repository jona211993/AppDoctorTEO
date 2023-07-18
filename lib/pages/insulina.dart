// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import '../components/URL.dart';
// import 'package:http/http.dart' as http;

// class InsulinAdminPage extends StatefulWidget {
//   const InsulinAdminPage({Key? key}) : super(key: key);

//   @override
//   _InsulinAdminPageState createState() => _InsulinAdminPageState();
// }

// class _InsulinAdminPageState extends State<InsulinAdminPage> {
//   var URL=myHost.url;
//   var ID_PACIENTE='649a1f5c58ac0deb48135625';
//   final List<Map<String, dynamic>> insulinAdmins = [
//     // {'fecha': DateTime(2023, 7, 15), 'cantidad': 20, 'tipo': 'rápida'},
//     // {'fecha': DateTime(2023, 7, 16), 'cantidad': 30, 'tipo': 'rápida'},
//     // {'fecha': DateTime(2023, 7, 18), 'cantidad': 25, 'tipo': 'rápida'},
//     // {'fecha': DateTime(2023, 8, 5), 'cantidad': 22, 'tipo': 'lenta'},
//     // {'fecha': DateTime(2023, 8, 10), 'cantidad': 28, 'tipo': 'rápida'},
//     // // Add more insulin administrations here
//   ];
//   Future refrescarPaginaGlucosa() async {
//     Uri uri = Uri.parse(URL+'/api/insulina/obtenerMediciones/'+ID_PACIENTE);
//     final response = await http.get(uri);
//     Map<String, dynamic> jsonRespuesta = json.decode(response.body);
//     List<dynamic> body = jsonRespuesta['data'];
    
//     medidas = body.map((item) {
//       return Medida(
//         id: item['_id'],
//         comentario: item['comentario'],
//         creadoEn: (DateTime.parse(item['creadoEn'])),
//         id_paciente: item['id_paciente'],
//         nivel_glucosa: int.parse(item['niclavel_glucosa'].toString()),
//         unidad: item['unidad'],
//       );
//     }).toList();
//     print(medidasPorMes[0].id_paciente);
//     print(medidasPorMes[0].id);
//     print(medidasPorMes.length);
//     print(medidasPorMes[0].creadoEn);

//     setState(() {
//       this.medidas = medidasPorMes;
//     });
//   }
//   int _selectedMonth = DateTime.now().month;

//   List<Map<String, dynamic>> getInsulinAdminsByMonth(int month) {
//     return insulinAdmins.where((admin) => admin['fecha'].month == month).toList();
//   }

//   List<charts.Series<Map<String, dynamic>, String>> _createBarChartData() {
//     final adminsByMonth = getInsulinAdminsByMonth(_selectedMonth);

//     return [
//       charts.Series<Map<String, dynamic>, String>(
//         id: 'Insulin Admins',
//         data: adminsByMonth,
//         domainFn: (data, _) => DateFormat('d').format(data['fecha']),
//         measureFn: (data, _) => data['cantidad'],
//         labelAccessorFn: (data, _) => '${data['cantidad']}',
//         colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//       ),
//     ];
//   }

//   Widget _buildBarChart() {
//     final barChartData = _createBarChartData();

//     return Container(
//       padding: EdgeInsets.all(16),
//       height: 300,
//       child: barChartData.isNotEmpty
//           ? charts.BarChart(
//               barChartData,
//               animate: true,
//               barRendererDecorator: charts.BarLabelDecorator<String>(),
//               domainAxis: charts.OrdinalAxisSpec(
//                 renderSpec: charts.SmallTickRendererSpec(
//                   labelRotation: 45,
//                   labelStyle: charts.TextStyleSpec(fontSize: 10),
//                 ),
//               ),
//             )
//           : Center(
//               child: Text('No hay administraciones de insulina en este mes'),
//             ),
//     );
//   }

//   Widget _buildMedicionesList() {
//     final adminsByMonth = getInsulinAdminsByMonth(_selectedMonth);

//     return Expanded(
//       child: ListView.builder(
//         itemCount: adminsByMonth.length,
//         itemBuilder: (context, index) {
//           final admin = adminsByMonth[index];
//           return ListTile(
//             title: Text('Fecha: ${DateFormat('dd/MM/yyyy').format(admin['fecha'])}'),
//             subtitle: Text('Cantidad: ${admin['cantidad']} - Tipo: ${admin['tipo']}'),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Administración de Insulina'),
//         actions: [
//           PopupMenuButton<int>(
//             itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
//               const PopupMenuItem<int>(
//                 value: 1,
//                 child: Text('Enero'),
//               ),
//               const PopupMenuItem<int>(
//                 value: 2,
//                 child: Text('Febrero'),
//               ),
//               const PopupMenuItem<int>(
//                 value: 3,
//                 child: Text('Marzo'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 4,
//                 child: Text('Abril'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 5,
//                 child: Text('Mayo'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 6,
//                 child: Text('Junio'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 7,
//                 child: Text('Julio'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 8,
//                 child: Text('Agosto'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 9,
//                 child: Text('Setiembre'),
//               ),
//                const PopupMenuItem<int>(
//                 value: 10,
//                 child: Text('Octubre'),
//               ),
//               // Agregar más opciones según los meses que desees mostrar
//             ],
//             onSelected: (int value) {
//               setState(() {
//                 _selectedMonth = value;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
        
//         children: [
//           const Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Insulina",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//           _buildBarChart(),
//           const Divider(),
//           _buildMedicionesList(),
//         ],
//       ),
//     );
//   }
// }
