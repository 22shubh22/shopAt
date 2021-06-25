// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/cart_page.dart';
import 'package:shopat/screens/description_page.dart';
// import 'package:shopat/screens/login_page.dart';
import 'package:shopat/screens/place_order_page.dart';
import 'package:shopat/screens/profile_settings_page.dart';
import 'package:shopat/screens/wishlist_page.dart';
// import 'package:shopat/firebase_repository/firebase_repository.dart';
import 'package:shopat/widgets/productcard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final ProductsRepository _productsRepository = FirebaseProductRepository();

  final TextEditingController _searchController = TextEditingController();
  String? currentUser = AuthService().getUserId();

  bool _isListLoading = false;
  List<ProductEntity> productsList = [];

  int checkoutTotal = 0;
  updateCheckoutTotal(int total) {
    print("IIIIIIIIIIIIIIIIIIIIIIIIBBBBBBBBBBBBBBBBBBBBBBB");

    setState(() {
      checkoutTotal += total;
      print("IIIIIIIIIIIIIIIIIIIIIIII");
    });
  }

  Future<void> getProductsLocal() async {
    setState(() {
      _isListLoading = true;
    });
    var pList = await FirestoreService().getProductsList();
    print(pList);
    setState(() {
      _isListLoading = false;
      productsList = pList;
    });
  }

  @override
  void initState() {
    getProductsLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          "Shop At",
          style: TextStyle(
            fontFamily: "Righteous",
            fontWeight: FontWeight.w600,
            color: AppColors.accentColor,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WishListPage()));
            },
            icon: Icon(
              Icons.favorite_border_rounded,
              color: AppColors.accentColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.accentColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileSettingsPage(),
                ),
              );
            },
            icon: Icon(
              Icons.settings,
              color: AppColors.accentColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(
                fontFamily: "Poppins",
              ),
              decoration: InputDecoration(
                hintText: "Try searching something",
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: const Color(0xFF393D4699),
                ),
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[700],
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF393D4699),
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF393D4699),
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              controller: _searchController,
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "4,125 items",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.grey[800],
                  ),
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.grey[800],
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: _isListLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black),
                    ))
                  : RefreshIndicator(
                      onRefresh: getProductsLocal,
                      color: Colors.black,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: productsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var product = productsList[index];
                          return ProductCard(
                            imageUrl: product.image,
                            id: product.id.substring(16),
                            productName: product.productName,
                            productDescription: product.description1,
                            productDescription2: product.description2,
                            price: product.sellingPrice,
                            quantityAvailable: product.quantityAvailable,
                            onClick: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DescriptionPage(product)));
                            },
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PlaceOrder()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          width: 200.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                  ),
                ),
                Text(
                  " (₹ $checkoutTotal) ",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
    );
  }
}
