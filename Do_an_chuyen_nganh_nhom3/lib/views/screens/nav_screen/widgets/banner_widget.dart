import 'package:do_an_chuyen_nganh_nhom3/controllers/banner_controller.dart';
import 'package:do_an_chuyen_nganh_nhom3/models/banner.dart';
import 'package:flutter/material.dart';
class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanner;

  @override
  void initState() {
    super.initState();
    futureBanner = BannerController().loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,0,8,10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: FutureBuilder(
            future: futureBanner,
            builder: (context, snapshot) {
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
                      "Không có Banners trong database"
                  ),
                );
              }
              else {
                final banners = snapshot.data!; //Data vẫn là Json
                return PageView.builder(
                    itemCount: banners.length,
                    itemBuilder: (context,index) {
                      final banner = banners[index];
                      return Image.network(
                        banner.image,
                        fit: BoxFit.cover,
                      );
                    }
                );
              }
            }
        ),
      ),
    );
  }
}
