import 'package:do_an_chuyen_nganh_nhom3/global_varibles.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/cart.dart';
import 'package:do_an_chuyen_nganh_nhom3/services/manager_http_response.dart';
import 'package:http/http.dart' as http;

class CartController {
  Future<void> addProductToCart({
    required String userId,
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required int productQuantity,
    required String productId,
    required context
}) async {
    try{
      final Cart cart = Cart(
          productName: productName,
          productPrice: productPrice,
          category: category,
          image: image,
          vendorId: '',
          productQuantity: productQuantity,
          quantity: 1,
          productId: productId,
          description: '',
          fullName: ''
      );
      http.Response response = await http.post(
        Uri.parse("$uri/api/add-cart"),
        body: cart.toJson(),
        headers: <String,String> {
          "Content-Type": 'application/json; charset=UTF-8'
        }
      );
      if(response.statusCode == 200) {
        managerHttpResponse(response: response, context: context, onSuccess: () {
          showSnackBar(context, "Bạn đã thêm sản phẩm vào giỏ hàng thành công");
        });
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
}