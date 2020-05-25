import 'dart:io';

import 'package:delipuerta/src/services/productos_services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:delipuerta/src/models/producto_model.dart';
import 'package:delipuerta/src/util/form_util.dart' as utilForm;

class FormProducto extends StatefulWidget {
  FormProducto({Key key,this.title, this.producto}) : super(key: key);
  final title;
  ProductoFirebase producto;
  @override
  _FormProductoState createState() => _FormProductoState();
}

class _FormProductoState extends State<FormProducto> {
  var nameController = TextEditingController();
  var precioController = TextEditingController();
  File galleryFile;
  String urlImage;

  @override
  void initState() { 
    super.initState();
    if( widget.producto != null ) {
      nameController.text = widget.producto.nombre;
      precioController.text = widget.producto.precio.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? widget.title : "Agregar Producto"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: formProducto(),
      ),
      persistentFooterButtons: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: sendData,
              child: Text('Guardar Producto'),
              color: Color(0xfff7892b),
            )
          ),
        ),
      ],
    );
  }

  Widget formProducto() {
    return Column(
      children: <Widget>[
        utilForm.entryField(
          'Nombre',
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: '¿Cuál es el nombre del producto?',
              labelText: 'Nombre',
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
            ),
          ),
        ),
        utilForm.entryField(
          'Precio',
          TextFormField(
            controller: precioController,
            decoration: InputDecoration(
              hintText: '¿Cuál es el precio del producto?',
              labelText: 'Precio',
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        RaisedButton(
          child: Text('Seleccionada una imagen'),
          onPressed: imageSelectorGallery,
        ),
        SizedBox(
          child: showImage(),
        ),
        
      ],
    );
  }

  imageSelectorGallery() async{
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800.0,
      maxWidth: 700.0
    );
    setState(() {
      
    });
  }

  showImage() {
    if(galleryFile != null) {
      return Image.file(galleryFile);
    } else {
      if(widget.producto != null) {
        return FadeInImage.assetNetwork(
          placeholder: "img/default.png",
          image: widget.producto.imagen,
          height: 800.0,
          width: 700.0,
        );
      } else {
        return Text('Imagen no seleccionada');
      }
    }
  }

  void sendData() {
    saveFirebase(nameController.text).then((_){
      DatabaseReference db = FirebaseDatabase.instance.reference().child('Tower');
      if (widget.producto != null) {
        db.child(widget.producto.key).set(getProducto()).then((_){
          Navigator.pop(context);
        }); 
      } else {
        db.child('Producto4').set(getProducto()).then((value){
          Navigator.pop(context);
        });
        // db.push().set(getProducto()).then((_){
        //   Navigator.pop(context);
        // });
      }
    });
  }

  Map<String,dynamic> getProducto() {
    Map<String,dynamic> data = new Map();
    data['nombre'] = nameController.text;
    data['precio'] = double.parse(precioController.text);
    if(widget.producto != null && galleryFile == null) {
      data['imagen'] = widget.producto.imagen;
    } else {
      data['imagen'] = urlImage!=null?urlImage:"";
    }
    return data;
  }

  Future<void> saveFirebase (String imageId) async {
    if (galleryFile != null) {
      StorageReference reference = FirebaseStorage.instance.ref().child('Tower').child(imageId);
      StorageUploadTask uploadTask = reference.putFile(galleryFile);
      StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
      urlImage = (await downloadUrl.ref.getDownloadURL());
      print(urlImage);
    }
  }
}