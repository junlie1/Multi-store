import 'package:do_an_chuyen_nganh_nhom3/controllers/product_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/product.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';


class PopularProductWidget extends StatefulWidget {
  const PopularProductWidget({super.key});

  @override
  State<PopularProductWidget> createState() => _PopularProductWidgetState();
}

class _PopularProductWidgetState extends State<PopularProductWidget> {
  late Future<List<Product>> futurePopularProducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePopularProducts = ProductController().loadPopularProduct();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futurePopularProducts,
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        else if(snapshot.hasError) {
          print(snapshot.error);
          return Center(child: Text("Lỗi: ${snapshot.error}"),);
        }
        else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Center(child: Text("Không có sản phẩm"),);
        }
        else {
          final products = snapshot.data;
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products!.length,
              itemBuilder: (context,index) {
                final product = products[index];
    /*Gọi widget ProductItemWidget */
                return ProductItemWidget(product: product,);
              }
            ),
          );
        }
      }
    );
  }
}
