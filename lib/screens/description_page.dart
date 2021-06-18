import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/models/product.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/place_order_page.dart';

class DescriptionPage extends StatelessWidget {
  final ProductInfo _product;

  DescriptionPage(this._product);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 4.0),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 300,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Center(
                              child: Image.network(
                                  // product.image should rome here.
                                  "https://images.unsplash.com/photo-1615886753866-79396abc446e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _product.productName,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            _product.description1 +
                                "\n" +
                                _product.description2,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey),
                      ListTile(
                        title: Text(
                          "Price (per item)",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[800],
                          ),
                        ),
                        trailing: Text(
                          "₹" + _product.sellingPrice.toString(),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey),
                      ListTile(
                        title: Text(
                          "Save",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[800],
                          ),
                        ),
                        trailing: Text(
                          "Save icon",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.accentColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
