import 'package:delipuerta/src/models/evento_model.dart';
import 'package:delipuerta/src/services/evento_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventoPage extends StatelessWidget {
  EventoServices eve=new EventoServices();

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       _title(context),
    //       // Padding(
    //       //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
    //       //   child: Center(
    //       //     child: ListView(
    //       //       primary: false,
    //       //       children: eventos()
    //       //     ),
    //       //   ),
    //       // )
    //     ],
    //   ),
    // );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Center(
        child: _crearList()
      ),
    );
  }



  Widget _crearList(){
 return FutureBuilder(
   future: eve.mostrarEventos(),

   builder: (BuildContext context, AsyncSnapshot snapshot) {
     if(snapshot.hasData ){
       final rendici= snapshot.data;

       return ListView.builder(
         itemCount: rendici.length,
         itemBuilder: (context, i){

           return _crearvista(context, rendici[i]);

         },);
     }else{
       return Center( child: CircularProgressIndicator());
     }
   },
 );
}
  Widget _crearvista(BuildContext context,EventoModel rendi){

  String fecha= DateFormat('yyyy-MM-dd hh:mm').format(rendi.eventoFecha);
    return Column(
            
    children:<Widget>[ Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        child: Card(
          elevation: 5.0,
          child: ListTile(
            leading: Icon(Icons.flag, color: Color.fromRGBO(149, 72, 31,1)),
            title: Text('${rendi.eventoNombre}'),
            subtitle: Text(fecha),
            contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
          )
        ),
        onTap: () {
          Navigator.pushNamed(context, 'productos',arguments: rendi);
          print('Nos Vamos');
        },
      ),
    ),

          ]

    );

  }

  eventos(BuildContext context) {
    List<Widget> lWidget = [];
    final card = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        child: Card(
          elevation: 5.0,
          child: ListTile(
            leading: Icon(Icons.flag, color: Color.fromRGBO(149, 72, 31,1)),
            title: Text('San Fernando'),
            subtitle: Text('Venta de Pollos'),
            contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
          )
        ),
        onTap: () {
          Navigator.pushNamed(context, 'pedido');
          print('Nos Vamos');
        },
      ),
    );
    
    lWidget..add(card);
    return lWidget;
  }

  Widget _title(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
      text: 'Del',
      style: GoogleFonts.portLligatSans(
        textStyle: Theme.of(context).textTheme.display1,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: Color(0xffe46b10),
      ),
      children: [
        TextSpan(
          text: 'y',
          style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        TextSpan(
          text: 'Puerta',
          style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
        ),
      ]),
    );
  }
}