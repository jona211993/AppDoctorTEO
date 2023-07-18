import 'package:aplication_teo/components/graph_widget.dart';
import 'package:flutter/material.dart';
 
class HomePage extends StatefulWidget{

@override
_HomePageState createState() => _HomePageState(); 
}

class _HomePageState extends State<HomePage>{
  Widget _bottomAction1 (){
    return InkWell(
      child: Icon(Icons.wallet , color: Colors.black,size: 45,),
      onTap: () {      
      },
    );
  }
  Widget _bottomAction2 (){
    return InkWell(
      child: Icon(Icons.list , color: Colors.black,size: 45,),
       onTap: () {      
      },
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _bottomAction1(),
            SizedBox(width: 30),
            _bottomAction2()            
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {         
        }
        ),
      // Para el body
      body:_body(),

    
    
    
    );

  }
  Widget _body(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          _selector(),
          _expenses(),
          _graph(),
          _list(),
          ],
    ),
    );
  }
Widget _selector() => Container();
Widget _expenses() {
  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: Text("Glucómetro",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0,
          color: Colors.black,
        ),
        ),
      ),
      Text("Total expenses",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        color: Colors.blueAccent,
      ),
      ),
    ],
  );
}
Widget _graph() {
  return Container(
    height: 300,
    child: LineChartSample2());
}

Widget _item (String nombre, String message, double value) {
  return ListTile(
    leading: Icon(Icons.pending_actions, size:32, color: Color.fromARGB(250, 52, 50, 50), ),
    title: Text(nombre,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black,
              ),),
    subtitle: Text(message),
    trailing: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 138, 174, 237).withOpacity(0.6),
        borderRadius: BorderRadius.circular(5.0),

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$value mg/h",
        style: TextStyle(
          color:Color.fromARGB(255, 33, 89, 243), 
          fontWeight: FontWeight.bold,
           fontSize:16 ),
           ),
      )),
  );
}


Widget _list(){
  return Expanded(
    child: ListView(
      children: <Widget> [
          _item("Ultima medición","Valor dentro de los usual", 98),
          _item("Fecha:","Valor dentro de los usual", 92),
          _item("Fecha","Valor dentro de los usual", 90),
          _item("Fecha","Valor dentro de los usual", 93),
          _item("Fecha:","Valor dentro de los usual", 92),
          _item("Fecha","Valor dentro de los usual", 90),
          _item("Fecha","Valor dentro de los usual", 93),
          
      ],
    ),
  );
}













}