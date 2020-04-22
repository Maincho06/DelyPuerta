import 'package:delipuerta/src/Widget/bezierContainer.dart';
import 'package:delipuerta/src/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delipuerta/src/services/usuario_services.dart';
import 'package:delipuerta/src/util/notificaciones_util.dart' as notificaciones;

class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  Usuario usuario = new Usuario();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      height: 50,
                    ),
                    _formulario(),
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
                  child: BezierContainer()
              )
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
      text: 'Regi',
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

  Widget _formulario() {
    // return Column(
    //   children: <Widget>[
    //     _entryField("Dni"),
    //     _entryField("Nombre"),
    //     _entryField("Apellido"),
    //     _entryField("Correo"),
    //     _entryField("Contraseña", isPassword: true),
    //   ],
    // );
    // return Container(
    //   height: 500,
    //   child: ListView(
    //     children: <Widget>[
    //       _entryField("Dni" , dniController),
    //       _entryField("Nombre" , nombreController),
    //       _entryField("Apellido" , apellidoController),
    //       _entryField("Correo" , correoController),
    //       _entryField("Contraseña", passwordController ,isPassword: true),
    //       _entryField("Condominio" , condominioController),
    //       _entryField("Edificio" , edificioController),
    //       _entryField("Departamento" , departamentoController),
    //     ],
    //   )
    // );
    return Form(
      key: _formKey,
      child: Container(
        height: 400,
        child: ListView(
          children: formUI()
        ),
      ),
    );
  }

  List<Widget> formUI() {
    List<Widget> lwidget = [];
    //DNI
    final formDni = _entryField(
      "Dni",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
        onChanged: (value) =>  usuario.dni = value,
      )
    );
    //Nombre
    final formNombre = _entryField(
      "Nombre",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
        onChanged: (value) => usuario.nombre = value,
      )
    );
    //Apellido
    final formApellido = _entryField(
      "Apellido",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
        onChanged: (value) => usuario.apellido = value,
      )
    );
    //Correo
    final formCorreo = _entryField(
      "Correo",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
        onChanged: (value) => usuario.correo = value,
      )
    );
    final formContrasena = _entryField(
      "Contraseña",
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
        onChanged: (value) => usuario.contrasea = value,
      )
    );
    //Condominio
    final formCondominio = _entryField(
      "Condominio",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
      )
    );
    //Edificio
    final formEdificio = _entryField(
      "Edificio",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
      )
    );
    //Departamento
    final formDepartamento = _entryField(
      "Departamento",
      TextFormField(
        obscureText: false,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
      )
    );
    lwidget..add(formDni)
           ..add(formNombre)
           ..add(formApellido)
           ..add(formCondominio)
           ..add(formEdificio)
           ..add(formDepartamento)
           ..add(formCorreo)
           ..add(formContrasena);
    return lwidget;
  }

  Widget _entryField(String title, Widget form) {
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

  submitButton() {
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
              colors: [Color(0xfffbb448), Color(0xfff7892b)]
          )
        ),
        child: Text(
          'Regístrate',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        if(_formKey.currentState.validate()) {
          await usuarioServices.registrarUsuario(usuario);
          Navigator.pushNamed(context, 'home');
        }
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