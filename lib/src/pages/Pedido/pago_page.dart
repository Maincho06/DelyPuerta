import 'package:flutter/material.dart';
class PagoPage extends StatelessWidget {
  const PagoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Color(0xffe46b10);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Pago'),
      ),
    );
  }
}