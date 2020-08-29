import 'package:delipuerta/src/models/items_model.dart';
import 'package:delipuerta/src/models/pagos_modal.dart';
import 'package:delipuerta/src/models/pedido_model.dart';
import 'package:delipuerta/src/pages/Pedido/enviarpago_page.dart';
import 'package:delipuerta/src/pages/Pedido/metodo_pago.dart';
import 'package:delipuerta/src/services/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  PerdidosServices pe = new PerdidosServices();
  bool _pagar = false;
  PedidosModel proData = new PedidosModel();
  // List<dynamic> getItems = new List();

  @override
  double total = 0;
  List empresasId = [];
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      proData = ModalRoute.of(context).settings.arguments;
      if (proData.estadoPedidoId == 3) {
        _pagar = true;
      }
      _getItems(proData);
    });
  }

  Future<List<dynamic>> _getItems(PedidosModel proData) async {
    return await pe.mostrarItems(proData.pedidoId);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData query;
    query = MediaQuery.of(context);
    final PedidosModel proData = ModalRoute.of(context).settings.arguments;
    String fecha = DateFormat('yyyy-MM-dd').format(proData.pedidoFecha);
    String hora = DateFormat('hh:mm').format(proData.pedidoFecha);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${proData.usuarioNombre}'),
        actions: [
          _mostrarbotones(
              proData.estadoPedidoId, proData.pedidoId, proData.empresaRuc)
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 20),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mostrarvento(
                              "Organizador",
                              proData.empresaRazonSocial,
                              Icon(
                                Icons.ac_unit,
                                size: 15,
                              )),
                          mostrarvento(
                              "Fecha de entrega",
                              fecha,
                              Icon(
                                Icons.date_range,
                                size: 15,
                              )),
                          mostrarvento(
                              "Hora de entraga",
                              hora,
                              Icon(
                                Icons.time_to_leave,
                                size: 15,
                              )),
                          mostrarvento(
                              "Cliente",
                              "${proData.usuarioNombre} ${proData.usuarioApellido}",
                              Icon(
                                Icons.supervised_user_circle,
                                size: 15,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: QrImage(
                      data: "${proData.empresaRuc}|${proData.eventoId}",
                      version: QrVersions.auto,
                      size: 100.0,
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              _crearvist2(context),

              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                // color: Colors.red,
                child: _creatLista(proData),
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                // margin: new EdgeInsets.fromLTRB(
                //     query.size.width * 0.09,
                //     query.size.height / 2.8,
                //     query.size.width * 0.09,
                //     query.size.height / 12.0),
                // // color: Colors.red,

                // child: mostrarvento(
                //     'Total',
                //     'S/ ${(proData.montoTotal).toStringAsFixed(2)}',
                //     Icon(Icons.payment)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.payment),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'S/ ${(proData.montoTotal)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              //_crearvista(context, proData),
            ],
          ),
          // Container(
          //   // padding: new EdgeInsets.fromLTRB(
          //   //     query.size.width * 0.09,
          //   //     query.size.width / 1.6,
          //   //     query.size.width * 0.09,
          //   //     query.size.width / 5),
          //   // color: Colors.red,
          //   child: _creatLista(proData),
          // ),
        ],
      ),
    );
  }

  _mostrarbotones(int rendi, int pedido, String ruc) {
    print('que es esto $rendi');
    if (rendi == 3) {
      return IconButton(
          enableFeedback: false,
          icon: Icon(Icons.payment),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                settings: RouteSettings(name: "/MetodosPago"),
                builder: (context) => MetodosPago(
                      pedidoId: pedido,
                      ruc: ruc,
                    )));
          });
    } else {
      return Container();
    }
  }

  mostrarvento(final comun, final propio, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              child,
              SizedBox(
                width: 5,
              ),
              Container(
                  child: Text(
                '$comun: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '$propio',
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          Divider(
            color: Colors.grey,
            height: 5,
          ),
        ],
      ),
    );
  }

  _creatLista(PedidosModel rendi) {
    return StreamBuilder(
      stream: pe.pedidosStream,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          final rendici = snapshot.data;

          return ListView.builder(
            reverse: false,
            itemCount: rendici.length,
            itemBuilder: (context, i) {
              return _crearvista(context, rendici[i]);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearvista(BuildContext context, ItemsModel rendi) {
    double precioTotal;

    precioTotal =
        double.parse((rendi.productoCosto * rendi.cantidad).toStringAsFixed(2));

    total = total + precioTotal;
    empresasId.add(rendi.empresaId);
    MediaQueryData query;
    query = MediaQuery.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              // FutureBuilder(
              //   future: pe.metodosDePagoPorEmpresa(rendi.empresaId.toString()),
              //   // initialData: InitialData,
              //   builder: (BuildContext context,
              //       AsyncSnapshot<List<PagosModal>> snapshot) {
              //         if(snapshot.hasData){
              //             return;

              //         }else{
              //           retrun
              //         }
              //   },
              // );
              final List<PagosModal> data =
                  await pe.metodosDePagoPorEmpresa(rendi.empresaId.toString());

              print(data);
              if (data.length > 0) {
                mainshowDialogMensaje('mensaje ', data);
              }
              // print(rendi.cantidad);
              // // print(rendi.cantidad);
              // mainshowDialogAddItems(rendi.itemId, rendi.cantidad);
            },
            child: Container(
              child: Text(
                '${rendi.productoNombre}',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              width: query.size.width / 3.5,
            ),
          ),
          GestureDetector(
            onTap: () {
              print(rendi.cantidad);
              // print(rendi.cantidad);
              mainshowDialogAddItems(rendi.itemId, rendi.cantidad);
            },
            child: Container(
              child: Text('${rendi.cantidad}', textAlign: TextAlign.center),
              width: query.size.width / 11,
            ),
          ),
          GestureDetector(
            onTap: () {
              print(rendi.cantidad);
              // print(rendi.cantidad);
              mainshowDialogAddItems(rendi.itemId, rendi.cantidad);
            },
            child: Container(
              child: Text(
                'S/ ${rendi.productoCosto}',
                textAlign: TextAlign.center,
              ),
              width: query.size.width / 5,
            ),
          ),
          GestureDetector(
            onTap: () {
              print(rendi.cantidad);
              // print(rendi.cantidad);
              mainshowDialogAddItems(rendi.itemId, rendi.cantidad);
            },
            child: Container(
              child: Text(
                'S/ $precioTotal',
                textAlign: TextAlign.center,
              ),
              width: query.size.width / 5.5,
            ),
          ),
        ],
      ),
    );
  }

  mainshowDialogMensaje(String texto, List<PagosModal> data) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Column(
              children: [Text('Medios de pago'), Divider()],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              // children: [
              //   Text('data'),
              //   Text('data'),
              //   Text('data'),
              // ],
              children: data.map((item) {
                return Column(
                  children: [
                    Text('${item.nombre}'),
                    SizedBox(
                      height: 5,
                    )
                  ],
                );
              }).toList(),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  child: Align(widthFactor: 2, child: Text('Cerrar')))
            ],
          );
        });
  }

  mainshowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Column(
              children: <Widget>[
                Text('Procesando'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text('Se esta actaulizando'),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  child: Align(widthFactor: 2, child: Text('Aceptar')))
            ],
          );
        });
  }

  mainshowDialogAddItems(int id, int cantidad) {
    myController.text = "$cantidad";
    int nro = cantidad;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Column(
              children: <Widget>[
                Text('Modificar'),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Divider(
                  height: 1.0,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () {
                            setState(() {
                              nro++;
                              myController.text = "$nro";
                              print(nro);
                            });
                          },
                          elevation: 0.0,
                          color: Colors.red,
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: 80,
                        child: TextField(
                          enabled: false,
                          controller: myController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            // hintText:false
                          ),
                        ),
                      ),
                      // Text('${nro.toString()}'),
                      Container(
                        width: 50,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          onPressed: () {
                            setState(() {
                              if (nro == 1) {
                                nro = 1;
                              } else {
                                nro--;
                              }
                              myController.text = "$nro";
                              print(nro);
                            });
                          },
                          elevation: 0.0,
                          color: Colors.red,
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: (() async {
                    // mainshowDialog();
                    await pe.actualizarItemsPedido(id, nro);
                    final data = await _getItems(proData);
                    if (data.length != 0) {
                      Navigator.of(context).pop();
                    }
                  }),
                  child: Align(widthFactor: 2, child: Text('Aceptar'))),
              FlatButton(
                  onPressed: (() => Navigator.of(context).pop()),
                  child: Align(widthFactor: 2, child: Text('Cancelar'))),
            ],
          );
        });
  }

  Widget _crearvist2(BuildContext context) {
    MediaQueryData query;
    query = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      color: Color.fromRGBO(247, 247, 249, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              'Producto',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(162, 113, 101, 1)),
            ),
            width: query.size.width / 4,
          ),
          Container(
            child: Text(
              'Cantidad',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(162, 113, 101, 1)),
            ),
            width: query.size.width / 5,
          ),
          Container(
            child: Text(
              'Precio',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(162, 113, 101, 1)),
            ),
            width: query.size.width / 7,
          ),
          Container(
            child: Text(
              'Total',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(162, 113, 101, 1)),
            ),
            width: query.size.width / 5,
          )
        ],
      ),
    );
  }
}
