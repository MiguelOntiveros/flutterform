import 'package:flutter/material.dart';
//import 'package:form/src/models/product.dart';
import 'package:form/src/pages/home.dart';
import 'package:form/src/pages/login.dart';
import 'package:form/src/pages/product-add.dart';
import 'package:form/src/pages/product.dart';
import 'package:form/src/pages/registro.dart';
import 'package:form/src/preferences/preferences.dart';

import 'src/bloc/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new Preferences();
  await prefs.initPref();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pref = new Preferences();
    print('Este es el AUTH-TOKEN:');
    print(pref.getToken);
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'product': (BuildContext context) => ProductPage(),
        'product_add': (BuildContext context) => ProductAddPage(),
        'registro': (BuildContext context) => RegistroPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      //onGenerateRoute: (settings) {
      //final args = settings.arguments as ProductModel;
      //},
    ));
  }
}
