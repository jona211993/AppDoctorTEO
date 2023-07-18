import 'package:aplication_teo/components/gridOpciones.dart';
import 'package:aplication_teo/pages/info_card.dart';
import 'package:aplication_teo/pages/opciones.dart';

import 'package:flutter/material.dart';

import '../services/local_storage.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nombre = LocalStorage.prefs.getString("nombre");
    final apellidoPaterno = LocalStorage.prefs.getString("apellidoPaterno");
    final apellidoMaterno = LocalStorage.prefs.getString("apellidoMaterno");
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: const Text('Doctor TEO',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        ),
        backgroundColor:Color.fromARGB(255, 42, 65, 135),
        titleTextStyle: TextStyle(fontSize: 24),
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Color(0xFF17203A),
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                InfoCard(name: "$nombre $apellidoPaterno $apellidoMaterno", rol: "Paciente"),
                opciones()
              ],
            ),
          ),
        ),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              cabecera_welcome(nombre ?? "", apellidoPaterno ?? ""),
              cabeceraSaludo(),
              Expanded(child: gridOpciones()),
              // SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.75,
              //     child: gridOpciones()),
            ],
          )),
    );
  }

  Padding cabeceraSaludo() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      child: Text("Estoy al tanto de tus parámetros fisiológicos",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Padding cabecera_welcome(String nombre, String apellidoPaterno ) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Text(
        "Bienvenido(a) $nombre $apellidoPaterno",
        style: TextStyle(
            fontSize: 28,
            color: Color.fromARGB(255, 11, 6, 156),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
