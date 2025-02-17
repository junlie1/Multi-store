import 'dart:convert';

import 'package:do_an_chuyen_nganh_nhom3/global_varibles.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/order.dart';
import 'package:do_an_chuyen_nganh_nhom3/services/manager_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OrderController {
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String city,
    required String locality,
    required String phoneNumber,
    required String productId,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool shipping,
    required bool delivered,
    required bool isPaid,
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
        productId: productId,
        productName: productName,
        productPrice: productPrice,
        quantity: quantity,
        category: category,
        image: image,
        buyerId: buyerId,
        vendorId: vendorId,
        processing: processing,
        shipping: shipping,
        delivered: delivered,
        isPaid: isPaid,
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

  //Get order by buyerId
  Future<List<Order>> loadOrders({required String buyerId}) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/orders/$buyerId"),
      headers: <String,String> {
        "Content-Type": 'application/json; charset=UTF-8'
      }
      );
      if(response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Order> orders = data.map((order) => Order.fromJson(order)).toList();
        return orders;
      }
      else {
        throw Exception("Fail to load order");
      }
    }
    catch(e) {
      throw Exception("Lỗi api");
    }
  }

  //Xóa order theo Id
  Future<void> deleteOrder({required String id, required bool shipping, required context}) async {
    try {
      http.Response response = await http.delete(
        Uri.parse("$uri/api/delete-order/$id"),
        headers: <String,String> {
          "Content-Type": 'application/json; charset=UTF-8'
        }
      );
      managerHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Bạn đã xóa order thành công");
      });
    }
    catch(e){
      print("Lỗi: $e");
    }
  }

  Future<void> payWithMomo(String orderId) async {
    try {
      // Gửi yêu cầu POST đến API MoMo
      http.Response response = await http.post(
        Uri.parse("$uri/payment"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"orderId": orderId}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final payUrl = responseData['payUrl'];

        if (payUrl != null) {
          // Mở URL thanh toán
          if (await canLaunchUrl(Uri.parse(payUrl))) {
            await launchUrl(Uri.parse(payUrl), mode: LaunchMode.externalApplication);
          } else {
            throw "Không thể mở URL thanh toán";
          }
        } else {
          throw "Không nhận được URL thanh toán từ MoMo";
        }
      } else {
        throw "Lỗi API: ${response.body}";
      }
    } catch (e) {
      print("Lỗi thanh toán MoMo: $e");
    }
  }

  Future<void> deliveredOrder({required String id, required context}) async{
    try{
      http.Response response = await http.patch(
          Uri.parse("$uri/api/order/$id/delivered"),
          headers: <String,String> {
            "Content-Type": 'application/json; charset=UTF-8'
          },
          body: jsonEncode({
            "shipping": false,
            "processing": false,
            "delivered": true
          })
      );
      managerHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Bạn đã thay đổi trạng thái thành giao hàng thành công");
      });
    }
    catch(e) {
      print("Lỗi: $e");
    }
  }

  Future<void> shipOrder({required String id, required context}) async{
    try{
      http.Response response = await http.patch(
          Uri.parse("$uri/api/order/$id/shipping"),
          headers: <String,String> {
            "Content-Type": 'application/json; charset=UTF-8'
          },
          body: jsonEncode({
            "shipping": true,
            "processing": false
          })
      );
      managerHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Bạn đã thay đổi trạng thái thành đang vận chuyển");
      });
    }
    catch(e) {
      print("Lỗi: $e");
    }
  }

  Future<void> cancleOrder({required String id, required context}) async{
    try{
      http.Response response = await http.patch(
          Uri.parse("$uri/api/order/$id/processing"),
          headers: <String,String> {
            "Content-Type": 'application/json; charset=UTF-8'
          },
          body: jsonEncode({
            "shipping": false,
            "processing": false
          })
      );
      managerHttpResponse(response: response, context: context, onSuccess: () {
        showSnackBar(context, "Bạn đã hủy đơn hàng của người dùng");
      });
    }
    catch(e) {
      print("Lỗi: $e");
    }
  }
}