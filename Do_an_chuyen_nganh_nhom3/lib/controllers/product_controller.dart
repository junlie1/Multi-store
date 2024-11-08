import 'dart:convert';

import 'package:do_an_chuyen_nganh_nhom3/global_varibles.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProduct() async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/popular-product"),
          headers: <String,String> {
          "Content-Type": 'application/json; charset=UTF-8'
        }
      );
      if(response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      }
      else {
        throw Exception("Fail to load Popular Product");
      }
    }
    catch(e) {
      throw Exception("Error loading product: $e");
    }
  }

  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
          Uri.parse("$uri/api/products-by-category/$category"),
          headers: <String,String> {
            "Content-Type": 'application/json; charset=UTF-8'
          }
      );
      print(response.body);
      if(response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      }
      else {
        throw Exception("Fail to load Popular Product");
      }
    }
    catch(e) {
      throw Exception("Error loading product: $e");
    }
  }
}