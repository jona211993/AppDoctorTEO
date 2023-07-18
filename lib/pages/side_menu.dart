import 'package:aplication_teo/pages/info_card.dart';
import 'package:aplication_teo/pages/opciones.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 288,
            height: double.infinity,
            color: Color(0xFF17203A),
            child: SafeArea(
              child: Column(
                children: [
                  InfoCard(name: "Teodora De La Cruz López", rol: "Paciente"),
                  opciones()
                ],
              ),
            )));
  }
}
