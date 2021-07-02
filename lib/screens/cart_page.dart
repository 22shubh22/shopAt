import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/firebase_repository/src/models/cart_item.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/place_order_page.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool _isLoading = false;
  List<CartItem> _cartListItems = [];

  Future<void> getCartList() async {
    setState(() {
      _isLoading = true;
    });

    _cartListItems = await FirestoreService().getUsercartList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlaceOrder(
                  cartsList: _cartListItems,
                ),
              ));
        },
        child: _cartListItems.length > 0
            ? Container(
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
                        "Checkout",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      ),
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
                        //Navigator.of(context).pop("success");
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'My Cart',
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
            Expanded(
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : _cartListItems.length == 0
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No items in your cart",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: getCartList,
                          color: Colors.black,
                          child: ListView.builder(
                              itemCount: _cartListItems.length,
                              itemBuilder: (context, index) {
                                CartItem item = _cartListItems[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(24.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    item.image,
                                                    height: 80.0,
                                                    width: 80.0,
                                                    fit: BoxFit.contain,
                                                  ),
                                                  SizedBox(width: 20.0),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${item.productName}",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              Text(
                                                "${item.description1}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14.0,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                              SizedBox(height: 4.0),
                                              Text(
                                                "${item.description2}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 14.0,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                              SizedBox(height: 8.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    // "₹ " +
                                                    //     "${item.sellingPrice}  X  ${item.numberOfItems}",
                                                    "₹ " +
                                                        "${item.sellingPrice}",
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  SizedBox(width: 32.0),
                                                  Text(
                                                    "No of items: ${item.numberOfItems}",
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () async {
                                                  //     var result =
                                                  //         await FirestoreService()
                                                  //             .removeItemFromCartList(
                                                  //       item.id,
                                                  //     );
                                                  //     if (result['res'] ==
                                                  //         true) {
                                                  //       getCartList();
                                                  //     }
                                                  //   },
                                                  //   child: Container(
                                                  //     decoration: BoxDecoration(
                                                  //       color:
                                                  //           Color(0xFFC20A0A),
                                                  //       borderRadius:
                                                  //           BorderRadius
                                                  //               .circular(50.0),
                                                  //     ),
                                                  //     child: Padding(
                                                  //       padding:
                                                  //           const EdgeInsets
                                                  //               .only(
                                                  //         left: 12.0,
                                                  //         right: 12.0,
                                                  //         top: 8.0,
                                                  //         bottom: 8.0,
                                                  //       ),
                                                  //       child: Row(
                                                  //         children: [
                                                  //           Text(
                                                  //             'Remove',
                                                  //             style: TextStyle(
                                                  //               fontFamily:
                                                  //                   "Poppins",
                                                  //               fontSize: 14.0,
                                                  //               fontWeight:
                                                  //                   FontWeight
                                                  //                       .w400,
                                                  //               color: Color(
                                                  //                   0xFFF6F7FB),
                                                  //             ),
                                                  //           ),
                                                  //           Icon(
                                                  //             Icons
                                                  //                 .delete_outline,
                                                  //             color: Color(
                                                  //                 0xFFF6F7FB),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
