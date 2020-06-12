import 'package:delipuerta/src/Widget/bezierContainer.dart';
import 'package:delipuerta/src/bloc/registro_provider.dart';
import 'package:delipuerta/src/models/registrar/condominio_model.dart';
import 'package:delipuerta/src/models/registrar/edificio_model.dart';
import 'package:delipuerta/src/models/registrar/registro_model.dart';
import 'package:delipuerta/src/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delipuerta/src/services/registrar_usuario_services.dart';
import 'package:delipuerta/src/util/notificaciones_util.dart' as notificaciones;

class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  Usuario usuario = new Usuario();
  final _formKey = GlobalKey<FormState>();

  String condo = "seleccionar";
  List<CondominioModel> listCondominio;
  int idCondo;

  String edifi = "seleccionar";
  List<EdificioModel> listEdificio;
  int idEdifi;

  bool pasar=false;
  bool dibujar = true;
  String respuesta;
  RegistrarUsuarioModel registrarUsuario;
  @override
  Widget build(BuildContext context) {
    listCondominio = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    _title(),
                    SizedBox(height: 50),
                    _formulario(context),
                    SizedBox(height: 20),
                    submitButton(),
                    //_divider(),
                    //buttonSignInSocial(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _createAccountLabel(),
              ),
              Positioned(
                  top: -MediaQuery.of(context).size.height * .22,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: BezierContainer())
            ],
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Regí',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'st',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            TextSpan(
              text: 'rate',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
            ),
          ]),
    );
  }

  Widget _formulario(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        height: 400,
        child: ListView(children: formUI(context)),
      ),
    );
  }

  List<Widget> formUI(BuildContext context) {
    final bloc = Provider.of(context);
    List<Widget> lwidget = [];
    //DNI

    final formDni = StreamBuilder(
      stream: bloc.dniStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                icon: Icon(Icons.picture_in_picture, color: Colors.orange),
                labelText: 'DNI',
                errorText: snapshot.error),
            onChanged: bloc.changeDni,
          ),
        );
      },
    );
    //Nombre
    final formNombre = StreamBuilder(
        stream: bloc.nombreStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.orange),
                labelText: 'Nombre',
              ),
              onChanged: bloc.changeNombre,
            ),
          );
        });
    //Apellido
    final formApellido = StreamBuilder(
        stream: bloc.apellidoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: Icon(Icons.person, color: Colors.orange),
                labelText: 'Apellidos',
              ),
              onChanged: bloc.changeApellido,
            ),
          );
        });
    //Correo
    final formCorreo = StreamBuilder(
        stream: bloc.correoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(Icons.alternate_email, color: Colors.orange),
                  labelText: 'Correo Electronico',
                  errorText: snapshot.error),
              onChanged: bloc.changeCorreo,
            ),
          );
        });
    final formContrasena = StreamBuilder(
        stream: bloc.contrasenaStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: TextField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  icon: Icon(Icons.lock_outline, color: Colors.orange),
                  labelText: 'Contraseña',
                  errorText: snapshot.error),
              onChanged: bloc.changeContrasena,
            ),
          );
        });
    //Condominio

    final formCondominio = Container(
        child: Row(children: <Widget>[
      Icon(Icons.location_on, color: Colors.orange),
      SizedBox(width: 15),
      DropdownButton<String>(
        items: listCondominio.map((CondominioModel value) {
          return DropdownMenuItem<String>(
            value: value.codominioNombre,
            child: Text("${value.codominioNombre}"),
          );
        }).toList(),
        onChanged: (String newValueSelected){
          dibujar = false;
          int temp = listCondominio.indexWhere((user) => user.codominioNombre == newValueSelected);
          idCondo = listCondominio[temp].condominioId;
          setState(() {
            print("$idCondo");
            condo = newValueSelected;
          });
        },
        hint: Text("$condo"),
        underline: Container(
          height: 2,
          color: Colors.orange,
        ),
      ),
    ]));

    final formEdificio = FutureBuilder(
        future: RegistrarServices.mostrarEdificio(idCondo).then((value) => listEdificio = value),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            child: Row(children: <Widget>[
              Icon(Icons.location_city, color: Colors.orange),
              SizedBox(width: 15),
              DropdownButton<String>(
                items: dibujar ? null : listarEdificios(),
                onChanged: (String newValueSelected) {
                  int temp = listEdificio.indexWhere(
                      (user) => user.edificioNombre == newValueSelected);
                  idEdifi = listEdificio[temp].edificioId;
                  setState(() {
                    print("$idEdifi");
                    edifi = newValueSelected;
                  });
                },
                hint: Text("$edifi"),
                underline: Container(
                  height: 2,
                  color: Colors.orange,
                ),
              ),
            ]),
          );
        });
    //Departamento
    final formDepartamento = StreamBuilder(
        stream: bloc.departamentoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: Icon(Icons.local_convenience_store, color: Colors.orange),
                labelText: 'Departamento',
              ),
              onChanged: bloc.changeDepartamento,
            ),
          );
        });
    // Telefono
    final formTelefono = StreamBuilder(
        stream: bloc.telefonoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.add_call, color: Colors.orange),
                labelText: 'Celular',
                errorText: snapshot.error,
              ),
              onChanged: bloc.changeTelefono,
            ),
          );
        });
    lwidget
      ..add(formDni)
      ..add(formNombre)
      ..add(formApellido)
      ..add(formCondominio)
      ..add(formEdificio)
      ..add(formDepartamento)
      ..add(formTelefono)
      ..add(formCorreo)
      ..add(formContrasena);
    return lwidget;
  }

  listarEdificios() {
    return listEdificio.map((EdificioModel value) {
      return DropdownMenuItem<String>(
        value: value.edificioNombre,
        child: Text(value.edificioNombre),
      );
    }).toList();
  }

  Widget edificio() {
    return Container(
        child: Row(children: <Widget>[
      Icon(Icons.location_city, color: Colors.orange),
      SizedBox(width: 15),
      DropdownButton<String>(
        items: listEdificio.map((EdificioModel value) {
          return DropdownMenuItem<String>(
            value: value.edificioNombre,
            child: Text(value.edificioNombre),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            print("$idEdifi");
            edifi = newValueSelected;
          });
        },
        hint: Text("$edifi"),
        underline: Container(
          height: 2,
          color: Colors.orange,
        ),
      ),
    ]));
  }

  submitButton() {
    final blocF = Provider.of(context);
    return StreamBuilder(
        stream: blocF.formValidStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
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
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                child: Text(
                  'Regístrarse',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              onTap: snapshot.hasData
                  ? () async {
                      if (_formKey.currentState.validate()) {
                        RegistrarUsuarioModel registrarUsuario= new RegistrarUsuarioModel();
                        registrarUsuario.dni = blocF.dni;
                        registrarUsuario.nombre = blocF.nombre.trim();
                        registrarUsuario.apellido = blocF.apellido.trim();
                        registrarUsuario.edificio = idEdifi;
                        registrarUsuario.departamento = blocF.departamento;
                        registrarUsuario.telefono = blocF.telefono;
                        registrarUsuario.correo = blocF.correo;
                        registrarUsuario.contrasena = blocF.contrasena.trim();
                        respuesta = await RegistrarServices.registrarUsuario(registrarUsuario);
                        if (respuesta == "Registrado") {
                          pasar=true;
                          _showMyDialog(respuesta, pasar);
                          
                        } else {
                          _showMyDialog(respuesta, pasar);
                        }
                      }
                    }
                  : null);
        });
  }

  Future<void> _showMyDialog(String mensaje,bool pasar) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$mensaje'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: pasar? () {
                Navigator.pushNamed(context, 'login');
              }:(){
                Navigator.of(context).pop();
              },
            ),
            
          ],
        );
      },
    );
  }

  _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '¿ Ya tienes cuenta ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Inicia Sesión',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
