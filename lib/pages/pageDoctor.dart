
import 'package:flutter/material.dart';

class infoDoctor extends StatelessWidget{
  @override
  Widget build (BuildContext context) =>  Scaffold(
    appBar: AppBar(
      title: Text('Doctor de Cabecera'),
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 59, 11, 101),      
    ) ,
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