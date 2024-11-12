import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class DataManager extends ChangeNotifier {
  static final DataManager _instance = DataManager._();

  DataManager._();

  factory DataManager() => _instance;

  final List<Product> _products = [];

  final List<int> _cartProductIds = [];

  List<int> get cartProductIds => _cartProductIds;

  List<Product> get products => _products;

  void addProducts(List<Product> products) {
    _products.addAll(products);
    notifyListeners();
  }

  void addCartProductIds(int id) {
    _cartProductIds.add(id);
    notifyListeners();
  }

  void removeCartIds(int id) {
    _cartProductIds.remove(id);
    notifyListeners();
  }
}
