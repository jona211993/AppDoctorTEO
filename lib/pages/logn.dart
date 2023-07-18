import 'package:aplication_teo/pages/navBar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Widget createEmailInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        decoration: InputDecoration(hintText: "Usuario o Correo electrónico"),
      ),
    );
  }

  Widget createPassword() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        decoration: InputDecoration(hintText: "Contraseña"),
        obscureText: true,
      ),
    );
  }

  Widget createLoginButton(context) {
    return Container(
        padding: const EdgeInsets.only(top: 42),
        child: Center(          
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NavBar()
        )
        ),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            ),          
        )
        );
  }

 Widget createTitle(){
    return Container(
      child: Center(
        child: Text(
          "Doctor - TEO",
           style: TextStyle(
              color: Color.fromARGB(255, 9, 42, 90),
              fontSize: 32,
            fontWeight: FontWeight.bold
            ),
           ),
          )
        );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView(children: [
        Image.asset(
          'assets/images/doctor2.png',
          width: double.infinity,
          height: 400,
        ),
        createTitle(),
        createEmailInput(),
        createPassword(),
        createLoginButton(context),
      ]),
    ));
  }
}
