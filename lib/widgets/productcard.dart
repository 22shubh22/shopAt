import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class ProductCard extends StatefulWidget {
  final String imageUrl;
  final String id;
  final String productName;
  final String productDescription;
  final String productDescription2;
  final int price;
  final Function() onClick;

  ProductCard(
      {Key? key,
      required this.imageUrl,
      required this.id,
      required this.productName,
      required this.productDescription,
      required this.productDescription2,
      required this.price,
      required this.onClick})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  var quantitySelect = 1;
  // TODO: give me + and - as working component

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
              FlutterLogo(size: 80.0),
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          color: AppColors.accentColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                if (quantitySelect >= 1) {
                                  setState(() {
                                    quantitySelect--;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        quantitySelect.toString(),
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
                            child: IconButton(
                              onPressed: () {
                                // TODO: max_select is currently five
                                if (quantitySelect <= 5) {
                                  setState(() {
                                    quantitySelect++;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
