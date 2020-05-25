import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:delipuerta/src/models/producto_model.dart';
import 'package:delipuerta/src/pages/Producto/detallesProducto.dart';
import 'package:flutter/material.dart';

class CrearProducto extends StatefulWidget {
  const CrearProducto({Key key,this.evento}) : super(key: key);
  final bool evento;

  @override
  _CrearProductoState createState() => _CrearProductoState();
}

class _CrearProductoState extends State<CrearProducto> {
  List<ProductoFirebase> productos = [];
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('Tower');
  StreamSubscription<Event> onAddedSubs;
  StreamSubscription<Event> onChangeSubs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onAddedSubs = reference.onChildAdded.listen(onEntryAdded);
    onChangeSubs = reference.onChildChanged.listen(onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    // final productoProvider = Provider.of<ProductoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Prueba Firebase'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: productos.length,
        itemBuilder: (BuildContext context, int index){
          return Dismissible(
            key: ObjectKey(productos[index]),
            child:  CardProducto(producto: productos[index],context: context,),
            onDismissed: (direction) {
              print(direction);
              // productoProvider.prueba = productos[index].nombre;
            },
          );
        },
      ),
      floatingActionButton: widget.evento ? null : FloatingActionButton(
        onPressed: () {
          print('Funciona');
          Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormProducto(title: 'Editar Producto')));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  onEntryAdded(Event event) {
    setState(() {
      productos.add(ProductoFirebase.getProducto(event.snapshot));
    });
  }

  onEntryChanged(Event event) {
    ProductoFirebase oldEntry = productos.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      productos[productos.indexOf(oldEntry)]=ProductoFirebase.getProducto(event.snapshot);
    });
  }

  void disponse() {
    onAddedSubs.cancel();
    onChangeSubs.cancel();
  }
}

class CardProducto extends StatelessWidget {
  const CardProducto({Key key, this.producto, this.context}) : super(key: key);
  final ProductoFirebase producto;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Funciona');
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormProducto(title: 'Editar Producto',producto: producto)));
        
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 144.0,
              width: 500.0,
              color: Colors.white,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/default.png',
                image: producto.imagen,
                height: 144.0,
                width: 160.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Icon(Icons.grade),
                  ),
                  Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Text("${producto.nombre}  S/ ${producto.precio}", style: TextStyle(fontSize: 18.0)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}