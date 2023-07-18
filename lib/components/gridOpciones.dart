import 'package:aplication_teo/components/MedicionesGrafica.dart';
import 'package:aplication_teo/components/graficaPA.dart';
import 'package:aplication_teo/pages/navBar.dart';
import 'package:aplication_teo/pages/pageGlucosa.dart';
import 'package:aplication_teo/pages/pageTemperatura.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ionicons/ionicons.dart';

import '../pages/insulina.dart';
import '../pages/pageFrecuenciaCardiaca.dart';
import '../pages/pageOximetria.dart';
import '../pages/pagePeso.dart';

class gridOpciones extends StatelessWidget {
  const gridOpciones({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        padding: const EdgeInsets.all(25),
        children: <Widget>[
          CardGlucosa(context),
          CardPresion(context),
          CardTemperatura(context),
          CardOximetro(context),
          CardPeso(context),
          CardPulsoCardiaco(context),
          CardInsulina(context),
          CardNutricion()
        ]);
  }

  Card CardGlucosa(BuildContext context) {
    return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 0),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.85, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_glucometro.jpg'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Glucosa",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  Card CardPresion(BuildContext context) {
    return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 15,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
    ),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 4),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.85, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_tensiometro.png'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Presion Arterial",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  Card CardTemperatura(BuildContext context) {
     return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 15,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
    ),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 2),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.85, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_termometro.png'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Temperatura",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  Card CardOximetro(BuildContext context) {
    return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 15,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
    ),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 1),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.85, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_oximetro.jpg'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Oximetría",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  Card CardPeso(BuildContext context) {
    return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 15,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
    ),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 3),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.85, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_balanza2.jpg'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Peso",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

  Card CardPulsoCardiaco(BuildContext context) {
     return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 15,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),
    ),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 6),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.85, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_pulsoC.png'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Pulso Cardiaco",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }

Card CardInsulina(BuildContext context) {
  return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () => selectedItem(context, 7),
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.8, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imgen_insulina.jpg'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Insulina",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Card CardNutricion() {
  return Card(
    color: Color.fromARGB(255, 244, 241, 242),
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    margin: const EdgeInsets.all(8),
    child: InkWell(
      onTap: () {},
      splashColor: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: FractionallySizedBox(
              heightFactor: 0.8, // Ajusta el tamaño de la imagen en relación con el card
              child: Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage('assets/images/imagen_nutricion.jpg'), // Ruta de la imagen de fondo
                    fit: BoxFit.cover, // Ajuste de la imagen de fondo
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,                
                children: [
                  Text(
                    "Nutrición",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LineChartSample2()));

        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePageOximetria()));
        break;

      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePageTemperatura(),
        ));

        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePagePeso(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PresionArterialChart(
                  sistoleData: [100,110,90,100,95,105,105], // Ejemplo de datos de presión arterial sistólica
                  diastoleData: [70, 75, 79, 75, 72, 78, 75],
                ) // Ejemplo de datos de presión arterial diastólica),
            ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => metricasGlucosa(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePageFrecuencia(),
        ));
        break;
       case 7:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => HomePageFrecuencia(),
        ));
        break;
    }
  }
}
