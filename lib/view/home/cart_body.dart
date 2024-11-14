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
  double total = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<DataManager>();
    print('checkkkkkk build');
    total = 0;
    products = DataManager().products.where((product) => DataManager().cartProductIds.contains(product.id)).toList();
    for (Product product in products) {
      total += product.price;
    }
    return products.isNotEmpty
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductTile(
                      product: products[index],
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          'Total  ₹${total.ceil()}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (DataManager().cartProductIds.isNotEmpty)
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          for (Product product in products) {
                            DataManager().addBoughtProductId(product.id);
                          }
                          DataManager().removeAllCartIds();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          height: 50,
                          child: const Center(
                            child: Text('Buy All'),
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          )
        : const Center(
            child: Text('No Products added yet'),
          );
  }
}
