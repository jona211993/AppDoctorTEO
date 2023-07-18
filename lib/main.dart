import 'package:aplication_teo/pages/logn.dart';
import 'package:aplication_teo/pages/navBar.dart';
import 'package:aplication_teo/pages/pageHomeGlucosa.dart';
import 'package:aplication_teo/pages/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:aplication_teo/constant.dart';

import 'components/MedicionesGrafica.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doctor TEO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: mBackgroundColor ,
        visualDensity: VisualDensity.adaptivePlatformDensity                
      ),
      // home: NavBar(),
      home:LoginPage(),
    );
  }
}

