import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/service/api_service.dart';
import 'package:flutter/material.dart';

import '../widget/product_tile.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : GridView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ProductTile(
              product: products[index],
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3/4,
            ),
          );
  }
}
