import 'package:do_an_chuyen_nganh_nhom3/controllers/category_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/category.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late Future<List<Category>> futureCategories;
  @override
  //initState sử dụng để thiết lập trạng thái ban đầu của widget hoặc khởi tạo các tác vụ bất đồng bộ
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryControllers().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            ReusableTextWidget(title: "Categories", subtitle: "View all"),

  //Danh sách categories
            FutureBuilder(future: futureCategories, builder: (context,snapshot) {
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
                      "Không có Categories nào trong database"
                  ),
                );
              }
              else {
                final categories = snapshot.data!; //Data vẫn là Json q
                return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context,index) {
                      final category = categories[index];
                      return Column(
                        children: [
                          Image.network(height: 60, width: 60, category.image),
                          Text(category.name, style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      );
                    }
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
