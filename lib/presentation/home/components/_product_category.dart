import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../details/detail_page.dart';
import '_build_category_card.dart';
import '_build_popular_card.dart';

ListView category(productList) {
  return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: productList.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          //onTap: () => {Get.to(ProductDetail())},
          child: buildPopularCard(productList[index]),
        );
      });
}

GridView mostPopularCategory(context, product) {
  return GridView.count(
    crossAxisCount: 2,
    childAspectRatio: 0.62,
    children: List.generate(product.length, (index) {
      return GestureDetector(
        onTap: () => Get.to(() => ProductDetail(index: product[index].id)),
        child: buildCard(product[index]),
      );
    }),
  );
}
