import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../domain/Category.dart';

class CategoryController extends GetxController {
  Uri resourceUrl = Uri.parse('http://mobile-shop-api.hiring.devebs.net/categories');
  List<Category> categoryList = [];
  Future<void> readJsonCategories() async {
    final String response = await rootBundle.loadString('assets/shop.json');
    final data = await json.decode(response);
    data["categories"].forEach((item) {
      categoryList.add(Category(
          name: item["title"],
          icon: item["icon"]
      ));
    });
  }

  Future<List<Category>> query(int page) async {
    final response = await http.get(resourceUrl);
    List<Category> categories = [];
    if (response.statusCode == 200) {
      dynamic categoriesJson = json.decode(response.body)["results"];
      categoriesJson.forEach((object){
        categories.add(Category.fromJson(object));
      });
    }
    return categories;
  }
}