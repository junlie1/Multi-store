import 'package:do_an_chuyen_nganh_nhom3/models/product.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/detail/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailScreen(product: product);
        })
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(24)
              ),
              child: Stack(
                children: [
                  Image.network(product.images[0],height: 170,width: 170,fit: BoxFit.cover,),
                  Positioned(
                    top: 15,
                    right: 2,
                    child: Image.asset(
                      'assets/icons/love.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/icons/cart.png',
                      width: 26,
                      height: 26,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
            Text(
              product.productName,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4,),
            Text(
              product.category,
              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black54),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
