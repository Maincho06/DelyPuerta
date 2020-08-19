import 'package:delipuerta/src/services/eventos_services.dart';
import 'package:delipuerta/src/util/session.dart';
import 'package:flutter/material.dart';

import '../../share_prefs/preferencias.dart';
import '../Pedido/metodo_pago.dart';

class PerfilPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  final usuarioServices = new UsuarioServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 80,
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
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Image(
                    image: AssetImage('assets/user_image.png'),
                    height: 100,
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
          InfoUser(prefs: prefs, usuarioServices: usuarioServices)
        ],
      ),
    );
  }
}

class InfoUser extends StatelessWidget {
  const InfoUser(
      {Key key, @required this.prefs, @required this.usuarioServices})
      : super(key: key);

  final PreferenciasUsuario prefs;
  final UsuarioServices usuarioServices;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.56,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: FutureBuilder(
        future: usuarioServices.mostrarUsuario(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data;
            final nombre = users[0]['usuarioNombre'];
            final apellido = users[0]['usuarioApellido'];
            final telefono = users[0]['usuarioTelefono'];
            final correo = users[0]['usuarioCorreo'];
            return ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('$nombre $apellido'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('$correo'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Color.fromRGBO(149, 72, 31, 1),
                  ),
                  title: Text('$telefono'),
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
                    title: Text('Salir'),
                  ),
                ),
              ],
            );
          } else {
            Container();
          }
        },
      ),
    );
  }
}
