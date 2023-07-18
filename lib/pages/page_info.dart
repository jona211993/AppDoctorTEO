import 'package:aplication_teo/pages/info_card.dart';
import 'package:aplication_teo/pages/opciones.dart';
import 'package:flutter/material.dart';

class infoPage extends StatelessWidget{
  @override
  Widget build (BuildContext context) =>  Scaffold(
    appBar: AppBar(
      title: Text('Info del paciente'),
      centerTitle: true,
      backgroundColor: Colors.green,      
    ),
    // drawer: SafeArea(
    //     child: Drawer(
    //       backgroundColor: Color(0xFF17203A),
    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 28.0),
    //         child: ListView(
    //           padding: EdgeInsets.zero,
    //           children: [
    //             InfoCard(name: "Teodora De La Cruz López", rol: "Paciente"),
    //             opciones()
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),     
    );
  
}