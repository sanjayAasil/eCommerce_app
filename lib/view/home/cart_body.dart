import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/view/widget/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/dataManager.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  late List<Product> products;

  @override
  Widget build(BuildContext context) {
    products = DataManager().products.where((product) => DataManager().cartProductIds.contains(product.id)).toList();
    context.watch<DataManager>();
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => ProductTile(
        product: products[index],
      ),
    );
  }
}
