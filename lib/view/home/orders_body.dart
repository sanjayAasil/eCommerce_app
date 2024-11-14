import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/product_model.dart';
import '../../provider/dataManager.dart';
import '../widget/product_tile.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({super.key});

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
  late List<Product> products;

  @override
  Widget build(BuildContext context) {
    products = DataManager().products.where((product) => DataManager().boughtProductIds.contains(product.id)).toList();
    context.watch<DataManager>();
    return products.isNotEmpty
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ProductTile(
              product: products[index],
            ),
          )
        : const Center(
            child: Text('No Products purchased yet'),
          );
  }
}
