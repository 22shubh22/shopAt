// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/global/colors.dart';
// import 'package:shopat/screens/place_order_page.dart';

class DescriptionPage extends StatefulWidget {
  final ProductEntity _product;

  DescriptionPage(this._product);

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool _isLoading = false;

  bool _isItemAddedToWishlist = false;
  @override
  void initState() {
    super.initState();
    checkItem();
  }

  checkItem() async {
    setState(() {
      _isLoading = true;
    });

    bool _isAdded =
        await FirestoreService().isItemWishListed(widget._product.id);
    if (_isAdded) {
      setState(() {
        _isLoading = false;
        _isItemAddedToWishlist = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isItemAddedToWishlist = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Stack(
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
                              "${widget._product.image}",
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: double.infinity,
                              fit: BoxFit.contain,
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
                                _isItemAddedToWishlist
                                    ? InkWell(
                                        onTap: () async {
                                          await FirestoreService()
                                              .removeProductToWishList(
                                                  widget._product.id);

                                          _isItemAddedToWishlist =
                                              await FirestoreService()
                                                  .isItemWishListed(
                                                      widget._product.id);
                                          setState(() {});
                                        },
                                        child: Container(
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
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          await FirestoreService()
                                              .addProductToWishList(
                                                  widget._product);

                                          _isItemAddedToWishlist =
                                              await FirestoreService()
                                                  .isItemWishListed(
                                                      widget._product.id);
                                          setState(() {});
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 16.0),
                                          height: 45.0,
                                          width: 45.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 1.5,
                                              color:
                                                  Colors.grey.withOpacity(0.50),
                                            ),
                                          ),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.favorite,
                                            color:
                                                Colors.grey.withOpacity(0.50),
                                          ),
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
                                    color:
                                        AppColors.accentColor.withOpacity(0.60),
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
