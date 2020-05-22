import 'package:delipuerta/src/Widget/bezierContainer.dart';
import 'package:delipuerta/src/services/login/login_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
Login log = new Login();
var email= TextEditingController();
var contra = TextEditingController();
    var _isFetching=false;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    _submitButton(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      alignment: Alignment.centerRight,
                      child: Text('¿ Olvidaste tu Contraseña ?',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                    // _divider(),
                    // buttonSignInSocial(),
                    //_divider(),
                    //buttonSignInSocial(),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),_isFetching? Positioned.fill(child: Container(
     color: Colors.black45,
     child: Center(
       child: CupertinoActivityIndicator( radius: 15,),
     ),
   )):Container(),
               
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
      text: 'Del',
      style: GoogleFonts.portLligatSans(
        textStyle: Theme.of(context).textTheme.display1,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: Color(0xffe46b10),
      ),
      children: [
        TextSpan(
          text: 'y',
          style: TextStyle(color: Colors.black, fontSize: 40),
        ),
        TextSpan(
          text: 'Puerta',
          style: TextStyle(color: Color(0xffe46b10), fontSize: 40),
        ),
      ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Correo"),
        _entryField2("Contraseña", isPassword: true),
      ],
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
            controller: email,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
  
  Widget _entryField2(String title, {bool isPassword = false}) {
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
            controller: contra,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('Iniciar Sesión'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
  
  buttonSignInSocial() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          facebook(),
          google(),
        ],
      ),
    );
  }

  facebook() {
    return InkWell(
      child: Image(
        image: AssetImage('assets/facebook.png'),
        height: 50,
        fit: BoxFit.fill,
      ),
      onTap: () async {
        
      },
    );
  }

  google() {
    return InkWell(
      child: Image(
        image: AssetImage('assets/google.png'),
        height: 50,
        fit: BoxFit.fill,
      ),
      onTap: () {
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
            '¿ No tienes cuenta ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'registro');
            },
            child: Text(
              'Registrate',
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

  _mensaje(BuildContext context, String mensaje){
      showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Ingreso'),
            content: Text(mensaje),       
            actions: <Widget>[
              FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: Text('Ok'))
            ], 
          );
        }
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
      onTap: ()async{
            if(_isFetching) return;
                      setState(() {
                        _isFetching=true;
                      });

        print(email.text+ " "+contra.text);

          
            final resp=await log.login(email.text, contra.text);
            print(resp);
            
            if(resp['ok']){
               _isFetching=false;
              _mensaje(context,resp['mensaje']);
              //Navigator.pushNamedAndRemoveUntil(context, 'videocall', (_)=>false);
              Navigator.pushNamed(context, 'splash');
            
            }else{
               _isFetching=false;
              _mensaje(context,resp['mensaje']);
            }
      //  Navigator.pushNamed(context, 'home');
      },
    );
  }
}