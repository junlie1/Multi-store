import 'package:flutter/material.dart';

class SubcategoryTileWidget extends StatelessWidget {
  final String image;
  final String title;

  const SubcategoryTileWidget({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
  /*Ảnh*/
        Container(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(image,fit: BoxFit.cover,),
          ),
        ),
  SizedBox(height: 10,),
  /* Tiêu đề */
        SizedBox(
          height: 50,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}
