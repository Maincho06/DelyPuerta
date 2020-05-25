import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/models/evento_model.dart';
import 'package:delipuerta/src/models/provider_model.dart';
import 'package:delipuerta/src/services/evento_services.dart';
import 'package:delipuerta/src/util/notificaciones_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'crearProducto.dart';

class CrearEventoPage extends StatefulWidget {
  CrearEventoPage({Key key}) : super(key: key);

  @override
  _CrearEventoPageState createState() => _CrearEventoPageState();
}

class _CrearEventoPageState extends State<CrearEventoPage> {
  EventoModel eventoModel = new EventoModel();
  List<ProductoModel> listaProductoModel = [];
  final format = DateFormat("dd-MM-yyyy HH:mm");
  List<DataRow> _rowList = [];
  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductoProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _camposEvento(productoProvider)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addRow
      ),
      persistentFooterButtons: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () async {
                int eventoId = await eventoServices.registrarEvento(eventoModel);
                eventoServices.insertarDetalle(listaProductoModel,eventoId);
              },
              child: Text('Crear Evento'),
              color: Color(0xfff7892b),
            )
          ),
        ),
      ],
    );
  }

  void _addRow() async {
    ProductoModel producto = ProductoModel();
    await alertaItemsProducto(producto);
    if(producto.productoNombre != null) {
      setState(() {
        _rowList.add(DataRow(cells: <DataCell>[
        DataCell(Text(producto.productoNombre, style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(producto.productoDescripcion, style: TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(producto.productoCosto.toString(), style: TextStyle(fontWeight: FontWeight.bold))),
      ]));  
      });
    }
  }

  Future<void> alertaItemsProducto(ProductoModel producto) {
    var name = TextEditingController();
    var descripcion = TextEditingController();
    var costo = TextEditingController();

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.all(
            Radius.circular(10.0))
          ),
          title: Text('Agregar Producto'),
          content: Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;
              // return Container(
              //   height: height - height/3,
              //   width: width,
              //   child: SingleChildScrollView(
              //     child: ListBody(
              //       children: <Widget>[
              //         _entryField(
              //           'Nombre',
              //           TextField(
              //             controller: name,
              //             decoration: InputDecoration(
              //             border: InputBorder.none,
              //             fillColor: Color(0xfff3f3f4),
              //             filled: true)
              //           )
              //         ),
              //         _entryField(
              //           'Descripcion',
              //           TextField(
              //             controller: descripcion,
              //             decoration: InputDecoration(
              //             border: InputBorder.none,
              //             fillColor: Color(0xfff3f3f4),
              //             filled: true)
              //           )
              //         ),
              //         _entryField(
              //           'Precio',
              //           TextField(
              //             controller: costo,
              //             decoration: InputDecoration(
              //             border: InputBorder.none,
              //             fillColor: Color(0xfff3f3f4),
              //             filled: true),
              //             keyboardType: TextInputType.numberWithOptions(decimal: true),
              //           )
                        
              //         ),
              //       ],
              //     ),
              //   ),
              // );
              return Container(
                height: height - height/3,
                width: width,
                child: CrearProducto(evento: true,)
              );
            },
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                if( name.text != '' && name.text.length >= 4 && 
                 descripcion.text != '' && descripcion.text.length >= 4 &&
                 costo.text != '' && costo.text != '0')
                {
                  if ( double.parse(costo.text) >= 0) {
                    producto.productoNombre = name.text;
                    producto.productoDescripcion = descripcion.text;
                    producto.productoCosto = double.parse(costo.text);
                    listaProductoModel.add(producto);
                    Navigator.of(context).pop();
                  } else {
                    mostraralerta(context, 'Error', 'Revise los datos por favor');
                  }
                } else {
                  mostraralerta(context, 'Error', 'La cagada');
                }
              },
              child: Text('Agregar')
            ),
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  

  Widget _entryField(String title, Widget form, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          form
        ],
      ),
    );
  }

  _camposEvento(ProductoProvider productoProvider) {
    List<Widget> lista = [];
    
    final organizador = _entryField(
      'Organizador',
      TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true),
        onChanged: (value) => eventoModel.eventoOrganizador = value,
      )
    );
    final nombre = _entryField(
      'Nombre del Evento',
      TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true),
        onChanged: (value) => eventoModel.eventoNombre = value,
      )
    );
    final descripcion = _entryField(
      'Descripcion',
      TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true),
        onChanged: (value) => eventoModel.eventoDescripcion = value,
      )
    );
    final fecha = _entryField(
      'Fecha y Hora',
      DateTimeField(
        format: format,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Color(0xfff3f3f4),
          filled: true
        ),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            initialDate: currentValue ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100)
          );
          if ( date != null ) {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        onChanged: (value) => eventoModel.eventoFecha = value,
      )
    );
    final table = DataTable(
      columns: [
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Descripcion')),
        DataColumn(label: Text('Costo')),
      ],
      rows: _rowList,
    );

    // final pruebaWidget =  productoProvider.prueba != null ? Text(productoProvider.prueba) : Text('Veamos');
    lista..add(organizador)
         ..add(nombre)
         ..add(descripcion)
         ..add(fecha)
        //  ..add(pruebaWidget)
         ..add(table);
    return lista;
  }
}