import 'package:delipuerta/src/pages/Tabs/crearEvento.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:delipuerta/src/pages/Tabs/evento.dart';
import 'package:delipuerta/src/pages/Tabs/perfil.dart';

import 'Tabs/crearProducto.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  _callPage(int paginaActual) {
    switch ( paginaActual ) {
      case 0: return EventoPage();
      case 1: return PerfilPage();
      case 2: return CrearEventoPage();
      case 3: return CrearProducto(evento: false,);
      default:
        return EventoPage();
    }
  }

  _crearBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.calendar),
          title: Text('Eventos')
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),
          title: Text('Perfil')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create),
          title: Text('Crear Evento')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create),
          title: Text('Producto')
        ),
      ],
    );
  }
}