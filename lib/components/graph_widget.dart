import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_common/common.dart' as charts2;


class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Medida> medidasPorMes=[];
  @override
  void initState() {
    super.initState();
    cargarMedidas();
  }

  Future <void> cargarMedidas() async {
  List<Medida> medidas = await obtenerMedidasPorMes();
  setState(() {
    medidasPorMes = medidas;
  });
   print("ahora medidaPorMes va asi: ");
    print(medidasPorMes);
     print("================================================");
}


  List<Color> gradientColors = [
    Color.fromARGB(255, 228, 67, 67),
    Color.fromARGB(255, 123, 2, 40),
    
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(1),
                  ),
                  color: Color.fromARGB(255, 251, 252, 253)),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: FutureBuilder<List<Medida>>(
                  future:obtenerMedidas(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<Medida> medidas = snapshot.data!;
                      return LineChart(mainData());}
                      else {return Center(child: CircularProgressIndicator());
                          }
                  } 
                )
              ),
            ),
          ),
        ),
      ],
    );
     //return MedicionesGrafica(medidasPorMes);

 
  }

    Widget bottomTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Color.fromARGB(255, 25, 53, 113),
        fontWeight: FontWeight.bold,
        fontSize: 10,
      );
      Widget text;
      switch (value.toInt()) {
        case 1:
          text = Center(child: const Text('1', style: style));
          break;
        case 2:
          text = Center(child: const Text('2', style: style));
          break;
        case 3:
          text = Center(child: const Text('3', style: style));
          break;
        case 4:
          text = Center(child: const Text('4', style: style));
          break;
        case 5:
          text =Center(child: const Text('5', style: style));
          break;
        case 6:
          text = Center(child: const Text('6', style: style));
          break;
        case 7:
          text = Center(child: const Text('7', style: style));
          break;
          case 8:
          text = Center(child: const Text('8', style: style));
          break;
        case 9:
          text = Center(child: const Text('9', style: style));
          break;
        case 10:
          text = Center(child: const Text('10',textAlign: TextAlign.center, style: style));
          break;
        case 11:
          text = Center(child: const Text('11', style: style));
          break;
        case 12:
          text = Center(child: const Text('12', style: style));
          break;
        case 13:
          text = Center(child: const Text('13', style: style));
          break;
        case 14:
          text = Center(child: const Text('14', style: style));
          break;
        case 15:
          text = Center(child: const Text('15', style: style));
          break;
        case 16:
          text = Center(child: const Text('16', style: style));
          break;
        case 17:
          text =Center(child: const Text('17', style: style));
          break;
        case 18:
          text = Center(child: const Text('18', style: style));
          break;
        case 19:
          text = Center(child: const Text('19', style: style));
          break;
        case 20:
          text = Center(child: const Text('20', style: style));
          break;
        case 21:
          text =Center(child: const Text('21', style: style));
          break;
        case 22:
          text =Center(child: const Text('22', style: style));
          break;
        case 23:
          text = Center(child: const Text('23', style: style));
          break;
        case 24:
          text = Center(child: const Text('24', style: style));
          break;
        case 25:
          text =Center(child: const Text('25', style: style));
          break;
        case 26:
          text =Center(child: const Text('26', style: style));
           break;
        case 27:
          text = Center(child: const Text('27', style: style));
          break;
        case 28:
          text = Center(child: const Text('28', style: style));
          break;
        case 29:
          text =Center(child: const Text('29', style: style));
           break;
        case 30:
          text = Center(child: const Text('30', style: style));
          break;
        default:
          text = const Text(' ', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: text,
      );
    }

    Widget leftTitleWidgets(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Color.fromARGB(255, 25, 53, 113),
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
      String text;
      switch (value.toInt()) {
        case 0:
          text = '0';
          break;
        case 20:
          text = '20';
          break;
        case 40:
          text = '40';
          break;
        case 60:
          text = '60';
          break;
        case 80:
          text = '80';
          break;
        case 100:
          text = '100';
          break;
        case 120:
          text = '120';
          break;
        case 140:
          text = '140';
          break;
        case 160:
          text = '160';
          break;
        case 180:
          text = '180';
          break;
        case 200:
          text = '200';
          break;
        
        
        default:
          return Container();
      }

      return Text(text, style: style, textAlign: TextAlign.left);
    }

    LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 5, 126, 39),
            strokeWidth: 0.5,
          );
        },
        // getDrawingVerticalLine: (value) {
        //   return FlLine(
        //     color: const Color(0xff37434d),
        //     strokeWidth: 1,
        //   );
        // },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 200,
      lineBarsData: [
        LineChartBarData(
          spots:medidasPorMes
           .map((m) => FlSpot(
                  m.createdAt.day.toDouble(),
                  m.nivel_glucosa.toDouble(),
                ))
            .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 6,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}

class Medida {
  final String id;
  final int nivel_glucosa;
  final DateTime createdAt;
  final String comentario;
  final String dni_paciente;

  Medida({
    required this.id,
    required this.nivel_glucosa,
    required this.createdAt,
    required this.comentario,
    required this.dni_paciente,
  });

  factory Medida.fromJson(Map<dynamic, dynamic> json) {
    return Medida(
      id: json['id'],
      nivel_glucosa: json['nivel_glucosa'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] * 1000),
      comentario: json['comentario'],
      dni_paciente: json['dni_paciente'],
    );
  }
  }
  

