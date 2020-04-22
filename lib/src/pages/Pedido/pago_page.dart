import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
class PagoPage extends StatefulWidget {
  const PagoPage(this.tipoPago, this.precioTotal);
  final tipoPago ; //TARJETA,EFECTIVO,YAPE
  final precioTotal ; //TARJETA,EFECTIVO,YAPE
  @override
  _PagoPageState createState() => _PagoPageState();
}

class _PagoPageState extends State<PagoPage> {
  File foto;
  @override
  Widget build(BuildContext context) {
    Color color = Color(0xffe46b10);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Pago'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'Total a pagar',
                      style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                      ),
                    ),
                    Text(
                      '${ widget.precioTotal }',
                      style: GoogleFonts.portLligatSans(
                        textStyle: Theme.of(context).textTheme.display1,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffe46b10),
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _seleccionarFoto,
                child: Text('Imagen', style: TextStyle(color: Colors.white),),
                color: color
              ),
              _mostrarFoto(),
              RaisedButton(
                onPressed: () {},
                child: Text('Enviar', style: TextStyle(color: Colors.white),),
                color: color
              ),
            ],
          ),
        )
      ),
    );
  }

  void _seleccionarFoto() async {

    foto = await ImagePicker.pickImage(
      source: ImageSource.gallery
    );

    if ( foto != null ) {
      // limpieza
    }

    setState(() {
      print(foto);
    });

  }

  _mostrarFoto() {
    return Image(
      image: AssetImage(foto?.path ??  'assets/no-image.png'),
      height: 300.0,
      fit: BoxFit.cover
    );
  }
}