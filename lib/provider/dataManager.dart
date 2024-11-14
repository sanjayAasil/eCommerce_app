import 'package:ecommerce_app/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class DataManager extends ChangeNotifier {
  static final DataManager _instance = DataManager._();

  DataManager._();

  factory DataManager() => _instance;

  final List<Product> _products = [];

  final List<int> _cartProductIds = [];

  final List<int> _boughtProductIds = [];

  List<int> get cartProductIds => _cartProductIds;

  List<int> get boughtProductIds => _boughtProductIds;

  List<Product> get products => _products;

  void addProducts(List<Product> products) {
    _products.addAll(products);
    notifyListeners();
  }

  void addCartProductId(int id) {
    _cartProductIds.add(id);
    notifyListeners();
  }

  void removeCartId(int id) {
    _cartProductIds.remove(id);
    notifyListeners();
  }

  void addBoughtProductId(int id) {
    _boughtProductIds.add(id);
    notifyListeners();
  }

  void removeBoughtId(int id) {
    _boughtProductIds.remove(id);
    notifyListeners();
  }

  void removeAllCartIds() {
    cartProductIds.clear();
    print('checkkkkwief uhwe fuh uiwef ${cartProductIds.length}');
    notifyListeners();
  }
}
