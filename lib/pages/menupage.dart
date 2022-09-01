// import 'package:flutter/cupertino.dart';
import 'package:coffee_masters/datamanager.dart';
import 'package:flutter/material.dart';

import '../datamodel.dart';

class MenuPage extends StatelessWidget {
  final DataManager dataManager;
  const MenuPage({Key? key, required this.dataManager}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var p = Product(id: 1, name: "Dummy Product", price: 1.25, image: "");
    // var q = Product(
    //     id: 2, name: "Dummy Product Much larger", price: 1.25, image: "");
    // var r = Product(id: 3, name: "Dummy Product 3", price: 1.25, image: "");
    return FutureBuilder(
      future: dataManager.getMenu(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          //The future has finished, data is ready
          var categories = snapshot.data! as List<Category>;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(categories[index].name),
                  ),
                  ListView.builder(
                      itemCount: categories[index].products.length,
                      itemBuilder: (context, productIndex) {
                        return ProductItem(
                            product: categories[index].products[productIndex],
                            onAdd: () {}
                            );
                      },)
                ],
              );
            }),
          );
        } else {
          if (snapshot.hasError) {
            //data is not there because of an error
            return const Text("There was an error!");
          } else {
            //Data is in progress (the future didn't finish)
            return const CircularProgressIndicator();
          }
        }
      }),

      // ListView(
      //   children: [
      //     ProductItem(
      //       product: p,
      //       onAdd: () {},
      //     ),
      //     ProductItem(
      //       product: q,
      //       onAdd: () {},
      //     ),
      //     ProductItem(
      //       product: r,
      //       onAdd: () {},
      //     ),
      //   ],
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onAdd;

  const ProductItem({Key? key, required this.product, required this.onAdd})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/black_coffee.png"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("\$${product.price}"),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        onAdd(product);
                      },
                      child: const Text("Add")),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
