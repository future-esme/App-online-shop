import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:lab4/domain/ProductE.dart';

import '../../domain/Product.dart';
import '../../domain/ProductReview.dart';

class ProductController extends GetxController {
  Uri resourceUrl = Uri.parse('http://mobile-shop-api.hiring.devebs.net/products');

  List<Product> productList = [];
  Future<void> readJsonProducts() async {
    final String response = await rootBundle.loadString('assets/shop.json');
    final data = await json.decode(response);
    data["products"].forEach((item) {
      productList.add(Product(
          cover: item["cover"],
          title: item["title"],
          sub_title: item["sub_title"],
          price: item["price"],
          currency: item["currency"]
      ));
    });
    update();
  }

  Future<List<ProductE>> query(int page) async {
    final response = await http.get(resourceUrl);
    List<ProductE> products = [];
    if (response.statusCode == 200) {
      dynamic productsJson = json.decode(response.body)["results"];
      productsJson.forEach((object){
        products.add(ProductE.fromJson(object));
      });
    }
    return products;
  }

  Future<ProductReview> findOne(int id) async {
    final response = await http.get('$resourceUrl/$id');
    ProductReview product;
    if (response.statusCode == 200) {
      dynamic productJson = json.decode(response.body);
      product = ProductReview.fromJson(productJson);
    }
    return product;
  }
}