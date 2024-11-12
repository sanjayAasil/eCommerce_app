import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import '../single_product_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SingleProductPage(
                product: product,
              ))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              height: 100,
              width: 100,
              imageUrl: product.image,
              errorWidget: (context, string, object) => const Icon(Icons.error_outline),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    style: const TextStyle(overflow: TextOverflow.ellipsis, fontSize: 15),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.green,
                        size: 15,
                      ),
                      Text(
                        ' ${product.rating.rate} . ',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        '(${product.rating.count})',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '₹${product.price.toString()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    product.description,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
