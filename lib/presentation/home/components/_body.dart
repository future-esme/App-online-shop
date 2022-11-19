import 'package:flutter/material.dart';
import 'package:lab4/domain/Category.dart';
import '../../../constant.dart';
import '../../../domain/Product.dart';
import '../../../domain/ProductE.dart';
import '_action_bar.dart';
import '_categories.dart';
import '_product_category.dart';
import '_search_filter_view.dart';

Column detailBody(List<ProductE> products, List<Category> categories, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      /*buildActionBar(),
      SizedBox(height: kSpace),
      buildSearchRow(),
      SizedBox(height: kSpace),*/
      section('Categories', ''),
      const SizedBox(height: kSpace),
      Container(
        height: 120,
        child: category(categories),
      ),
      const SizedBox(height: kSpace),
      section('Best Selling', 'See all'),
      const SizedBox(height: kSpace),
      Expanded(
          child: mostPopularCategory(context, products))
    ],
  );
}