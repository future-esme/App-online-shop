import 'package:flutter/material.dart';

import '_build_popular_card.dart';

ListView category(productList) {
  return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: productList.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: buildPopularCard(productList[index]),
        );
      });
}


