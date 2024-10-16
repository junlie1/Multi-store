import 'package:do_an_chuyen_nganh_nhom3/controllers/category_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/controllers/subcategory_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/category.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/sub_category.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/header_widget.dart';
import 'package:do_an_chuyen_nganh_nhom3/views/screens/nav_screen/widgets/reusable_text_widget.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Category>> futureCategories;
  Category? _selectedCategory;
  //1 category có nhiều subcategories nên để 1 list
  List<SubCategory> _subcategories = [];
  final SubcategoryController _subcategoryController = SubcategoryController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryControllers().loadCategories();
  }

  //Hàm loadCategory:
  Future<void> _loadSubcategories(String categoryName) async{
    final subcategories = await _subcategoryController.getSubCategoryByCategoryName(categoryName);
    setState(() {
      _subcategories = subcategories;
    });
    print(subcategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 20),
          child: HeaderWidget()
      ),
      body: Row(
        children: [
//Bên trái
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black12,
              child: FutureBuilder(future: futureCategories, builder: (context,snapshot) {
                if(snapshot.connectionState == ConnectionState) {
                  return CircularProgressIndicator();
                }
                else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Lỗi: ${snapshot.error}"
                    ),
                  );
                }
                else {
                  final categories = snapshot.data!;
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index){
                      final category = categories[index];
                      return ListTile(
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                          _loadSubcategories(category.name);
                        },
                        title: Text(
                          category.name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: _selectedCategory == category ? Colors.blue : Colors.black
                          ) ,
                        ),
                      );
                  });
                }
              }),
            ),
          ),

//Bên phải
          Expanded(
            flex:5,
            child: _selectedCategory != null ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_selectedCategory!.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(_selectedCategory!.banner),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: _subcategories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 4, crossAxisSpacing: 8),
                  itemBuilder: (context,index) {
                    final subcategory = _subcategories[index];
                    return Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Center(
                            child: Image.network(
                              subcategory.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(subcategory.subCategoryName),
                        )
                      ],
                    );
                  }
                )
              ],
            ) : Container(),
          )
        ],
      ),
    );
  }
}
