import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class DataManager extends ChangeNotifier {
  static final DataManager _instance = DataManager._();

  DataManager._();

  factory DataManager() => _instance;

  List<Product> _products = [];

  List<int> cartProductIds = [];

  List<Product> get products => _products;

  void addProducts(List<Product> products) {
    _products.addAll(products);
    notifyListeners();
  }
}
