import 'package:flutter/material.dart';
//import 'package:form/src/models/product.dart';
import 'package:form/src/pages/home.dart';
import 'package:form/src/pages/login.dart';
import 'package:form/src/pages/product.dart';

import 'src/bloc/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario',
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'product': (BuildContext context) => ProductPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
      ),
      onGenerateRoute: (settings) {
        //final args = settings.arguments as ProductModel;
      },
    ));
  }
}
