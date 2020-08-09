import 'dart:convert';
import 'dart:io';

import 'package:delipuerta/src/services/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MetodosPago extends StatefulWidget {
  final int pedidoId;

  MetodosPago({Key key, this.pedidoId}) : super(key: key);

  @override
  _MetodosPagoState createState() => _MetodosPagoState();
}

class _MetodosPagoState extends State<MetodosPago> {
  PerdidosServices _pe = new PerdidosServices();
  File _picture;
  var _url;
  int _pedidoId;
  var _isloading = false;
  @override
  void initState() {
    _pedidoId = widget.pedidoId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading
        ? Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromRGBO(149, 72, 31, 1)),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Metodo de pago'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: GestureDetector(
                      child: Image.asset('assets/pedidos/yape.png'),
                      onTap: () async {
                        setState(() {
                          _isloading = true;
                        });

                        var image = await ImagePicker.pickImage(
                            source: ImageSource.camera);
                        setState(() {
                          _picture = image;
                        });

                        _url = await _pe.agregarimagen(_pedidoId, _picture);
                        if (_url != null) {
                          _mostraimagen(
                              context, 'Quieres enviar esta imagen?', _url);
                          setState(() {
                            _isloading = false;
                          });
                        }
                      },
                    ),
                  ),

                  // child: IconButton(
                  //     iconSize: 120,
                  //     color: Colors.lightBlue,
                  //     icon: Icon(Icons.image),
                  //     onPressed: () async {
                  //       setState(() {
                  //         _isloading = true;
                  //       });

                  //       var image = await ImagePicker.pickImage(
                  //           source: ImageSource.camera);
                  //       setState(() {
                  //         _picture = image;
                  //       });

                  //       _url = await _pe.agregarimagen(_pedidoId, _picture);
                  //       if (_url != null) {
                  //         _mostraimagen(
                  //             context, 'Quieres enviar esta imagen?', _url);
                  //         setState(() {
                  //           _isloading = false;
                  //         });
                  //       }
                  //     }),
                )
              ],
            ));
  }

  _mostraimagen(BuildContext context, String mensaje, String url) {
    showDialog(
        context: context,
        builder: (bcontext) {
          return AlertDialog(
            title: Text(mensaje),
            content: Image.network(
              url,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    Navigator.of(bcontext).pop();
                    setState(() {
                      _isloading = true;
                    });
                    int resp = await _pe.subirfoto(_pedidoId, _url);

                    if (resp == 1) {
                      Navigator.pushReplacementNamed(context, 'home');
                    }
                  },
                  child: Text('Aceptar')),
              FlatButton(
                  onPressed: () => Navigator.of(bcontext).pop(),
                  child: Text('Cancel'))
            ],
          );
        });
  }
}
