import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/view/provider/dataManager.dart';
import 'package:ecommerce_app/view/widget/product_tile.dart';
import 'package:flutter/material.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  late List<Product> products;

  @override
  void initState() {
    products = DataManager().products;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ProductTile(
        product: products[index],
      ),
    );
  }
}
