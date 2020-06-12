
import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:delipuerta/src/services/productos_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  var f = new NumberFormat("###.0#", "en_US");
  ProductoService proser = new ProductoService();

  double precioTotal = double.parse((0.00).toStringAsFixed(2));

  List<int> conteo = new List(100);
  List<dynamic> carrito;
  final carritoT = new List();
  int idEvento;

  @override
  Widget build(BuildContext context) {
    final EventoModel proData = ModalRoute.of(context).settings.arguments;
    idEvento=proData.eventoId;
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Stack(
        children: <Widget>[_crearlista(proData), boton()],
      ),
    );
  }

  Widget _crearlista(EventoModel eve) {
    return FutureBuilder(
      future: proser.mostrarProducto(eve.eventoId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          final rendici = snapshot.data;
          carrito = new List();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.2),
            ),
            itemCount: rendici.length,
            itemBuilder: (context, i) {
              carrito.add(rendici[i]);
              return _crearvista(context, rendici[i], i);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  boton() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () {
                if (precioTotal > 0) {
                  List<dynamic> temp = new List();
                  carritoT.clear();
                  for (int x = 0; x < carrito.length; x++) {
                    if (conteo[x] > 0) {
                      carritoT.add(conteo[x]);
                      temp.add(carrito[x]);
                    }
                  }
                  carritoT.add(temp);
                  carritoT.add(precioTotal);
                  carritoT.add(idEvento);

                  Navigator.pushNamed(context, 'carrito', arguments: carritoT);
                }
              },
              child: Text('Añadir al carrito  (S/ $precioTotal)'),
              color: Color.fromRGBO(149, 72, 31,1),
            )),
      ),
    );
  }

  Widget _crearBotones(ProductoModel rendi, int mostrar, int i) {
    if (conteo[i] == null) {
      conteo[i] = 0;
    }

    double preciopro = 0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                heroTag: "btnAñadir $i",
                child: Icon(Icons.remove),
                backgroundColor: Colors.red,
                onPressed: () {
                  if (conteo[i] > 0) {
                    preciopro =
                        double.parse((rendi.productoCosto).toStringAsFixed(2));

                    setState(() {
                      conteo[i] -= 1;
                      precioTotal = double.parse(
                          (precioTotal - preciopro).toStringAsFixed(2));
                      print('$precioTotal  ${conteo[i]}  $preciopro');
                    });
                  }
                },
              ),
            ),
            Text('${conteo[i]}'),
            Container(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                heroTag: "btnRestar $i",
                child: Icon(Icons.add),
                backgroundColor: Colors.red,
                onPressed: () {
                  preciopro =
                      double.parse((rendi.productoCosto).toStringAsFixed(2));

                  setState(() {
                    conteo[i] += 1;
                    precioTotal = double.parse(
                        (preciopro + precioTotal).toStringAsFixed(2));
                    if (precioTotal < 0) {
                      precioTotal = 0.00;
                    }
                    print('$precioTotal  ${conteo[i]}  $preciopro');
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _crearvista(BuildContext context, ProductoModel rendi, int i) {
    int mostrar = 0;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            child: FadeInImage(placeholder: AssetImage('assets/no-image.png'),
                        image: NetworkImage(rendi.productoImagen),
                        height: 100,
                     //  fit: BoxFit.fill,
                        
                   ),
            
            
            
       //     Image.network(rendi.productoImagen,fit: BoxFit.cover,),
            
          ),
          Text(
            rendi.productoNombre,
            style: TextStyle(fontWeight: FontWeight.w700),
            textAlign: TextAlign.start,
          ),
          Text('S/ ${rendi.productoCosto}'),
          Container(child: Text(rendi.productoDescripcion),height: 50,),
          _crearBotones(rendi, mostrar, i)
        ],
      ),
    );
  }
  
}
