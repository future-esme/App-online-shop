
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab4/domain/ProductE.dart';
import 'package:lab4/presentation/home/CategoryController.dart';
import 'package:lab4/presentation/home/ProductController.dart';
import 'package:lab4/presentation/home/components/_body.dart';

import '../../domain/Category.dart' as category;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductE> productList = [];
  List<category.Category> categoryList = [];


  Future<void> initialFetch() async {
    final ProductController productController = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    List<category.Category> listCategoryFromRequest = await categoryController.query(1);
    List<ProductE> listProductsFromRequest = await productController.query(1);
    setState(() {
      categoryList.addAll(listCategoryFromRequest);
      productList.addAll(listProductsFromRequest);
    });
  }

  @override
  Widget build(BuildContext context) {
    //var productsE = Res.fetchProducts();
    initialFetch();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: detailBody(productList, categoryList, context),
        ),
      ),
    );
  }
}
