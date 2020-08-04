import 'package:delipuerta/src/models/pedido_model.dart';
import 'package:delipuerta/src/services/pedidos.dart';
import 'package:delipuerta/src/share_prefs/preferencias.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MisPedidosPage extends StatefulWidget {
  @override
  _MisPedidosPageState createState() => _MisPedidosPageState();
}

class _MisPedidosPageState extends State<MisPedidosPage> {
  var _isFetching=false;
  var _isloading=true;
@override
void initState() { 
  super.initState();
 _getpedidos(3);
}
PerdidosServices pe = new PerdidosServices();

 PreferenciasUsuario _prefs = new PreferenciasUsuario();
String dropdownValue = 'Falta Pagar';
int _estado=1;
List<dynamic> _pedidos;
  @override
  Widget build(BuildContext context) {
  
  
    print(_prefs.id);
    return _isloading ? Center(
       child: CircularProgressIndicator(
         valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(149, 72, 31,1)),
        
          ),
     ):
    
    Scaffold(
    
      body: _lista(3),
    );
  }
_getpedidos(int estado)async{
 _isloading=true;

 _pedidos=await pe.mostrarPedidos(_prefs.usuarioId,estado);
 print('hola $_pedidos');
 setState(() {
   
 });
 
_isloading=false;
 
 

 
}

  _lista(int estado){
    return Stack(fit: StackFit.expand,
        children: <Widget>[
          Column(
      children: <Widget>[
        Expanded(
            flex: 2,
            child: Container(child:  _combobox(),alignment: Alignment.bottomCenter,) 
            ),
        Expanded(
          flex: 8,
          child: Container(
            child:  _creatLista(estado),
           
              
            
          ),
        )
      ],
    )
         
           

        ,_isFetching? Positioned.fill(child: Container(
     color: Colors.black45,
     child: Center(
       child: CircularProgressIndicator(
         valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(149, 72, 31,1)),
        
          ),
     ),
   )):Container(),
        ],
      );
  }
_combobox(){
    return DropdownButton<String>(
    value: dropdownValue,
    icon: Icon(Icons.arrow_downward),
    iconSize: 24,
    elevation: 16,
    style: TextStyle(
      color: Colors.deepPurple
    ),
    underline: Container(
      height: 2,
      color: Colors.deepPurpleAccent,
    ),
    onChanged: (String newValue) {
       
      setState(() {
        dropdownValue = newValue;
        
      });
       if(newValue=='Por Recoger'){
       
         setState(() {
           
           _getpedidos(1);
           
         });
        }
        else if(newValue=='Entregado'){
        
         setState(() {
           _getpedidos(2);
            
         });
        }
      else if(newValue=='Falta Pagar'){
     
         setState(() {
           _getpedidos(3);
            
         });
        }
         else if(newValue=='Pagado'){
       
         setState(() {
            _getpedidos(4);
           
         });
        }
         else if(newValue=='Cancelado'){
        
         setState(() {
           _getpedidos(5);
            
           
         });
        }
    },
    items: <String>['Por Recoger', 'Entregado', 'Falta Pagar', 'Pagado','Cancelado']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
      .toList(),
  );
}
  _creatLista(int estado){
    
      

       return ListView.builder(
         
         itemCount: _pedidos.length,
         itemBuilder: (context, i){

           return _crearvista(context, _pedidos[i]);

         },);
     
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
            leading: Icon(Icons.assignment, color: Color.fromRGBO(149, 72, 31,1)),
            title: Text('${rendi.eventoNombre}'),
            subtitle: Text(fecha),
            contentPadding: EdgeInsets.only(left: 20.0 ,bottom: 7.0, right: 30.0),
          )
        ),
        onTap: () async{
             if(_isFetching) return;
            
                      setState(() {
                        _isFetching=true;
                      });
          final empresa=await pe.mostrarEmpresaPorPedido(rendi.eventoId);
          final total= await pe.retornartotal(rendi.pedidoId);
          if(empresa!='error'&& total!='error'){
             print('Nos Vamos ${rendi.estadoPedidoId}');
             
             rendi.empresaRuc=empresa[0]["empresaRuc"];
             rendi.empresaRazonSocial=empresa[0]["empresaRazonSocial"];
             rendi.eventoNombre=empresa[0]["eventoNombre"];
            rendi.montoTotal=total;
           //  print(empresa[0]);
           // print(empresa[0]["empresaRuc"]);
            print(total);
              setState(() {
                    _isFetching=false;
            });
             Navigator.pushNamed(context, 'items',arguments: rendi);
          }
         
        },
      ),
    ),

          ]

    );

  }
}