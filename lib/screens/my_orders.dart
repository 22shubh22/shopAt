import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/firebase_repository/src/models/cart_item.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/my_order_details.dart';
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

  String _chipSelected = "all";

  @override
  void initState() {
    getOrderDetails();
    super.initState();
  }

  Future<void> getOrderDetails() async {
    setState(() {
      _isLoading = true;
    });
    ordersList = await FirestoreService().getUserOrders();
    setState(() {
      _isLoading = false;
    });
  }

  bool toShowOrder(String status) {
    if (_chipSelected == 'all') {
      return true;
    } else if (_chipSelected == 'delivered') {
      return status == 'Delivered';
    } else if (_chipSelected == 'cancelled') {
      return status == 'Cancelled';
    } else if (_chipSelected == 'pending') {
      return status == 'Pending';
    } else if (_chipSelected == 'ready') {
      return status == 'Ready';
    } else {
      return true;
    }
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
                        child: RefreshIndicator(
                          color: Colors.black,
                          onRefresh: getOrderDetails,
                          child: ListView(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                alignment: Alignment.center,
                                child: Text(
                                  "No orders to show",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 16.0,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _chipSelected = 'all';
                                        });
                                      },
                                      child: ChipWidget(
                                        chipText: "  All  ",
                                        isActive: _chipSelected == 'all',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _chipSelected = 'pending';
                                        });
                                      },
                                      child: ChipWidget(
                                        chipText: " Pending ",
                                        isActive: _chipSelected == 'pending',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _chipSelected = 'ready';
                                        });
                                      },
                                      child: ChipWidget(
                                        chipText: " Ready ",
                                        isActive: _chipSelected == 'ready',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _chipSelected = 'delivered';
                                        });
                                      },
                                      child: ChipWidget(
                                        chipText: " Delivered ",
                                        isActive: _chipSelected == 'delivered',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _chipSelected = 'cancelled';
                                        });
                                      },
                                      child: ChipWidget(
                                        chipText: " Cancelled ",
                                        isActive: _chipSelected == 'cancelled',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24.0,
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                color: Colors.black,
                                onRefresh: getOrderDetails,
                                child: ListView.builder(
                                    itemCount: ordersList.length,
                                    itemBuilder: (context, index) {
                                      CartItem cartItem =
                                          ordersList[index]['cartItems'][0];
                                      return toShowOrder(
                                              ordersList[index]['status'])
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyOrderDetails(
                                                      cartsList:
                                                          ordersList[index]
                                                              ['cartItems'],
                                                      date: DateFormat('yMMMd')
                                                          .format(DateTime
                                                              .parse(ordersList[
                                                                      index][
                                                                  'createdAt'])),
                                                      status: ordersList[index]
                                                          ['status'],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                child: OrderCardWidget(
                                                  title: ordersList[index]
                                                              ['totalItems'] >
                                                          1
                                                      ? "${cartItem.productName} + ${ordersList[index]['totalItems'] - 1} items"
                                                      : "${cartItem.productName}",
                                                  cost: ordersList[index]
                                                      ['totalBillAmount'],
                                                  date: DateFormat('yMMMd')
                                                      .format(DateTime.parse(
                                                          ordersList[index]
                                                              ['createdAt'])),
                                                  orderStatus: ordersList[index]
                                                      ['status'],
                                                  orderId: ordersList[index]
                                                      ['orderId'],
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }),
                              ),
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
