import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/firebase_repository/src/models/cart_item.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/widgets/chip.dart';
import 'package:shopat/widgets/order_card.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  bool _isLoading = false;
  List<Map<String, dynamic>> ordersList = [];

  @override
  void initState() {
    getOrderDetails();
    super.initState();
  }

  getOrderDetails() async {
    setState(() {
      _isLoading = true;
    });
    ordersList = await FirestoreService().getUserOrders();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
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
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'My Orders',
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
            _isLoading
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  )
                : ordersList.length == 0
                    ? Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No orders to show",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            // SizedBox(
                            //   height: 16.0,
                            // ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     ChipWidget(
                            //       chipText: "  All  ",
                            //       isActive: true,
                            //     ),
                            //     ChipWidget(
                            //       chipText: " Delivered ",
                            //       isActive: false,
                            //     ),
                            //     ChipWidget(
                            //       chipText: " Cancelled ",
                            //       isActive: false,
                            //     ),
                            //     ChipWidget(
                            //       chipText: " Pending ",
                            //       isActive: false,
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: ordersList.length,
                                  itemBuilder: (context, index) {
                                    CartItem cartItem = ordersList[index]['cartItems'][0];
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: OrderCardWidget(
                                        title: 
                                        ordersList[index]['totalItems'] > 1 ?
                                        "${cartItem.productName} + ${ordersList[index]['totalItems'] -1} items" : "${cartItem.productName}",
                                        cost: ordersList[index]['totalBillAmount'],
                                        date: DateFormat('yMMMd').format(DateTime.parse(ordersList[index]['createdAt'])),
                                        orderStatus: ordersList[index]['status'],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
