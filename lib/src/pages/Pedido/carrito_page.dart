
import 'package:delipuerta/src/services/pedido_service.dart';
import 'package:flutter/material.dart';
import 'package:delipuerta/src/models/carrito_model.dart';


import '../../models/detalle_producto_model.dart';

class CarritoPage extends StatefulWidget {
  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
 List<ProductoModel> soloProductos;
 List<int> cantidadP;

  @override
  Widget build(BuildContext context) {
    final List productos = ModalRoute.of(context).settings.arguments;
 
    soloProductos= new List();
    cantidadP= new List();
    return Scaffold(
      appBar: AppBar(title: Text("Detalle de Carrito")),
      body: Stack(children: <Widget>[
        ListView.builder(
            itemCount: (productos.length - 2),
            itemBuilder: (context, i) {
              soloProductos.add(productos[productos.length - 2][i]);
              cantidadP.add(productos[i]);
              return _crearFilasProducto(context, productos[productos.length - 2][i], i, productos[i]);
            }),
        boton(productos[productos.length - 1])
      ]),
    );
  }

  Widget _crearFilasProducto(
      BuildContext context, ProductoModel product, int i, int cantidad) {
    double subtotal = cantidad * product.productoCosto;

    return Center(
        child: Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
                width: 100,
                height: 120,
                child: Image.network(product.productoImagen)),
            title: Text('${product.productoNombre}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text('${product.productoDescripcion} \n\n Cant: $cantidad'),
            trailing: Text('S/$subtotal', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    ));
  }

  Widget boton(double cant) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
                onPressed: () async{
                  int pedidoId = await pedidoServices.registrarPedido(soloProductos[0].eventoId);
                  pedidoServices.insertarItems(soloProductos,cantidadP,pedidoId);

                  Navigator.pushNamed(context, 'home');
                },
                child: Text(
                  'Total a pagar (S/ $cant)',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xfff7892b),
            )
          ),
        ));
  }
}
