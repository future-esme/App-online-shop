
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:lab4/domain/ProductE.dart';
import 'package:lab4/presentation/home/CategoryController.dart';
import 'package:lab4/presentation/home/ProductController.dart';
import 'package:lab4/presentation/home/components/_body.dart';

import '../../constant.dart';
import '../../domain/Category.dart';
import '../details/detail_page.dart';
import 'components/_build_category_card.dart';
import 'components/_categories.dart';
import 'components/_product_category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductE> productList = [];
  List<Category> categoryList = [];
  int _pageNumber;
  bool _loading;
  bool _isLastPage = false;
  int _pageSize = 10;
  int _lastTotalItems = 0;
  ScrollController _scrollController;

  Future<void> initialFetch() async {
    final ProductController productController = Get.put(ProductController());
    final CategoryController categoryController = Get.put(CategoryController());
    List<Category> listCategoryFromRequest = await categoryController.query(1);
    List<ProductE> listProductsFromRequest = await productController.query(_pageNumber);
    setState(() {
      _isLastPage = listProductsFromRequest.length < _pageSize;
      categoryList.addAll(listCategoryFromRequest);
      productList.addAll(listProductsFromRequest);
      _loading = false;
      _pageNumber += 1;
    });
  }

  Future<void> fetchData() async {
    _loading = true;
    final ProductController productController = Get.put(ProductController());
    List<ProductE> listProductsFromRequest = await productController.query(_pageNumber);
    _lastTotalItems = productList.length;
    setState(() {
      _isLastPage = listProductsFromRequest.length < _pageSize;
      productList.addAll(listProductsFromRequest);
      _loading = false;
      _pageNumber += 1;
      print(_lastTotalItems);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo((_lastTotalItems + (_pageNumber - 1))/2*210, duration: const Duration(microseconds: 1), curve: Curves.ease);
      });
      //print(_scrollController.offset);
    });
  }

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    productList = [];
    _loading = true;
    initialFetch();
    _scrollController = ScrollController(initialScrollOffset: 5.0, keepScrollOffset: true)..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    //var productsE = Res.fetchProducts();
    //initialFetch();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: detailBody(categoryList, context),
        ),
      ),
    );
  }

  Column detailBody(List<Category> categories, BuildContext context) {
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
            child: mostPopularCategory(context))
      ],
    );
  }

  Widget mostPopularCategory(context) {
    if (_loading) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(),),
      );
    }
    return GridView.count(
      controller: _scrollController,
      crossAxisCount: 2,
      childAspectRatio: 0.62,
      physics: const AlwaysScrollableScrollPhysics(),
      children: List.generate(productList.length, (index) {
        /*if ((index == productList.length - _nextPageTrigger) && !_isLastPage) {
          print('fetch $index');
          fetchData();
        }*/
        return GestureDetector(
          onTap: () => Get.to(() => ProductDetail(index: productList[index].id)),
          child: buildCard(productList[index]),
        );
      }),
    );
  }
  _scrollListener() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        print("comes to bottom $_loading");
        if (!_isLastPage) {
          _loading = true;
          if (_loading) {
            print("RUNNING LOAD MORE");
            fetchData();
            //print(_scrollController.offset);
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
