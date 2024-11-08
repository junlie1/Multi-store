import 'package:do_an_chuyen_nganh_nhom3/models/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartProvider = StateNotifierProvider<CartNotifier,Map<String,Cart>>(
    (ref) {
      return CartNotifier();
    }
);

class CartNotifier extends StateNotifier<Map<String,Cart>> {
  CartNotifier() : super({});

  /*method add Product vào Cart */
  void addProductToCart({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int productQuantity,
    required int quantity,
    required String productId,
    required String description,
    required String fullName
}) {
    /*Kiểm tra sản phẩm có trong giỏ hàng chưa?*/
    if(state.containsKey(productId)) {
      state = {
        ...state,
        productId: Cart(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          image: state[productId]!.image,
          vendorId: state[productId]!.vendorId,
          productQuantity: state[productId]!.productQuantity,
          quantity: state[productId]!.quantity + 1,
          productId: state[productId]!.productId,
          description: state[productId]!.description,
          fullName: state[productId]!.fullName
        )
      };
    }
    else {
      state = {
        ...state,
        productId: Cart(
          productName: productName,
          productPrice: productPrice,
          category: category,
          image: image,
          vendorId: vendorId,
          productQuantity: productQuantity,
          quantity: quantity,
          productId: productId,
          description: description,
          fullName: fullName
        )
      };
    }
  }

  /*Method tăng số lượng sản phẩm*/
  void incrementCartItem(String productId) {
    if(state.containsKey(productId)) {
        state[productId]!.quantity++;

        //Sự kiện lắng nghe sự thay đổi số lương
      state ={...state};
    }
  }

  /*Method tăng số lượng sản phẩm*/
  void decrementCartItem(String productId) {
    if(state.containsKey(productId)) {
      state[productId]!.quantity--;

      //Sự kiện lắng nghe sự thay đổi số lương
      state ={...state};
    }
  }

  /*Method xóa item ra khỏi cart*/
  void removeCartItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  /*Method tính tổng tiền*/
  double calculateTotalAmount() {
    double totatAmount = 0.0;
    state.forEach((productId,cartItem) {
      totatAmount += cartItem.quantity * cartItem.productPrice;
    });
    return totatAmount;
  }

  /*Method get dữ liệu*/
  Map<String,Cart> get getCartItems => state;
}