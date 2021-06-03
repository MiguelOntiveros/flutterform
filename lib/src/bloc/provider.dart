// Aqui manejo mi InheritedWidget Personalizado
import 'package:flutter/material.dart';
import 'package:form/src/bloc/loginbloc.dart';
export 'package:form/src/bloc/loginbloc.dart';

class Provider extends InheritedWidget {
  final loginBlog = LoginBloc();
  static Provider? _instancia;

  factory Provider({Key? key, required Widget child}) {
    if (_instancia == null) {
      _instancia = Provider._internal(key: key, child: child);
    }
    return _instancia!;
  }

  Provider._internal({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()!.loginBlog;
  }
}
