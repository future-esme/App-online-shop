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


