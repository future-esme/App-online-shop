import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab4/presentation/login/login_page.dart';
import 'package:get/get.dart';

Row buildActionBar() {
  return Row(
    children: [
      Text(
        'Categories',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
      Spacer(),
      GestureDetector(
        onTap: () => Get.to(LoginScreen()),
        child: Icon(
          CupertinoIcons.profile_circled,
          size: 45,
        ),
      ),
    ],
  );
}
