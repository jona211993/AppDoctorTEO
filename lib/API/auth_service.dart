
import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import '../services/local_storage.dart';
import 'api_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthService {

  AuthStatus authStatus = AuthStatus.checking;

  AuthService() {
    this.isAuthenticated();
  }

  Future<bool> loginService( String email, String password) async {

    try{
      final response = await http.post(
      Uri.parse('$apiUrl/api/auth/signIn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password
      }),
    );
    if (response.statusCode == 200) {
      // La petición fue exitosa
      final data = json.decode(response.body);

      if ( data["token"] != null){
        authStatus = AuthStatus.authenticated;
        final token = data["token"];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        print(decodedToken);
        LocalStorage.prefs.setString('token', token! );
        LocalStorage.prefs.setString('id', decodedToken["id"]! );
        LocalStorage.prefs.setString('apellidoPaterno', decodedToken["apellidoPaterno"]! );
        LocalStorage.prefs.setString('apellidoMaterno', decodedToken["apellidoMaterno"]! );
        LocalStorage.prefs.setString('nombre', decodedToken["nombre"]! );
        return true;
      }else{

        return false;
      }

    } else {

      return false;
    }
    } catch (e) {

      return false;
    }
  
}
  bool isAuthenticated()  {

    final token = LocalStorage.prefs.getString('token');

    if( token == null ) {
      authStatus = AuthStatus.notAuthenticated;

      return false;
    }else{

      authStatus = AuthStatus.authenticated;
      return true;
    }
    

  }


  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
  }

}