Future<List<Medida>> obtenerMedidas() async {
  final response = await http.get(Uri.parse('https://626hfryc53.execute-api.us-east-1.amazonaws.com/get/medicionesGlucosa'));
   if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    print("Esto viene de data");
    print(data);
     print("------------------------------");
    List<Medida> nueva_medidas = (data['body'] as List).map((m) => Medida.fromJson(m)).toList();
       for (var medida in nueva_medidas) {
  print('id: ${medida.id}');
  print('nivel_glucosa: ${medida.nivel_glucosa}');
  print('createdAt: ${medida.createdAt}');
  print('createdAt: ${medida.createdAt.month}');
  print('comentario: ${medida.comentario}');
  print('dni_paciente: ${medida.dni_paciente}');
}
    return nueva_medidas;
  } else {
    throw Exception('Fallo la carga de medidas desde la API');
  }
}

Future<List<Medida>> obtenerMedidasPorMes() async  {
 List<Medida>medidastodas = await obtenerMedidas() ;  
 List<Medida> medidasPorMes = medidastodas.where((m) => m.createdAt.month == 5).toList();
// final medidasporSemana = medidas.where((m) => DateFormat('W').format(m.date)== '18').toList();
print("Medidas por Mes");
  print(medidasPorMes);
  for (var medida in medidasPorMes) {
  print('id: ${medida.id}');
  print('nivel_glucosa: ${medida.nivel_glucosa}');
  print('createdAt: ${medida.createdAt}');
  print('createdAt: ${medida.createdAt.month}');
  print('comentario: ${medida.comentario}');
  print('dni_paciente: ${medida.dni_paciente}');
}
return medidasPorMes;
}
// PROBANDO NO USADOclass MedicionesGrafica extends StatelessWidget {
//   final List<Medida> mediciones;

//   MedicionesGrafica(this.mediciones);

//   @override
//   Widget build(BuildContext context) {
//     return charts.ScatterPlotChart(
//       <charts.Series<Medida, DateTime>>[
//         new charts.Series<Medida, DateTime>(
//           id: 'mediciones',
//           colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//           domainFn: (Medida medicion, _) => medicion.createdAt,
//           measureFn: (Medida medicion, _) => medicion.nivel_glucosa,
//           data: mediciones,
//         ),
//       ].cast<charts.Series<dynamic, num>>(),
//       animate: true,
      
//     );
//   }
// }