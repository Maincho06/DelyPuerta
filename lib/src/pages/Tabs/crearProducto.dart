
import 'package:flutter/material.dart';

class CrearProducto extends StatelessWidget {
var name = TextEditingController();
var descripcion = TextEditingController();
var costo = TextEditingController();
var imagen = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _entryField('Nombre', 
             TextField(
                          controller: name,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                         
                        )
                        
            ),
             _entryField('Descripcion', 
             TextField(
                          controller: name,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                         
                        )
                        
            ),
            _entryField('Precio', 
             TextField(
                          controller: name,
                          decoration: InputDecoration(
                          
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                           keyboardType: TextInputType.numberWithOptions(decimal: true),
                        )
            ),
            
          ],
        ),
      ),
    );

 
}
    Widget _entryField(String title, Widget form, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          form
        ],
      ),
    );
  }
  }