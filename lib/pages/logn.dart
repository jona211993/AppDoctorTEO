import 'package:aplication_teo/API/auth_service.dart';
import 'package:aplication_teo/pages/navBar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget createEmailInput(Function onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: TextFormField(
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(hintText: "Correo electrónico"),
      ),
    );
  }

  Widget createPassword(Function onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(hintText: "Contraseña"),
        obscureText: true,
      ),
    );
  }

  Widget createLoginButton(context, String email, String password) {
    return Container(
        padding: const EdgeInsets.only(top: 42),
        child: Center(          
            child: GestureDetector(
              onTap: () async {
                final isLogin = AuthService().loginService(email, password);
                if ( isLogin == true) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavBar()));
                }else{
                  //Agregar Alert o PopUp para mostrar error de autenticacion
                  print("Error credenciales incorrectas ");
                }
              },
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
    String email = "";
    String password = "";
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
        createEmailInput((value) => email = value),
        createPassword((value) => password = value),
        Container(
        padding: const EdgeInsets.only(top: 42),
        child: Center(          
            child: GestureDetector(
              onTap: () async {
                final isLogin = await AuthService().loginService(email, password);
                print(isLogin);
                if ( isLogin == true) {
                  print("Login correcto");
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavBar()));
                }else{
                  //Agregar Alert o PopUp para mostrar error de autenticacion
                  print("Error credenciales incorrectas ");
                }
              },
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
        )
      ]),
    ));
  }
}
