import 'package:delipuerta/src/models/items_model.dart';
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

  @override
  double total = 0;

  final myController = TextEditingController();

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
    void initState() {
      if (proData.estadoPedidoId == 3) {
        _pagar = true;
      }
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${proData.usuarioNombre}'),
        actions: [_mostrarbotones(proData.estadoPedidoId, proData.pedidoId)],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: QrImage(
                  data: "${proData.empresaRuc}|${proData.eventoId}",
                  version: QrVersions.auto,
                  size: 100.0,
                ),
              ),
              mostrarvento("Organizador", proData.empresaRazonSocial),
              mostrarvento("Fecha de entrega", fecha),
              mostrarvento("Hora de entraga", hora),
              mostrarvento("Cliente",
                  "${proData.usuarioNombre} ${proData.usuarioApellido}"),
              SizedBox(
                height: 10,
              ),
              _crearvist2(context),

              Container(
                margin: new EdgeInsets.fromLTRB(
                    query.size.width * 0.09,
                    query.size.height / 2.8,
                    query.size.width * 0.09,
                    query.size.height / 12.0),
                // color: Colors.red,

                child: mostrarvento(
                    'Total', 'S/ ${(proData.montoTotal).toStringAsFixed(2)}'),
              ),

              //_crearvista(context, proData),
            ],
          ),
          Container(
            padding: new EdgeInsets.fromLTRB(
                query.size.width * 0.09,
                query.size.width / 1.6,
                query.size.width * 0.09,
                query.size.width / 1.7),

            //color: Colors.red,
            child: _creatLista(proData),
          ),
        ],
      ),
    );
  }

  _mostrarbotones(int rendi, int pedido) {
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
                    )));
          });
    } else {
      return Container();
    }
  }

  mostrarvento(final comun, final propio) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Container(child: Text('$comun: ')), Text('$propio')],
    );
  }

  _creatLista(PedidosModel rendi) {
    return FutureBuilder(
      future: pe.mostrarItems(rendi.pedidoId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final rendici = snapshot.data;

          return ListView.builder(
            reverse: true,
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

    MediaQueryData query;
    query = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        print(rendi.cantidad);
        // print(rendi.cantidad);
        mainshowDialogAddItems(rendi.itemId, rendi.cantidad);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              '${rendi.productoNombre}',
              textAlign: TextAlign.start,
            ),
            width: query.size.width / 3.5,
          ),
          Container(
            child: Text('${rendi.cantidad}', textAlign: TextAlign.start),
            width: query.size.width / 11,
          ),
          Container(
            child: Text(
              'S/ ${rendi.productoCosto}',
              textAlign: TextAlign.start,
            ),
            width: query.size.width / 5,
          ),
          Container(
            child: Text(
              'S/ $precioTotal',
              textAlign: TextAlign.start,
            ),
            width: query.size.width / 5.5,
          )
        ],
      ),
    );
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
                    Navigator.of(context).pop();
                    // CircularProgressIndicator();
                    await pe.actualizarItemsPedido(id, nro);
                    // print('------------');
                    // print(info);
                    // if (info != null) {
                    //   Navigator.of(context).pop();
                    // }
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            'Producto',
            textAlign: TextAlign.start,
          ),
          width: query.size.width / 4,
        ),
        Container(
          child: Text('Cantidad', textAlign: TextAlign.start),
          width: query.size.width / 5,
        ),
        Container(
          child: Text(
            'Costo',
            textAlign: TextAlign.start,
          ),
          width: query.size.width / 7,
        ),
        Container(
          child: Text(
            'CostoTotal',
            textAlign: TextAlign.start,
          ),
          width: query.size.width / 5,
        )
      ],
    );
  }
}
