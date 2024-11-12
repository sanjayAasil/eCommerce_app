import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/material.dart';

class SingleProductPage extends StatefulWidget {
  final Product product;

  const SingleProductPage({super.key, required this.product});

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellow.shade700,
        ),
        height: 50,
         child: const Center(child: Text('Add to Cart')),
      ),
    );
  }
}
