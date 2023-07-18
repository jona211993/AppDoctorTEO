import 'package:aplication_teo/API/auth_service.dart';
import 'package:aplication_teo/pages/logn.dart';
import 'package:aplication_teo/pages/navBar.dart';
import 'package:aplication_teo/pages/page.config.dart';
import 'package:aplication_teo/pages/pageDoctor.dart';
import 'package:aplication_teo/pages/page_info.dart';
import 'package:flutter/material.dart';

class opciones extends StatelessWidget {
  
  constructor() {

}
@override
  Widget build(BuildContext context) {
    return Container(
       child: SafeArea(
               
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:30.0),
                    child: ListTile(
                      textColor: Colors.white,  
                      onTap: () => selectedItem(context, 0),                    
                      title: Text("Inicio", style: TextStyle(fontSize: 20)),
                      leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.home_outlined,
                              color: Colors.white,
                              size: 34,
                            )),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: ListTile(
                      textColor: Colors.white, 
                      onTap: () => selectedItem(context, 1),                     
                      title: Text("Info. paciente", style: TextStyle(fontSize: 20)),
                      leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.blinds_outlined,
                              color: Colors.white,
                              size: 34,
                            )),
                      ),
                    ),
                    Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: ListTile(
                      textColor: Colors.white, 
                      onTap: () => selectedItem(context, 2),                     
                      title: Text("Doctor", style: TextStyle(fontSize: 20)),
                      leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.health_and_safety_outlined,
                              color: Colors.white,
                              size: 34,
                            )),
                      ),
                    ),
                    Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: ListTile(
                      textColor: Colors.white, 
                      onTap: () => selectedItem(context, 3),                     
                      title: Text("Configuración", style: TextStyle(fontSize: 20)),
                      leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 34,
                            )),
                      ),
                    ),
                     Padding(
                    padding: const EdgeInsets.only(top:10.0),
                    child: ListTile(
                      textColor: Colors.white,                      
                      title: Text("Emergencias", style: TextStyle(fontSize: 20)),
                      leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 34,
                            )),
                      ),
                    ),
                     Padding(
                    padding: const EdgeInsets.only(top:220.0),
                    child: ListTile(
                      textColor: Colors.white,
                      onTap: () => selectedItem(context, 5),                      
                      title: Text("Salir", style: TextStyle(fontSize: 20)),
                      leading: SizedBox(
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.exit_to_app_sharp,
                              color: Colors.white,
                              size: 34,
                            )),
                      ),
                    ),
                
                ]
       )
    )
    );
    
  }


void selectedItem(BuildContext context, int index) {
    
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => NavBar()
        // )
        // );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBar()));
        
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => infoPage()));
        break;

        case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => infoDoctor(),
        ));
        
        break;
        case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => config(),
        ));
        break;
        case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => infoPage(),
        ));
        break;
        case 5:
        AuthService().logout();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
        break;
    }
  }

}