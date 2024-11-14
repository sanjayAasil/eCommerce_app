import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/common/global.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/view/single_product/sign_in_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  late bool isBought;

  @override
  void initState() {
    isAddedToCart = DataManager().cartProductIds.contains(widget.product.id);
    isBought = DataManager().boughtProductIds.contains(widget.product.id);
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
      bottomNavigationBar: Row(
        children: [
          if(!isBought)
          Expanded(
            child: InkWell(
              onTap: _onAddToCart,
              child: Container(
                margin: const EdgeInsets.all(10),
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
          ),
          Expanded(
            child: InkWell(
              onTap: _onTapBuy,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isBought ? Colors.grey : Colors.green,
                ),
                height: 50,
                child: Center(
                  child: isBought ? const Text('Purchased') : const Text('Buy Now'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onAddToCart() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await showDialog(
        context: context,
        builder: (context) => const SignInAlertDialog(),
      );

      if (FirebaseAuth.instance.currentUser == null) return;
    }

    if (DataManager().cartProductIds.contains(widget.product.id)) {
      DataManager().removeCartId(widget.product.id);
      isAddedToCart = false;
      showCommonToast('Product removed from cart');
    } else {
      DataManager().addCartProductId(widget.product.id);
      isAddedToCart = true;
      showCommonToast('Product added to cart');
    }
    setState(() {});
  }

  void _onTapBuy() async {
    if (FirebaseAuth.instance.currentUser == null) {
      await showDialog(
        context: context,
        builder: (context) => const SignInAlertDialog(),
      );

      if (FirebaseAuth.instance.currentUser == null) return;
    }

    if (DataManager().cartProductIds.contains(widget.product.id)) {
      DataManager().removeCartId(widget.product.id);
      isAddedToCart = false;
    }

    if (DataManager().boughtProductIds.contains(widget.product.id)) {
      DataManager().removeBoughtId(widget.product.id);
      isBought = false;
    } else {
      DataManager().addBoughtProductId(widget.product.id);
      isBought = true;
    }
    setState(() {});
  }
}
