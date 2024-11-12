import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/service/api_service.dart';
import 'package:flutter/material.dart';

import '../widget/product_tile.dart';

class ProductBody extends StatefulWidget {
  const ProductBody({super.key});

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  bool isLoading = true;
  late List<Product> products;

  @override
  void initState() {
    print('checklk homeBody init');
    _fetchData();
    super.initState();
  }

  _fetchData() async {
    products = await ApiService().getProducts();
    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ProductTile(
              product: products[index],
            ),
          );
  }
}
