import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  final String _fireBaseToken = 'AIzaSyDBXQMckHJt7ipXJvGrZoqH2GXtwNr1MY4';
  //final customToken = admin.auth().createCustomToken("123456");

  Future newUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final resp = await http.post(
        Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_fireBaseToken'),
        body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      //guardar token en el storage
      return {'ok': true, 'token': decodedResp['idToken']};
    } else {
      return {'ok': false, 'mensaje': decodedResp['error']['message']};
    }
  }
}
