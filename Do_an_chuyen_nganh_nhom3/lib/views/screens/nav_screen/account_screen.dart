import 'package:do_an_chuyen_nganh_nhom3/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            _authController.signOutUser(context: context);
          },
          child: Text("Đăng xuất"),
        )
      ),
    );;
  }
}
