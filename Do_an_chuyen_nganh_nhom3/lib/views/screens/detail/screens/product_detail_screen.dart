import 'package:do_an_chuyen_nganh_nhom3/models/product.dart';
import 'package:do_an_chuyen_nganh_nhom3/provider/cart_provider.dart';
import 'package:do_an_chuyen_nganh_nhom3/provider/user_provider.dart';
import 'package:do_an_chuyen_nganh_nhom3/services/manager_http_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    /*cart provider các biến*/
    final _cartProvider = ref.read(cartProvider.notifier);
    final user = ref.watch(userProvider); // Lấy thông tin người dùng từ userProvider
    final userId = user?.id ?? ''; // Lấy userId, nếu null thì gán chuỗi rỗng

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Product Detail",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
            IconButton(
              onPressed: () {
                
              }, 
              icon: Icon(Icons.favorite_border)
            )
          ],
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 260,
                height: 275,
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      left: 22,
                      top: 0,
                      child: Container(
                        width: 216,
                        height: 274,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF9CA8FF,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: SizedBox(
                          height: 300,
                          child: PageView.builder(
                              itemCount: widget.product.images.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  widget.product.images[index],
                                  width: 198,
                                  height: 225,
                                  fit: BoxFit.cover,
                                );
                              }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.productName,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    ),
                  ),
                  Text(
                    "\$${widget.product.productPrice.toString()}",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Description: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent
                  ),
                ),
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: Padding(padding: EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            _cartProvider.addProductToCart(
              productName: widget.product.productName,
              productPrice: widget.product.productPrice,
              category: widget.product.category,
              image: widget.product.images,
              vendorId: widget.product.vendorId,
              productQuantity: widget.product.quantity,
              quantity: 1,
              productId: widget.product.id,
              description: widget.product.description,
              fullName: widget.product.fullName
            );
            showSnackBar(context, "Bạn đã thêm thành công sản phẩm ${widget.product.productName} vào giỏ hàng");
          },
          child: Container(
            width: 300,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                "Add to cart",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
