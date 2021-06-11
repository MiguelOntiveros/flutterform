import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = new Preferences._internal();

  factory Preferences() {
    return _instancia;
  }
  Preferences._internal();

  late SharedPreferences prefs;

  initPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  get getToken {
    return prefs.getString('token') ?? '';
  }

  setToken(String value) {
    prefs.setString('token', value);
  }
}
