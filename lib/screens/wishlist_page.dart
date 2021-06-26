import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/entities/entities.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/firebase_repository/src/models/wishlist_item.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/description_page.dart';

class WishListPage extends StatefulWidget {
  WishListPage({Key? key}) : super(key: key);

  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  bool _isLoading = false;
  List<WishListItem> _wishListItems = [];

  Future<void> getWishList() async {
    setState(() {
      _isLoading = true;
    });

    _wishListItems = await FirestoreService().getUserWishList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getWishList();
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
                      'My Wishlist',
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
                  : _wishListItems.length == 0
                      ? Container(
                          alignment: Alignment.center,
                          child: Text(
                            "No items in your wishlist",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: getWishList,
                          color: Colors.black,
                          child: ListView.builder(
                              itemCount: _wishListItems.length,
                              itemBuilder: (context, index) {
                                WishListItem item = _wishListItems[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DescriptionPage(ProductEntity(
                                                  item.id,
                                                  item.productName,
                                                  item.shopId,
                                                  item.description1,
                                                  item.description2,
                                                  item.image,
                                                  item.costPrice,
                                                  item.sellingPrice,
                                                  item.quantityAvailable,
                                                  [],
                                                ))));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 12.0),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                      "₹ " +
                                                          "${item.sellingPrice}",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                    SizedBox(width: 48.0),
                                                    InkWell(
                                                      onTap: () async {
                                                        await FirestoreService()
                                                            .removeProductToWishList(
                                                                item.id);
                                                        getWishList();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC20A0A),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 12.0,
                                                            right: 12.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Remove',
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color(
                                                                      0xFFF6F7FB),
                                                                ),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .delete_outline,
                                                                color: Color(
                                                                    0xFFF6F7FB),
                                                              ),
                                                            ],
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
