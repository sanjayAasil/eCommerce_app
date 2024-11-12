import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/provider/dataManager.dart';

class SingleProductPage extends StatefulWidget {
  final Product product;

  const SingleProductPage({super.key, required this.product});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  late bool isAddedToCart;

  @override
  void initState() {
    isAddedToCart = DataManager().cartProductIds.contains(widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  widget.product.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                  Text(
                    ' ${widget.product.rating.rate}  | ',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    '${widget.product.rating.count} ratings',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CachedNetworkImage(imageUrl: widget.product.image),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Rs.${widget.product.price}/-',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'Category: ${widget.product.category}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  widget.product.description,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: _onAddToCart,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isAddedToCart ? Colors.red : Colors.yellow.shade700,
          ),
          height: 50,
          child: Center(
            child: isAddedToCart ? const Text('Remove from Cart') : const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }

  _onAddToCart() {
    if (DataManager().cartProductIds.contains(widget.product.id)) {
      DataManager().cartProductIds.remove(widget.product.id);
      isAddedToCart = false;
      print('checkkk ygybywebf yb nefb ${DataManager().cartProductIds.length}');
    } else {
      DataManager().cartProductIds.add(widget.product.id);
      isAddedToCart = true;
      print('checkkk ygybywebf yb wefb ${DataManager().cartProductIds.length}');
    }
    setState(() {});
  }
}
