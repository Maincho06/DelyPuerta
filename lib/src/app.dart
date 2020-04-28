import 'package:delipuerta/src/pages/Login/registrate.dart';
import 'package:delipuerta/src/pages/Pedido/metodo_pago.dart';
import 'package:delipuerta/src/pages/Pedido/pago_page.dart';
import 'package:delipuerta/src/pages/Pedido/pedido_page.dart';
import 'package:delipuerta/src/pages/Pedido/producto_page.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:delipuerta/src/pages/Login/login.dart';
import 'package:delipuerta/src/pages/home_page.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DelyPuerta',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
        )
      ),
      initialRoute: 'login',
      routes: {
        'login'     : (_) => LoginPage(),
        'registro'  : (_) => RegistroPage(),
        'home'      : (_) => HomePage(),
        'pedido'    : (_) => PedidoPage(),
        'productos' : (_) => ProductoPage(),
        //'pedido/metodo_pago'    : (_) => MetodoPagoPage(),
      },
    );
  }
}