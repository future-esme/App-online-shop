import 'package:flutter/material.dart';

Container showImageView(BuildContext context, product) {
  var screenSize = MediaQuery.of(context).size;
  var screenHeight = (screenSize.height);
  return Container(
    padding: EdgeInsets.all(20),
    color: product.colour,
    child: Image.network(
      product.main_image,
      alignment: Alignment.centerRight,
      height: screenHeight * 50,
    ),
  );
}
