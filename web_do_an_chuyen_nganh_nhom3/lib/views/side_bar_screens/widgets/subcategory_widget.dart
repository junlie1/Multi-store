import 'package:flutter/material.dart';
import 'package:web_do_an_chuyen_nganh_nhom3/controllers/subcategory_controller.dart';
import 'package:web_do_an_chuyen_nganh_nhom3/models/sub_category.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<SubCategory>> futureSubcategories;
  //initState sử dụng để thiết lập trạng thái ban đầu của widget hoặc khởi tạo các tác vụ bất đồng bộ
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSubcategories = SubcategoryController().loadsubcategories();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futureSubcategories, builder: (context,snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      else if(snapshot.hasError) {
        return Center(
          child: Text(
              "Error: ${snapshot.error}"
          ),
        );
      }
      //Không có dữ liệu
      else if(!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(
          child: Text(
              "Không có Subcategories nào trong database"
          ),
        );
      }
      else {
        final subcategories = snapshot.data!; //Data vẫn là Json
        return GridView.builder(
            shrinkWrap: true,
            itemCount: subcategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 6,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context,index) {
              final subcategory = subcategories[index];
              return Image.network(
                  width: 100,
                  height: 100,
                  subcategory.image
              );
            }
        );
      }
    });
  }
}
