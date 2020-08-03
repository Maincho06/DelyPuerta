import 'dart:async';
import 'dart:async' as prefix0;

import 'package:rxdart/rxdart.dart';
import 'package:delipuerta/src/bloc/validators.dart';


class RegistroBloc with Validartors{

  final _dniController           = BehaviorSubject<String>();
  final _nombreController        = BehaviorSubject<String>();
  final _apellidoController      = BehaviorSubject<String>();
  final _condominioController    = BehaviorSubject<String>();
  final _edificioController      = BehaviorSubject<String>();
  final _departamentoController  = BehaviorSubject<String>();
  final _telefonoController      = BehaviorSubject<String>();
  final _correoController        = BehaviorSubject<String>();
  final _contrasenaController    = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  prefix0.Stream<String> get dniStream => _dniController.stream.transform(validarDni);
  prefix0.Stream<String> get nombreStream => _nombreController.stream;
  prefix0.Stream<String> get apellidoStream => _apellidoController.stream;
  prefix0.Stream<String> get departamentoStream => _departamentoController.stream;
  prefix0.Stream<String> get telefonoStream => _telefonoController.transform(validartelefono);
  prefix0.Stream<String> get correoStream => _correoController.stream.transform(validarCorreo);
  prefix0.Stream<String> get contrasenaStream => _contrasenaController.stream.transform(validarContrasena);

  prefix0.Stream<bool> get formValidStream =>
    CombineLatestStream.combine7(dniStream, nombreStream, apellidoStream, departamentoStream,telefonoStream, correoStream, contrasenaStream, (a, b, c, d, e, f,g) => true);

  // insertar valores al Stream
  Function(String) get changeDni => _dniController.add;
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeApellido => _apellidoController.sink.add;
  Function(String) get changeDepartamento => _departamentoController.sink.add;
  Function(String) get changeTelefono => _telefonoController.sink.add;
  Function(String) get changeCorreo => _correoController.sink.add;
  Function(String) get changeContrasena => _contrasenaController.sink.add;

  // obtener el ultimo valor ingresado a
  String get dni => _dniController.value;
  String get nombre => _nombreController.value;
  String get apellido => _apellidoController.value;
  String get departamento => _departamentoController.value;
  String get telefono => _telefonoController.value;
  String get correo => _correoController.value;
  String get contrasena => _contrasenaController.value;
  dispose() {
    _dniController?.close();
    _nombreController?.close();
    _apellidoController?.close();
    _departamentoController?.close();
    _telefonoController?.close();
    _correoController?.close();
    _contrasenaController?.close();
  }
}