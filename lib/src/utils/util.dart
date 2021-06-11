import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  //si el tryParse no puede parsear el valor, va a retornar null
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('datos incorrectos'),
          content: Text(mensaje),
          actions: <Widget>[
            ElevatedButton(
                child: Text('ok'), onPressed: () => Navigator.of(context).pop())
          ],
        );
      });
}
