import 'package:flutter/material.dart';
import 'package:form/src/models/product.dart';
import 'package:form/src/providers/product-provider.dart';
import 'package:form/src/utils/util.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

  ProductModel product = new ProductModel();
  final productProvider = new ProductProvider();

  @override
  Widget build(BuildContext context) {
    /*final ProductModel prodData =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    if (product != null) {
      product = prodData;
    }*/
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _crearNombre(),
                _crearPrecio(),
                _crearBoton(),
                _crearDisponible(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: product.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'producto',
      ),
      onSaved: (value) => product.titulo = value!,
      validator: (value) {
        if (value!.length <= 2 || value.length == 0) {
          return 'ingresa el nombre del producto';
        } else {
          //el null significa que el valor pasa sin ningun problema
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: product.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'precio',
      ),
      onSaved: (value) => product.valor = double.parse(value!),
      validator: (value) {
        if (isNumeric(value!)) {
          return null;
        } else {
          return 'solo números';
        }
      },
    );
  }

  Widget _crearBoton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.save),
      label: Text('guardar'),
      onPressed: _submit,
      style: ButtonStyle(),
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: product.disponible,
      title: Text('disponible'),
      onChanged: (value) => setState(() {
        product.disponible = value;
      }),
    );
  }

  void _submit() {
    //cuando el formulario no es valido
    //if (formKey.currentState!.validate()) return;
    //cuando el formulario es valido
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print('los datos correctos');
      print(product.titulo);
      print(product.valor);
      if (product.id != null) {
        productProvider.updateProduct(product);
      } else {
        productProvider.insertProduct(product);
      }
    }
  }
}
