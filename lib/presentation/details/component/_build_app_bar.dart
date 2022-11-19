import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab4/components/_close_activity.dart';
import 'package:lab4/domain/ProductReview.dart';

AppBar detailAppBar(ProductReview product) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 200,
    backgroundColor: Colors.white,
    flexibleSpace: Image.network(product.main_image, fit: BoxFit.cover),
    // title: Text(
    //       product.name,
    //       style: const TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    leading: closeActivity(),
    //centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.star_border,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
