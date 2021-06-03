import 'dart:convert';

import 'package:form/src/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  final String _url = 'https://api-rest-74db2-default-rtdb.firebaseio.com';

  Future<List<ProductModel>> getProduct() async {
    final url = '$_url/productos.json';
    final resp = await http.get(Uri.parse(url));
    //esta variable almacena mapas
    //final decodeData = json.decode(resp.body);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductModel> productos = [];
    if (decodeData == null) {
      return [];
    }
    decodeData.forEach((id, producto) {
      final prodTemp = ProductModel.fromJson(producto);
      prodTemp.id = id;
      productos.add(prodTemp);
    });
    print(productos);
    // return decodeData;
    return productos;
  }

  Future<bool> insertProduct(ProductModel producto) async {
    final url = '$_url/productos.json';
    final resp =
        await http.post(Uri.parse(url), body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<bool> updateProduct(ProductModel producto) async {
    final url = '$_url/productos/${producto.id}.json';
    final resp =
        await http.put(Uri.parse(url), body: productoModelToJson(producto));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    return true;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/productos/$id.json';
    final resp = await http.delete(Uri.parse(url));

    final decodedData = json.decode(resp.body);
    print(decodedData);
    return 1;
  }
}
