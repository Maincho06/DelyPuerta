import 'package:delipuerta/src/util/session.dart';
import 'package:flutter/material.dart';

import '../../share_prefs/preferencias.dart';
import '../Pedido/metodo_pago.dart';

class PerfilPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //https://www.webconsultas.com/sites/default/files/styles/wc_adaptive_image__small/public/articulos/perfil-resilencia.jpg
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(149, 72, 31, 1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Container(
                    height: 100,
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Perfil',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage('assets/user_image.png'),
                    height: 150,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Nombre apellido',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('Cliente'),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('Nombre apellido apellido'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('correo@correo.com'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('999-999-999'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.gps_fixed,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('Lima'),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    prefs.usuarioId = 0;
                    prefs.tipoUsuario = 0;
                    prefs.token = '';
                    Session se = new Session();
                    se.clear();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Color.fromRGBO(149, 72, 31, 1),
                    ),
                    title: Text('Cerrar sesión'),
                  ),
                ),
                Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
