import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:ecommerce_app/service/network_connectivity_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const url = 'https://fakestoreapi.com/products';

  Future<List<Product>> getProducts() async {
    try {
      if (ConnectivityService().connectionStatus.contains(ConnectivityResult.none)) {
        print('no internet received in api call');
        return [];
      }

      print('checkkk api call');

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        List data = jsonDecode(res.body);

        return data.map((e) => Product(e)).toList();
      } else {
        print('Error fetching api results...Client Exception');
        return [];
      }
    } catch (e) {
      print('Error fetching api results $e');
      return [];
    }
  }
}
