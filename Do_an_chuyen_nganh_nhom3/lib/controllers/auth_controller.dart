import 'dart:convert';

import 'package:do_an_chuyen_nganh_nhom3/global_varibles.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/user.dart';
import 'package:do_an_chuyen_nganh_nhom3/services/manager_http_response.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/authenication_screen/login_screen.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future<void> signUpUsers({
    required context,
    required String email,
    required String fullName,
    required String password
})async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          state: '',
          city: '',
          locality: '',
          password: password,
          token: ''
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String> {
        "Content-Type" : 'application/json; charset=UTF-8',
          }
      );
      managerHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            showSnackBar(context, "Bạn đã tạo mới tài khoản thành công");
          }
      );
    }
    catch(e) {

    }
  }

  //SignIn Users
  Future<void> signInUsers({
    required context,
    required email,
    required password
})async{
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'), body: jsonEncode({
        'email':email,
        'password': password
      }),headers: <String, String> {
        "Content-Type" : 'application/json; charset=UTF-8',
      } );

      managerHttpResponse(response: response, context: context, onSuccess: () {
        // Navigator.pushAndRemoveUntil(context, newRoute, predicate)
        //Là đẩy sang trang mới và xóa dữ liệu trang cũnlt
        //predicate là một hàm bool Function(Route) trả về giá trị true hoặc false
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainScreen()), (route)=> false);
        showSnackBar(context, "Bạn đã đăng nhập thành công");
      });
    }
    catch(e) {
      print("Error: $e");
    }
  }
}