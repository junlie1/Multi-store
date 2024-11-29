import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/icons/searchBanner.jpeg",
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 60,
                  left: 25,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  top: 60,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(30),
                    child: SizedBox(
                      width: 260,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search here",
                          hintStyle:
                          const TextStyle(fontSize: 14, color: Colors.black),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          prefixIcon: Image.asset(
                            "assets/icons/searc1.png",
                            width: 30,
                            height: 30,
                          ),
                          suffixIcon: Image.asset(
                            "assets/icons/cam.png",
                            width: 30,
                            height: 30,
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
