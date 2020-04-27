import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:delipuerta/src/models/detalle_producto_model.dart';
import 'package:delipuerta/src/util/notificaciones_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrearEventoPage extends StatefulWidget {
  CrearEventoPage({Key key}) : super(key: key);

  @override
  _CrearEventoPageState createState() => _CrearEventoPageState();
}

class _CrearEventoPageState extends State<CrearEventoPage> {
  final format = DateFormat("dd-MM-yyyy HH:mm");
  List<DataRow> _rowList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: _camposEvento()
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addRow
      )
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
              return Container(
                height: height - height/3,
                width: width,
                child: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      _entryField(
                        'Nombre',
                        TextField(
                          controller: name,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true)
                        )
                      ),
                      _entryField(
                        'Descripcion',
                        TextField(
                          controller: descripcion,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true)
                        )
                      ),
                      _entryField(
                        'Precio',
                        TextField(
                          controller: costo,
                          decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xfff3f3f4),
                          filled: true),
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                        )
                        
                      ),
                    ],
                  ),
                ),
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
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[

          //       _entryField(
          //         'Nombre',
          //         TextField(
          //           controller: name,
          //           decoration: InputDecoration(
          //           border: InputBorder.none,
          //           fillColor: Color(0xfff3f3f4),
          //           filled: true)
          //         )
          //       ),
          //       _entryField(
          //         'Descripcion',
          //         TextField(
          //           controller: descripcion,
          //           decoration: InputDecoration(
          //           border: InputBorder.none,
          //           fillColor: Color(0xfff3f3f4),
          //           filled: true)
          //         )
          //       ),
          //       _entryField(
          //         'Precio',
          //         TextField(
          //           controller: costo,
          //           decoration: InputDecoration(
          //           border: InputBorder.none,
          //           fillColor: Color(0xfff3f3f4),
          //           filled: true)
          //         )
          //       ),
          //     ],
          //   ),
          // ),
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

  _camposEvento() {
    List<Widget> lista = [];
    
    final organizador = _entryField(
      'Organizador',
      TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true)
      )
    );
    final nombre = _entryField(
      'Nombre del Evento',
      TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true)
      )
    );
    final descripcion = _entryField(
      'Descripcion',
      TextField(
        decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Color(0xfff3f3f4),
        filled: true)
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
    lista..add(organizador)
         ..add(nombre)
         ..add(descripcion)
         ..add(fecha)
         ..add(table);
    return lista;
  }
}