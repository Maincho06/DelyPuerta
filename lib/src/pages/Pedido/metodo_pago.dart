import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
final int size = 40;
class MetodoPagoPage extends StatelessWidget {
  const MetodoPagoPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color color = Color(0xffe46b10);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Metodo de Pago'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text
              ('Tarjeta',
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffe46b10),
                ),
              ),
              Expanded(child:  _SvgPage('assets/pedidos/tarjeta.svg')),
              Text
              ('Efectivo',
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffe46b10),
                ),
              ),
              Expanded(child:  _SvgPage('assets/pedidos/efectivo.svg')),
              Text
              ('Yape',
                style: GoogleFonts.portLligatSans(
                  textStyle: Theme.of(context).textTheme.display1,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffe46b10),
                ),
              ),
              Expanded(child:  _PngPage('assets/pedidos/yape.png')),
            ],
          ),
        ),
      ),
    );
  }

  

  
}

class _SvgPage extends StatelessWidget {
  final String svg;
  const _SvgPage(this.svg);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 50.0,bottom: 50.0,right: 50.0,top: 20.0),
        child: SvgPicture.asset(svg)
      ),
      onTap: () {
        print('Veamo');
      },
      splashColor: Color(0xffe46b10),
    );
  }
}
class _PngPage extends StatelessWidget {
  final String png;
  const _PngPage(this.png);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 50.0,bottom: 50.0,right: 50.0,top: 20.0),
        child: Image.asset(png)
      ),
      onTap: () {
        print('Yape');
      },
      splashColor: Color(0xffe46b10),
    );
  }
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}
double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}
double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}