import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key, required this.name, required this.rol,
  });

  final String name, rol;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ImageIcon(
          AssetImage("assets/iconos/user3.png"),
          color: Colors.white,
        ),
        radius: 30,
      ),
      title: Center(
        child: Text(name,
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      subtitle: Text(rol,
          style: TextStyle(
            color: Color.fromARGB(255, 110, 219, 114),
            fontSize: 14,
          )),
    );
  }
}