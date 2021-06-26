import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/global/colors.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String id;
  final String productName;
  final String productDescription;
  final String productDescription2;
  final int price;
  final int quantityAvailable;
  final Function() onClick;
  final ProductEntity productEntity;
  final int notOfItems;

  ProductCard({
    Key? key,
    required this.imageUrl,
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.productDescription2,
    required this.price,
    required this.onClick,
    required this.quantityAvailable,
    required this.productEntity,
    required this.notOfItems,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var quantitySelect = 0;
  bool _isItemAdding = false;
  @override
  void initState() {
    quantitySelect = widget.notOfItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isItemAdding,
      child: GestureDetector(
        onTap: widget.onClick,
        child: Container(
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
                Image.network(
                  widget.imageUrl,
                  height: 80.0,
                  width: 80.0,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.productDescription,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.productDescription2,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14.0,
                        color: Colors.grey[400],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text(
                          "₹" + widget.price.toString(),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 36.0),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: AppColors.accentColor,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              setState(() {
                                _isItemAdding = true;
                              });
                              if (quantitySelect >= 1) {
                                bool isItemAdded =
                                    await FirestoreService().isItemAddedToCart(
                                  widget.productEntity.id,
                                );
                                print("Is Item Added : $isItemAdded");
                                if (isItemAdded) {
                                  int itemCount = quantitySelect - 1;
                                  if (itemCount == 0) {
                                    var result = await FirestoreService()
                                        .removeItemFromCartList(
                                      widget.productEntity.id,
                                    );
                                    if (result['res'] == true) {
                                      setState(() {
                                        quantitySelect--;
                                      });
                                    }
                                  } else {
                                    var result = await FirestoreService()
                                        .updateItemFromCartList(
                                      widget.productEntity.id,
                                      itemCount,
                                    );
                                    if (result['res'] == true) {
                                      setState(() {
                                        quantitySelect--;
                                      });
                                    }
                                  }
                                } else {}
                              } else {
                                BotToast.showText(
                                    text: "Quantity cannot be negative");
                              }
                              setState(() {
                                _isItemAdding = false;
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          "X${quantitySelect.toString()}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: AppColors.accentColor,
                          ),
                          child: IconButton(
                            onPressed: () async {
                              setState(() {
                                _isItemAdding = true;
                              });
                              if (quantitySelect < widget.quantityAvailable) {
                                bool isItemAdded =
                                    await FirestoreService().isItemAddedToCart(
                                  widget.productEntity.id,
                                );
                                print("Is Item Added : $isItemAdded");
                                if (isItemAdded) {
                                  int itemCount = quantitySelect + 1;
                                  var result = await FirestoreService()
                                      .updateItemFromCartList(
                                    widget.productEntity.id,
                                    itemCount,
                                  );
                                  if (result['res'] == true) {
                                    setState(() {
                                      quantitySelect++;
                                    });
                                  }
                                } else {
                                  int itemCount = quantitySelect + 1;
                                  var result = await FirestoreService()
                                      .addProductToCartList(
                                    widget.productEntity,
                                    itemCount,
                                  );
                                  if (result['res'] == true) {
                                    setState(() {
                                      quantitySelect++;
                                    });
                                  }
                                }
                              } else {
                                BotToast.showText(
                                    text:
                                        "Maximum quantity limit per item reached");
                              }
                              setState(() {
                                _isItemAdding = false;
                              });
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
