bool isNumeric(String s) {
  if (s.isEmpty) return false;
  final n = num.tryParse(s);
  //si el tryParse no puede parsear el valor, va a retornar null
  return (n == null) ? false : true;
}
