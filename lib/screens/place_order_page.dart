import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/firebase_repository/src/models/cart_item.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/home_page.dart';
import 'package:shopat/widgets/separator.dart';

class PlaceOrder extends StatefulWidget {
  final List<CartItem> cartsList;
  const PlaceOrder({
    Key? key,
    required this.cartsList,
  }) : super(key: key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  int totalItems = 0;
  int totalAmount = 0;
  bool _isLoading = false;
  String address = "";

  bool _isPlacingOrder = false;
  @override
  void initState() {
    calculatingTheCosts(widget.cartsList);
    super.initState();
  }

  calculatingTheCosts(List<CartItem> cartsList) async {
    setState(() {
      _isLoading = false;
    });
    int tempItems = 0, tempTotal = 0;
    for (var i in cartsList) {
      tempItems = tempItems + i.numberOfItems;
      tempTotal = tempTotal + (i.numberOfItems * i.sellingPrice);
    }
    var s = await FirestoreService().getProfileDetails();
    setState(() {
      address = s['address'];
      totalItems = tempItems;
      totalAmount = tempTotal;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'Place Order',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            _isLoading
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  )))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          strokeWidth: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  children: widget.cartsList.map((item) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${item.productName}",
                                              style: TextStyle(
                                                  fontFamily: "Poppins"),
                                            ),
                                            Text(
                                              "${item.numberOfItems} x ₹${item.sellingPrice}",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 8.0),
                                MySeparator(),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total items",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "$totalItems",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Net total",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "₹$totalAmount",
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Your savings",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "₹ 0",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Payable Amount",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "₹$totalAmount",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                MySeparator(),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Billing Address",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "$address",
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
          ],
        ),
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
          _isPlacingOrder
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Placing Order ....",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    setState(() {
                      _isPlacingOrder = true;
                    });
                    var result = await FirestoreService().addNewOrder(
                      widget.cartsList,
                      totalAmount,
                      totalItems,
                    );
                    if (result['res'] == true) {
                      setState(() {
                        _isPlacingOrder = false;
                      });

                      while (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.40,
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
                ),
        ],
      ),
    );
  }
}
