import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/place_order_page.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({Key? key}) : super(key: key);

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
                            "Cotton Saree",
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
                            "Pink saree original collection \nColor: Pink",
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
                          "₹ 5250/-",
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
                          "Quantity",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[800],
                          ),
                        ),
                        trailing: SizedBox(
                          width: 150.0,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: AppColors.accentColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                " x01 ",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16.0,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: AppColors.accentColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PlaceOrder()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: 200.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Checkout",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    " (₹ 500) ",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
