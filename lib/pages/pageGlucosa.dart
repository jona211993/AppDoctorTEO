import 'package:aplication_teo/pages/pageHomeGlucosa.dart';
import 'package:flutter/material.dart';


class metricasGlucosa extends StatelessWidget{
  @override
  Widget build (BuildContext context) =>  
  Scaffold(
      appBar: AppBar(
                  automaticallyImplyLeading: true,
                  title: Text('Mediciones de la Glucosa'),
                  centerTitle: true,
                  backgroundColor: Color.fromARGB(255, 191, 22, 10),      
                ) ,
      body: Container(
        child: HomePage(),
      ),

      
   
  );
  
}