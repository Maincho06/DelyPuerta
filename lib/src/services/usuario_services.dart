import 'package:delipuerta/src/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class UsuarioServices {
  final String url = 'https://api-pollo.herokuapp.com';

  Future<Usuario> registrarUsuario(Usuario usuario) async {
    final urlTemp = '$url/Usuario/agregarUsuario';
    final response = await http.post(
      urlTemp,
      body: usuarioToJson(usuario),
      headers: {
        "Content-Type"  : "application/json"
      }
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

}

final usuarioServices = UsuarioServices();