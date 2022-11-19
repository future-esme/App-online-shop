import 'package:flutter/material.dart';
import 'ProductE.dart';
import '_payment_cart_model.dart';

class Res {
  static final String lamp = "assets/images/lamp.png";
  static final String chair = "assets/images/chair.png";
  static final String sofa = "assets/images/sofa.png";
  static final String table = "assets/images/table.png";
  static final String table1 = "assets/images/table_1.png";

/*  static List<ProductE> fetchProducts() {
    List<ProductE> productList = [];
    String description =
        "A product description is the marketing copy that explains what a product is and why it’s worth purchasing. The purpose of a product description is to supply customers with important information about the features and benefits of the product so they’re compelled to buy";
    productList.add(new ProductE(
        colour: Colors.amber.shade900,
        count: "3",
        details: description,
        main_image: Res.sofa,
        info: "",
        price: "5000",
        size: "23/56",
        tag: "",
        name: "Sofa"));
    productList.add(new ProductE(
        colour: Colors.lightBlue.shade500,
        count: "1",
        details: description,
        main_image: Res.table,
        info: "",
        price: "4000",
        size: "43/506",
        tag: "",
        name: "Table"));
    productList.add(new ProductE(
        colour: Colors.yellow.shade800,
        count: "30",
        details: description,
        main_image: Res.lamp,
        info: "",
        price: "500",
        size: "23/56",
        tag: "",
        name: "Lamp"));
    productList.add(new ProductE(
        colour: Colors.pink,
        count: "5",
        details: description,
        main_image: Res.chair,
        info: "",
        price: "500",
        size: "23/56",
        tag: "",
        name: "Chair"));
    productList.add(new ProductE(
        colour: Colors.teal,
        count: "5",
        details: description,
        main_image: Res.table1,
        info: "",
        price: "500",
        size: "23/56",
        tag: "",
        name: "Reading Table"));
    return productList;
  }*/

  static List<PayCard> getPaymentTypes() {
    List<PayCard> cards = [];
    cards.add(new PayCard(
        title: "Net Banking",
        description: "Pay bill using card",
        image: "assets/images/paycard.png"));
    cards.add(new PayCard(
        title: "Credit Card",
        description: "Pay bill using card",
        image: "assets/images/paycard.png"));
    cards.add(new PayCard(
        title: "Debit Card",
        description: "Pay bill using card",
        image: "assets/images/paycard.png"));
    cards.add(new PayCard(
        title: "Wallet pay",
        description: "Pay bill using card",
        image: "assets/images/paycard.png"));
    return cards;
  }
}
