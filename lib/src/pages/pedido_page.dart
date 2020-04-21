import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PedidoPage extends StatefulWidget {
  PedidoPage({Key key}) : super(key: key);

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  final _estiloTexto = new TextStyle( fontSize: 15 );
  int _conteo = 0;
  Color color = Color(0xffe46b10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Pide tu pollo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text( ' Cantidad de Pollos', style: _estiloTexto,),
              Image(
                image: AssetImage('assets/pollo.png'),
                width: screenWidth(context,dividedBy: 2),
                height: screenHeight(context,dividedBy: 5),
              ),
              _crearBotones(),
              _submitButton()
            ],
          ),
        ),
      ),
      // floatingActionButton: _crearBotones(),
    );
  }

  Widget _crearBotones() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btnAñadir",
              child: Icon(Icons.remove),
              backgroundColor: color,
              onPressed: _sustraer,
            ),
            Text( '$_conteo', style: _estiloTexto,),
            FloatingActionButton(
              heroTag: "btnRestar",
              child: Icon(Icons.add),
              backgroundColor: color,
              onPressed: _agregar,
            )
          ],
        ),
      ),
    );
  }

  Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
  }
  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }
  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  void _agregar() {
    setState(() => _conteo++ );
  }

  void _sustraer() {
    setState(() => _conteo-- );
  }

  _submitButton() {
    return InkWell(
      child: Container(
        width: screenWidth(context,dividedBy: 2),
        height: screenHeight(context,dividedBy: 15),
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              colors: [Color(0xfffbb448), Color(0xfffbb448)]
          )
        ),
        child: Text(
          'Enviar Pedido',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: (){
        //Navigator.pushNamed(context, 'home');
      },
    );
  }
}