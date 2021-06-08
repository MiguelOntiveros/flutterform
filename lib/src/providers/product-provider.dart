import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
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

  Future<String> subirImagen(File? imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dsa2osdzj/image/upload?upload_preset=xsvlhqof');
    //se utiliza el split para separar por imagen y por tipo image/jpeg
    final mimeType = mime(imagen!.path)!.split('/');

    final imageuploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageuploadRequest.files.add(file);

    final streamResponse = await imageuploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salió mal');
      print(resp.body);
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
