import 'package:do_an_chuyen_nganh_nhom3/controllers/auth_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String city;
  late String locality;
  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    final updateUser = ref.read(userProvider.notifier);
    final user = ref.read(userProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Shipping address"
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Hãy nhập địa chỉ của bạn ở đây",style: TextStyle(fontSize: 20,color: Colors.deepPurpleAccent),),
                SizedBox(height: 100,),
                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Hãy nhập thành phố của bạn";
                    }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  onChanged: (value) {
                    locality = value;
                  },
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Hãy nhập địa chỉ của bạn ";
                    }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Locality",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),

                SizedBox(height: 30,),
                TextFormField(
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  validator: (value) {
                    if(value!.isEmpty) {
                      return "Hãy nhập số điện thoại của bạn ";
                    }
                    else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async{
          if(_formKey.currentState!.validate()) {
            print("Click");
            await _authController.updateUserLocation(
                context: context,
                userId: ref.read(userProvider)!.id,
                city: city,
                locality: locality,
                phoneNumber: phoneNumber,
            ).whenComplete(() {
              Navigator.pop(context);
            });
            updateUser.recreateUserState(
              city: city,
              locality: locality,
              phoneNumber: phoneNumber,
            );
          }
          else {
            print("Lỗi");
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}
