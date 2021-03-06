import 'package:delipuerta/src/pages/Login/registrate.dart';
import 'package:delipuerta/src/pages/Login/splash.dart';
import 'package:delipuerta/src/pages/Pedido/items_page.dart';
import 'package:delipuerta/src/pages/Pedido/metodo_pago.dart';
import 'package:delipuerta/src/pages/Pedido/pago_page.dart';
import 'package:delipuerta/src/pages/Pedido/carrito_page.dart';
import 'package:delipuerta/src/pages/Pedido/pedido_page.dart';
import 'package:delipuerta/src/pages/Pedido/producto_page.dart';
import 'package:delipuerta/src/pages/Tabs/crearProducto.dart';
import 'package:delipuerta/src/services/notificaciones/push_notification.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:delipuerta/src/pages/Login/login.dart';
import 'package:delipuerta/src/pages/home_page.dart';
import 'package:delipuerta/src/bloc/registro_provider.dart';


class MyApp extends StatefulWidget {

  


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
@override
  void initState() { 
    final pushNotificationProvider= new PushNotificationProvider();    
    pushNotificationProvider.initNotifications();
    super.initState();
    pushNotificationProvider.mensajes.listen((onData){
      print(onData);
      //navigatorKey.currentState.pushNamed(onData,arguments: onData);
    }); 
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'login',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(149, 72, 31,1),
          primarySwatch: Colors.brown,
          textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
            body1: GoogleFonts.montserrat(textStyle: textTheme.body1),
          )
        ),
        initialRoute: 'splash',
        routes: {
          
          'login'     : (_) => LoginPage(),
          'registro'  : (_) => RegistroPage(),
          'home'      : (_) => HomePage(),
          'pedido'    : (_) => PedidoPage(),
          'productos' : (_) => ProductoPage(),
          'crearproducto' : (_) => CrearProducto(),
          'carrito' : (_) => CarritoPage(),
          'splash': (_) => Splash(),
          'items': (_)=>ItemsPage(),
          
          //'pedido/metodo_pago'    : (_) => MetodoPagoPage(),
        },
      ),
    );
  }
}