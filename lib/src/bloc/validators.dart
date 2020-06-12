import 'dart:async';

class Validartors {
  final validarCorreo = StreamTransformer<String, String>.fromHandlers(
      handleData: (correo, sink) {
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(correo)) {
      sink.add(correo);
    } else {
      sink.addError('Correo Electronico invalido');
    }
  });

  final validarContrasena = StreamTransformer<String, String>.fromHandlers(
      handleData: (contrasena, sink) {
    if (contrasena.length >= 6) {
      sink.add(contrasena);
    } else {
      sink.addError('Mayor a 6 caracteres');
    }
  });

  final validarDni =
      StreamTransformer<String, String>.fromHandlers(handleData: (dni, sink) {
    int cont = 0;
    List<String> separado = dni.split("");
    if (dni.length == 8) {
      for (int i = 0; i < dni.length; i++) {
        if (separado[i] == "0" ||
            separado[i] == "1" ||
            separado[i] == "2" ||
            separado[i] == "3" ||
            separado[i] == "4" ||
            separado[i] == "5" ||
            separado[i] == "6" ||
            separado[i] == "7" ||
            separado[i] == "8" ||
            separado[i] == "9") {
          cont++;
        }
        if (cont == 8) {
          sink.add(dni);
        } else {
          sink.addError('DNI invalido');
        }
      }
    } else {
      sink.addError('DNI de 8 digitos');
    }
  });

  final validartelefono =
      StreamTransformer<String, String>.fromHandlers(handleData: (telefono, sink) {
    int cont = 0;
    List<String> separado = telefono.split("");
    if (telefono.length == 9) {
      for (int i = 0; i < telefono.length; i++) {
        if (separado[i] == "0" ||
            separado[i] == "1" ||
            separado[i] == "2" ||
            separado[i] == "3" ||
            separado[i] == "4" ||
            separado[i] == "5" ||
            separado[i] == "6" ||
            separado[i] == "7" ||
            separado[i] == "8" ||
            separado[i] == "9") {
          cont++;
        }
        if (cont == 9) {
          sink.add(telefono);
        } else {
          sink.addError('N° Celular invalido');
        }
      }
    } else {
      sink.addError('N° Celular de 9 digitos');
    }
  });

  final validarNombreyApellido= StreamTransformer<String, String>.fromHandlers(
      handleData: (contrasena, sink) {
    if (contrasena.length >= 6) {
      sink.add(contrasena);
    } else {
      sink.addError('Mayor a 6 caracteres');
    }
  });
}
