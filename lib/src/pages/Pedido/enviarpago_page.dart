import 'dart:convert';
import 'dart:io';

import 'package:delipuerta/src/pages/Pedido/metodo_pago.dart';
import 'package:delipuerta/src/services/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'Seleccione el medio de pago.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Container(
                    //   // alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     width: 80,
                    //     height: 80,
                    //     child: GestureDetector(
                    //       child: Image.asset('assets/pedidos/yape.png'),
                    //       onTap: () async {
                    //         setState(() {
                    //           _isloading = true;
                    //         });

                    //         var image = await ImagePicker.pickImage(
                    //             source: ImageSource.camera);
                    //         setState(() {
                    //           _picture = image;
                    //         });

                    //         _url = await _pe.agregarimagen(_pedidoId, _picture);
                    //         if (_url != null) {
                    //           _mostraimagen(
                    //               context, 'Quieres enviar esta imagen?', _url);
                    //           setState(() {
                    //             _isloading = false;
                    //           });
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   // alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     width: 80,
                    //     height: 80,
                    //     child: GestureDetector(
                    //       child: Image.asset('assets/pedidos/plin.png'),
                    //       onTap: () async {
                    //         setState(() {
                    //           _isloading = true;
                    //         });

                    //         var image = await ImagePicker.pickImage(
                    //             source: ImageSource.camera);
                    //         setState(() {
                    //           _picture = image;
                    //         });

                    //         _url = await _pe.agregarimagen(_pedidoId, _picture);
                    //         if (_url != null) {
                    //           _mostraimagen(
                    //               context, 'Quieres enviar esta imagen?', _url);
                    //           setState(() {
                    //             _isloading = false;
                    //           });
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),
                    buttonPay(
                        title: 'Yape',
                        url: 'assets/pedidos/yape.png',
                        onPress: () async {
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
                            // _mostraimagen(
                            //     context, 'Quieres enviar esta imagen?', _url);
                            setState(() {
                              _isloading = false;
                            });
                          }
                        }),
                    buttonPay(
                        title: 'Plin',
                        url: 'assets/pedidos/plin.png',
                        onPress: () async {
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
                            // _mostraimagen(
                            //     context, 'Quieres enviar esta imagen?', _url);
                            setState(() {
                              _isloading = false;
                            });
                          }
                        }),
                    buttonPay(
                        title: 'Deposito',
                        url: 'assets/pedidos/transfer1.jpg',
                        onPress: () async {
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
                            // _mostraimagen(
                            //     context, 'Quieres enviar esta imagen?', _url);
                            setState(() {
                              _isloading = false;
                            });
                          }
                        }),
                    // Container(
                    //   // alignment: Alignment.bottomCenter,
                    //   child: Container(
                    //     width: 80,
                    //     height: 80,
                    //     child: GestureDetector(
                    //       child: ClipRRect(
                    //         borderRadius: BorderRadius.circular(50),
                    //         child: Image.asset(
                    //           'assets/pedidos/transfer1.jpg',
                    //         ),
                    //       ),
                    //       onTap: () async {
                    //         setState(() {
                    //           _isloading = true;
                    //         });

                    //         var image = await ImagePicker.pickImage(
                    //             source: ImageSource.camera);
                    //         setState(() {
                    //           _picture = image;
                    //         });

                    //         _url = await _pe.agregarimagen(_pedidoId, _picture);
                    //         if (_url != null) {
                    //           _mostraimagen(
                    //               context, 'Quieres enviar esta imagen?', _url);
                    //           setState(() {
                    //             _isloading = false;
                    //           });
                    //         }
                    //       },
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                vistaPay(),
              ],
            ));
  }

  Widget buttonPay({String url, Function onPress, String title}) {
    return Container(
      // alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  url,
                ),
              ),
              onTap: () {
                onPress();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text('$title'),
          )
        ],
      ),
    );
  }

  Widget vistaPay() {
    return (_url == null)
        ? Container(
            // height: 120,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.asset(
              'assets/pedidos/pagar-directa.png',
              height: 200,
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  '¿Quieres enviar esta imagen?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.54,
                    child: ListView(
                      children: [
                        Container(
                          child: Image.network(
                            this._url,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: MaterialButton(
                      onPressed: () async {
                        // Navigator.of(bcontext).pop();
                        setState(() {
                          _isloading = true;
                        });
                        int resp = await _pe.subirfoto(_pedidoId, _url);

                        if (resp == 1) {
                          Navigator.pushReplacementNamed(context, 'home');
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blueGrey,
                        ),
                        child: FaIcon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
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
