import 'package:do_an_chuyen_nganh_nhom3/global_varibles.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/order.dart';
import 'package:do_an_chuyen_nganh_nhom3/services/manager_http_response.dart';
import 'package:http/http.dart' as http;

class OrderController {
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String city,
    required String locality,
    required String phoneNumber,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context
}) async {
    try{
      final Order order = Order(
        id: id,
        fullName: fullName,
        email: email,
        city: city,
        locality: locality,
          phoneNumber: phoneNumber,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        delivered: delivered
      );
      
      http.Response response = await http.post(
        Uri.parse("$uri/api/orders"),
        body: order.toJson(),
        headers: <String,String> {
          "Content-Type": 'application/json; charset=UTF-8'
        }
      );
      print(response.body);
      managerHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Bạn đã đặt hàng thành công");
          }
      );
    }
    catch(e) {
      print(e.toString());
    }
  }
}