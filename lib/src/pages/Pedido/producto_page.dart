import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:delipuerta/src/services/productos_services.dart';
import 'package:flutter/material.dart';

class ProductoPage extends StatefulWidget {
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  ProductoService proser=new ProductoService();

  double precioTotal = 0;
 
  List<int> conteo=new List(100);

  @override
  Widget build(BuildContext context) {
    final EventoModel proData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),

        
      ),
      body: Stack(
        children: <Widget>[
          _crearlista(proData),
          boton()
        ],
      ),
    );
  }

    Widget _crearlista(EventoModel eve){
 return FutureBuilder(
   future: proser.mostrarProducto(eve.eventoId),

   builder: (BuildContext context, AsyncSnapshot snapshot) {
     if(snapshot.hasData ){
       final rendici= snapshot.data;

       return GridView.builder(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0,childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height/1.2),),
         itemCount: rendici.length,
         itemBuilder: (context, i){

           return _crearvista(context, rendici[i],i);

         },);
     }else{
       return Center( child: CircularProgressIndicator());
     }
   },


 );
}

boton(){
  return Container(
    padding: const EdgeInsets.all(20.0),
   
    alignment: Alignment.bottomCenter,
    child: Padding(
      
            padding: const EdgeInsets.only(bottom: 10.0),
            child: SizedBox(
              
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                
                onPressed: () {
                if(precioTotal>0){

                }
                },
                child: Text('Añadir al carrito  (\$ $precioTotal)'),
                color: Color(0xfff7892b),
              )
            ),
          ),
  );
}



 Widget _crearBotones(ProductoModel rendi,int mostrar,int i) {

   if(conteo[i]==null){
 conteo[i]=0;
   }
  
  
   double preciopro=0;
   
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(),
        
        child: Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "btnAñadir",
              child: Icon(Icons.remove),
              backgroundColor: Colors.red,
              
              onPressed: (){
                
                 if(conteo[i]>0){
                  
              preciopro=rendi.productoCosto;
              
               
              setState(() {
                 conteo[i]-=1;
                 precioTotal-=preciopro;
                  print('$precioTotal  ${conteo[i]}  $preciopro');
              });
                 }

                
               
              },
              
            ),
            
            
          Text('${conteo[i]}'),
            FloatingActionButton(
              heroTag: "btnRestar",
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              onPressed: (){
              
                  preciopro=rendi.productoCosto;
          
                
               
              setState(() {
                conteo[i]+=1;
                 precioTotal+=preciopro;
                  print('$precioTotal  ${conteo[i]}  $preciopro');
              });
               
              
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _crearvista(BuildContext context,ProductoModel rendi,int i){

 int mostrar=0;
    return Container(
     
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            
            width: 100,
              padding: const EdgeInsets.all(8),
            child: Image.network(rendi.productoImagen),
          )
          ,
     
           
              Text(rendi.productoNombre,style: TextStyle( fontWeight: FontWeight.w700),textAlign: TextAlign.start,),
               Text('\$ ${rendi.productoCosto}'),
              Text(rendi.productoDescripcion),
           _crearBotones(rendi,mostrar,i)
        
        ],
      ),
      
    );

  }
}