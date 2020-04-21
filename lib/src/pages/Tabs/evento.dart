import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventoPage extends StatelessWidget {
  const EventoPage({Key key}) : super(key: key);

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
        child: ListView(
          primary: false,
          children: eventos(context)
        ),
      ),
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
            leading: Icon(Icons.flag, color: Color(0xffe46b10)),
            title: Text('Prueba'),
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