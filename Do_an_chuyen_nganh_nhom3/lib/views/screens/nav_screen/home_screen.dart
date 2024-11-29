import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/banner_widget.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/category_widget.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/header_widget.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/popular_product_widget.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(),
          BannerWidget(),
          CategoryWidget(),
          ReusableTextWidget(title: "Popular Products", subtitle: "View all"),
          PopularProductWidget(),
        ],
      ),
    );
  }
}
