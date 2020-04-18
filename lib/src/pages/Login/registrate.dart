import 'package:delipuerta/src/Widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage({Key key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
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
                    _submitButton(),
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
    return Container(
      height: 500,
      child: ListView(
        children: <Widget>[
          _entryField("Dni"),
          _entryField("Nombre"),
          _entryField("Apellido"),
          _entryField("Correo"),
          _entryField("Contraseña", isPassword: true),
        ],
      )
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
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
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  _submitButton() {
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
          'Iniciar Sesión',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'home');
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