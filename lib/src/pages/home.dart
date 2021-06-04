import 'package:flutter/material.dart';
import 'package:form/src/models/product.dart';
//import 'package:form/src/pages/product.dart';
import 'package:form/src/providers/product-provider.dart';
//import 'package:form/src/bloc/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productProvider = new ProductProvider();
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _crearListado(),
      /*Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('email: ${bloc.email}'),
          Divider(),
          Text('password: ${bloc.password}'),
        ],
      ),*/
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
        future: productProvider.getProduct(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) =>
                    _crearItem(context, snapshot.data![i]));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  _crearBoton(context) {
    return FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orangeAccent,
        onPressed: () =>
            Navigator.pushNamed(context, 'product_add').then((value) {
              setState(() {});
            }));
  }

  Widget _crearItem(BuildContext context, ProductModel producto) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion) {
        productProvider.deleteProduct(producto.id.toString());
      },
      child: ListTile(
          title: Text('${producto.titulo} ${producto.valor}'),
          subtitle: Text('${producto.id}'),
          onTap: () =>
              Navigator.pushNamed(context, 'product', arguments: producto)
                  .then((value) {
                setState(() {});
              })),
    );
  }
}
