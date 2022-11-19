import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab4/domain/ProductReview.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../constant.dart';
import '../../domain/Review.dart';
import '../home/ProductController.dart';
import 'component/_build_app_bar.dart';


class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.index}) : super(key: key);
  int index;

  @override
  State<ProductDetail> createState() => _ProductDetailState(index: this.index);
}

class _ProductDetailState extends State<ProductDetail> {
  _ProductDetailState({Key key, this.index});
  int index;
  ProductReview product;

  @override
  initState() {
    super.initState();
    final ProductController productController = Get.put(ProductController());
    productController.findOne(index).then((value) => {
      setState(() {
        product = value;
      })
    });
  }

  Future<void> fetchProduct(int index) async {
    final ProductController productController = Get.put(ProductController());
    product = await productController.findOne(index);
  }

  @override
  Widget build(BuildContext context) {
    //fetchProduct(widget.index);
    if (product == null) {
      return FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 1,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
              ),
            ),
          )
        ),
      );
    } else {
      return Scaffold(
        appBar: detailAppBar(product),
        body: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    product.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),
                  )
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: sizeAndColor(product),
              ),
              Padding(padding: EdgeInsets.all(15),
                child: detailsSection(product),),
              // Padding(padding: EdgeInsets.all(15),
              //     child: reviewSection(product))
              Padding(padding: EdgeInsets.only(left: 15, right: 15),
              child: _staticText('Review', Colors.black, FontWeight.bold, 20)),
              const SizedBox(height: kSpace),
              Padding(padding: EdgeInsets.only(left: 15, right: 15),
              child: _staticText('Write your', kGreen, FontWeight.normal, 15)),
              const SizedBox(height: kSpace),
              reviewList(product.reviews),
              //showImageView(context, product),
              // SizedBox(height: kSpace),
              // Positioned(
              //   bottom: 50,
              //   left: 20,
              //   right: 20,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       buildRowPriceRating(product),
              //       SizedBox(height: kSpace),
              //       Text(
              //         product.details,
              //         textAlign: TextAlign.justify,
              //         overflow: TextOverflow.ellipsis,
              //         style: TextStyle(fontSize: 16.0, color: Colors.black),
              //         maxLines: 5,
              //       ),
              //       SizedBox(height: 20),
              //       Center(child: btnAddToCart(context, product)),
              //     ],
              //   ),
              // ),
            ],
          ),
        )
      );
    }
  }

  Column detailsSection(ProductReview productReview) {
    return Column(
      children: [
        _staticText('Details', Colors.black, FontWeight.bold, 20),
        const SizedBox(height: ksSpace),
        Text(
          product.details,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15
          ),
        ),
        const SizedBox(height: kSpace),
        _staticText('Read More', kGreen, FontWeight.normal, 15),
      ],
    );
  }

  // Column reviewSection(ProductReview product) {
  //   return Column(
  //     //crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       _staticText('Review', Colors.black, FontWeight.bold, 20),
  //       const SizedBox(height: ksSpace),
  //       _staticText('Write your', kGreen, FontWeight.normal, 15),
  //       const SizedBox(height: kSpace),
  //       reviewList(product.reviews)
  //     ],
  //   );
  // }

  Expanded reviewList(List<Review> reviews) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: reviews.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: _test(reviews[index])
            )
          );
        },
      ),
    );
  }

  Row _singleReview(Review review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.network(defaultPhoto),
        Column(
          children: [
            Row(
              children: [
                Text(review.first_name + review.last_name),
                Spacer(),
                _starRating(review.rating)
              ],
            ),
            Text(review.message)
          ],
        ),
      ],
    );
  }

  Column _test(Review review) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(55),
              child: Image.network(defaultPhoto, height: 45, width: 45, ),
            ),
            const SizedBox(width: 10),
            Text(review.first_name + review.last_name),
            Spacer(),
            _starRating(review.rating),
          ],
        ),
        Text(review.message, textAlign: TextAlign.left,),
      ],
    );
  }

  SmoothStarRating _starRating(rating) {
      return SmoothStarRating(
          allowHalfRating: false,
          onRated: (v) {},
          starCount: rating,
          size: 20.0,
          isReadOnly: true,
          color: Colors.amberAccent,
          halfFilledIconData: Icons.blur_on,
          borderColor: Colors.amberAccent,
          spacing: 0.0);
  }

  Row _staticText(String text, Color color, FontWeight fontWeight, double size) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight: fontWeight,
              fontSize: size,
              color: color
          ),
        ),
        Spacer()
      ],
    );
  }

  Row sizeAndColor(ProductReview product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1,child: detailSize(product.size),),
        Expanded(flex: 1,child: detailColor(product.colour),),
      ],
    );
  }

  Padding detail(Padding row) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          //elevation: 0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(55),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10
                )
              ]
          ),
          child: GridTile(
              child: row
          ),
        )
    );
  }
  
  Padding detailSize(String size) {
    Row row = Row(
      children: [
        Text('Size',
        style: TextStyle(
          fontSize: 18
        )),
        Spacer(),
        Text(size)
      ],
    );
    Padding padding = Padding(padding: EdgeInsets.all(15),
    child: row);
    return detail(padding);
  }

  Padding detailColor(Color color) {
    Row row = Row(
      children: [
        Text('Color',
            style: TextStyle(
                fontSize: 18
            )),
        Spacer(),
        Icon(
          Icons.square_rounded,
          color: color,
        )
      ],
    );
    Padding padding = Padding(padding: EdgeInsets.all(15),
        child: row);
    return detail(padding);
  }


}
