import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/widgets/separator.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          "Place Order",
          style: TextStyle(
            fontFamily: "Poppins",
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DottedBorder(
              strokeWidth: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Frock 9 year cotton",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "1 x ₹229",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cotton Saree",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "2 x ₹5250",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    MySeparator(),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total items",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "3",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Net total",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "₹10,729",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    MySeparator(),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your savings",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "₹29",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Payable Amount",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "₹10,700",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    MySeparator(),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Billing Address",
                          style: TextStyle(fontFamily: "Poppins"),
                        ),
                        Text(
                          "Ram nagar extension\n Siraj colony, 2452255 \n Chattisgarh India",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              "Go Back",
              style: TextStyle(fontFamily: "Poppins"),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: 150.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                "Place Order",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
