import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/global/colors.dart';
// import 'package:shopat/screens/place_order_page.dart';

class DescriptionPage extends StatefulWidget {
  final ProductEntity _product;

  DescriptionPage(this._product);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: MediaQuery.of(context).size.width * 0.40,
            height: 50.0,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Visit Cart",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Image.network(
                        // product.image should rome here.
                        "https://images.unsplash.com/photo-1615886753866-79396abc446e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                widget._product.productName,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 16.0),
                            height: 45.0,
                            width: 45.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1.5,
                                color: Color(0XFFF74810),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.favorite,
                              color: Color(0XFFF74810),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget._product.description1 +
                                "\n" +
                                widget._product.description2,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16.0,
                              color: AppColors.accentColor.withOpacity(0.60),
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
                          "₹" + widget._product.sellingPrice.toString(),
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
