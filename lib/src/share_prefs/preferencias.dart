import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();
  factory PreferenciasUsuario() {
    return _instancia;
  }
  PreferenciasUsuario._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  int id;

  get tipoUsuario {
    return _prefs.getInt('tipoUsuario');
  }
  set tipoUsuario(int value){
    _prefs.setInt('tipoUsuario', value);
  }

  get usuarioId {
    return _prefs.getInt('id');
  }

  set usuarioId( int value ) {
    _prefs.setInt('id', value);
  }

  get celtoken {
    return _prefs.getString('celtoken')??'';
  }
  
  set celtoken( String value ) {
    _prefs.setString('celtoken', value);
  }
   get token {
    return _prefs.getString('token')??'';
  }
  
  set token( String value ) {
    _prefs.setString('token', value);
  }
}