import 'package:delipuerta/src/models/items_model.dart';
import 'package:delipuerta/src/models/pedido_model.dart';
import 'package:delipuerta/src/services/pedidos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ItemsPage extends StatefulWidget {
  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage>  {
  PerdidosServices pe = new PerdidosServices();
  
 

  double total=0;



  @override
  Widget build(BuildContext context) {
         MediaQueryData query;
   query=MediaQuery.of(context);
        final PedidosModel proData = ModalRoute.of(context).settings.arguments;
         String fecha= DateFormat('yyyy-MM-dd').format(proData.pedidoFecha);
         String hora = DateFormat('hh:mm').format(proData.pedidoFecha);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${proData.usuarioNombre}'),
        
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
              mostrarvento("Cliente", "${proData.usuarioNombre} ${proData.usuarioApellido}"),
              SizedBox(
                height: 10,
              ),
               _crearvist2(context),
              
              
              Container(
               margin: new EdgeInsets.fromLTRB(query.size.width*0.09, query.size.height/2.8, query.size.width*0.09, query.size.height/12.0),
               // color: Colors.red,
               

                child: mostrarvento('Total', 'S/ ${proData.montoTotal}'),
                ),
        
              //_crearvista(context, proData),
           
            ],
          ),
           
          Container(
                  padding: new EdgeInsets.fromLTRB(query.size.width*0.09, query.size.width/1.6, query.size.width*0.09, query.size.width/1.7),

              //color: Colors.red,            
            child:  _creatLista(proData),
          ),
         
          
           
        
          
         
        ],
      ),
    );
  }

  mostrarvento(final comun,final propio){
    return   Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                    
                      child: Text('$comun: ')
                      ),
                    Text('$propio')
                  ],
                );
  }

 _creatLista(PedidosModel rendi){
    return FutureBuilder(
      future: pe.mostrarItems(rendi.pedidoId),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
     if(snapshot.hasData ){
       final rendici= snapshot.data;

       return ListView.builder(
             reverse: true,
             itemCount: rendici.length,
             itemBuilder: (context, i){
     
               
               return _crearvista(context, rendici[i]);
                     
                
               
             },);
            
        
     }else{
       return Center( child: CircularProgressIndicator());
     }
   
   },
    );
  }



 Widget _crearvista(BuildContext context, ItemsModel rendi )  { 
   double precioTotal;
   
   
   precioTotal= double.parse((rendi.productoCosto *rendi.cantidad).toStringAsFixed(2));
  
  total=total+precioTotal;
  
    
  
   MediaQueryData query;
   query=MediaQuery.of(context);
    return    Row(
      
        mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                
                  Container(child: Text('${rendi.productoNombre}',textAlign: TextAlign.start,),width: query.size.width/3.5,),
                 
                  Container(child: Text('${rendi.cantidad}',textAlign: TextAlign.start),width: query.size.width/11,),
                 
                  Container(child: Text('S/ ${rendi.productoCosto}',textAlign: TextAlign.start,),width: query.size.width/5,),

                 Container(child: Text('S/ $precioTotal',textAlign: TextAlign.start,),width: query.size.width/5.5,)
                  
              ],
            );
            
    
        
     
  }

Widget _crearvist2(BuildContext context){
 
   MediaQueryData query;
   query=MediaQuery.of(context);
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
              Container(child: Text('Producto',textAlign: TextAlign.start,),width: query.size.width/4,),
             
              Container(child: Text('Cantidad',textAlign: TextAlign.start),width: query.size.width/5,),
             
              Container(child: Text('Costo',textAlign: TextAlign.start,),width: query.size.width/7,),

             Container(child: Text('CostoTotal',textAlign: TextAlign.start,),width: query.size.width/5,)
              
          ],
        );
        
     
  }
}