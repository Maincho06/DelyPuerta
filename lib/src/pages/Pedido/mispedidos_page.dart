import 'package:delipuerta/src/models/pedido_model.dart';
import 'package:delipuerta/src/services/pedidos.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MisPedidosPage extends StatelessWidget {
 
PerdidosServices pe = new PerdidosServices();
 PreferenciasUsuario _prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    print(_prefs.id);
    return Scaffold(
    
      body: Stack(
        children: <Widget>[
          _creatLista(),
        ],
      ),
    );
  }
  _creatLista(){
    return FutureBuilder(
      future: pe.mostrarPedidos(_prefs.usuarioId,1)  ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
     if(snapshot.hasData ){
       final rendici= snapshot.data;

       return ListView.builder(
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
  

    Widget _crearvista(BuildContext context,PedidosModel rendi){

  String fecha= DateFormat('yyyy-MM-dd hh:mm').format(rendi.pedidoFecha);
    return Column(
            
    children:<Widget>[ Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        child: Card(
          elevation: 5.0,
          child: ListTile(
            leading: Icon(Icons.assignment, color: Color(0xffe46b10)),
            title: Text('${rendi.pedidoDescripcion}'),
            subtitle: Text(fecha),
            contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
          )
        ),
        onTap: () async{
          final empresa=await pe.mostrarEmpresaPorPedido(rendi.eventoId);
          final total= await pe.retornartotal(rendi.pedidoId);
          if(empresa!='error'&& total!='error'){
             print('Nos Vamos');
             rendi.empresaRuc=empresa[0]["empresaRuc"];
             rendi.empresaRazonSocial=empresa[0]["empresaRazonSocial"];
             rendi.eventoNombre=empresa[0]["eventoNombre"];
            rendi.montoTotal=total;
           //  print(empresa[0]);
           // print(empresa[0]["empresaRuc"]);
            print(total);
             Navigator.pushNamed(context, 'items',arguments: rendi);
          }
         
        },
      ),
    ),

          ]

    );

  }

}