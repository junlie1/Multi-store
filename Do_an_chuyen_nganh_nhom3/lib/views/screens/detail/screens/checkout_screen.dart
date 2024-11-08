import 'package:do_an_chuyen_nganh_nhom3/controllers/order_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/provider/cart_provider.dart';
import 'package:do_an_chuyen_nganh_nhom3/provider/user_provider.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/detail/screens/shipping_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String selectedPaymentMethod = "Momo";
  final OrderController _orderController = OrderController();

  @override
  Widget build(BuildContext context) {
    final cartData = ref.read(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ShippingAddressScreen();
                  }));
                },
                child: SizedBox(
                  width: 350,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
      //Khung chứa
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 335,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.lightBlueAccent
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
      //Column Text
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -1,
                                left: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: SizedBox(
                                              width: 114,
                                              child: Text(
                                                'Địa chỉ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.1,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: user!.city.isNotEmpty
                                                ? Text(
                                                user.city,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue
                                              ),
                                            )
                                                :Text(
                                              'Việt Nam',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.3,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: user.locality.isNotEmpty
                                                ?Text(user.locality,style: TextStyle(color: Colors.black45),)
                                                : Text(
                                                  'Enter locality',
                                                  style: TextStyle(
                                                    color: const Color(0xFF7F808C),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text("SĐT: "),
                                      Text(user.phoneNumber),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
      //Icon địa chỉ
                      Positioned(
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Image.network(
                                          height: 26,
                                          width: 26,
                                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
      //Icon Chỉnh sửa
                      Positioned(
                        left: 305,
                        top: 25,
                        child: Image.network(
                          width: 20,
                          height: 20,
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),
/*Text*/
              Text(
                "Your Item",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),

/*Danh sách item*/
            Flexible(
              child: ListView.builder(
                itemCount: cartData.length,
                shrinkWrap: true,
                itemBuilder: (context,index) {
                  final cartItem = cartData.values.toList()[index];
                  return InkWell(
                    onTap: () {

                    },
                    child: Container(
                      width: 180,
                      height: 91,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xEAB7C8FF)),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 78,
                            height: 78,
                            child: Image.network(cartItem.image[0]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cartItem.productName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  cartItem.category,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              "\$${cartItem.productPrice.toString()} x ${cartItem.quantity}",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              )
            ),

            SizedBox(height: 10,),
/*Chọn cách thức chuyển tiền*/
            Text(
              "Choose Payment Method",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            
            RadioListTile<String>(
              title: Text(
                "Momo",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              value: "Momo",
              groupValue: selectedPaymentMethod,
              onChanged: (String? value) {
                setState(() {
                  selectedPaymentMethod = value!;
                });
              }
            ),
              RadioListTile<String>(
                  title: Text(
                    "Cash on delivery",
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  value: "cashOnDelivery",
                  groupValue: selectedPaymentMethod,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  }
              ),
            ],
          ),
        ),
      ),
/*Kiểm tra đã có địa chỉ chưa?*/
      bottomNavigationBar: user!.city.isEmpty
          ? TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ShippingAddressScreen();
          }));
        },
        child: Text("Hãy nhập địa chỉ của bạn",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
      )
          :InkWell(
        onTap: () async{
          if(selectedPaymentMethod == "Momo") {
            print("aaaaa");
          }
          else{
            print("đã ấn cash on delivery");
//Future.forEach(elements, action)
//elements: là danh sách (hoặc element) chứa các phần tử mà bạn muốn thực hiện thao tác trên từng phần tử.
// action: là hàm hoặc biểu thức trả về Future sẽ được thực hiện trên mỗi phần tử của element.
            try {
              await Future.forEach(_cartProvider.getCartItems.entries, (entry) async {
                var item = entry.value;
                await _orderController.uploadOrders(
                    id: '',
                    fullName: ref.read(userProvider)!.fullName,
                    email: ref.read(userProvider)!.email,
                    city: ref.read(userProvider)!.city,
                    locality: ref.read(userProvider)!.locality,
                    phoneNumber: ref.read(userProvider)!.phoneNumber,
                    productName: item.productName,
                    productPrice: item.productPrice,
                    quantity: item.quantity,
                    category: item.category,
                    image: item.image[0],
                    buyerId: ref.read(userProvider)!.id,
                    vendorId: item.vendorId,
                    processing: true,
                    delivered: false,
                    context: context
                );
              });
            } catch (e) {
              // In ra lỗi để giúp bạn kiểm tra và sửa lỗi
              print("Error during order placement: $e");
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Có lỗi xảy ra khi đặt hàng: $e"))
              );
            }
          }
        },
        child: Container(
          width: 100,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                selectedPaymentMethod == "Momo" ? "Pay now" : "Place order",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              )
            )
          ),
        ),
      ),
    );
  }
}
