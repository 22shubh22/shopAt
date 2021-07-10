// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/firebase_repository/src/models/cart_item.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/cart_page.dart';
import 'package:shopat/screens/description_page.dart';
// import 'package:shopat/screens/login_page.dart';
// import 'package:shopat/screens/place_order_page.dart';
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
  List<ProductEntity> productsFilteredList = [];
  List<CartItem> cartList = [];

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
    var cList = await FirestoreService().getUsercartList();
    print(pList);
    setState(() {
      _isListLoading = false;
      productsList = pList;
      productsFilteredList = pList;
      cartList = cList;
    });
  }

  filterProducts(String query) {
    productsFilteredList = [];

    for (var i in productsList) {
      bool _inTags = false;
      for (var i in i.tags) {
        if (i.toLowerCase().contains(query)) {
          _inTags = true;
          break;
        }
      }
      if (i.productName.toLowerCase().contains(query) || _inTags) {
        productsFilteredList.add(i);
      }
    }
    setState(() {});
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
            onPressed: () async {
              var result = await Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
              if (result == "success") {
                getProductsLocal();
              }
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
                hintText: "Search Tag",
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  color: const Color(0xFF393D4699),
                ),
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[700],
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      productsFilteredList = productsList;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.grey[700],
                  ),
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
              onChanged: (String query) {
                filterProducts(query.toLowerCase());
              },
              controller: _searchController,
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${productsFilteredList.length} items",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.grey[800],
                  ),
                ),
                // GestureDetector(
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.filter_alt_outlined,
                //         color: Colors.grey[800],
                //       ),
                //       SizedBox(
                //         width: 4.0,
                //       ),
                //       Text(
                //         "Filter",
                //         style: TextStyle(
                //           fontFamily: "Poppins",
                //           color: Colors.grey[800],
                //         ),
                //       ),
                //     ],
                //   ),
                // )
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
                        itemCount: productsFilteredList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          int notOfItems = 0;
                          var product = productsFilteredList[index];
                          for (var i in cartList) {
                            if (i.id == product.id) {
                              notOfItems = i.numberOfItems;
                            }
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ProductCard(
                              imageUrl: product.image,
                              id: product.id,
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
                              productEntity: product,
                              notOfItems: notOfItems,
                            ),
                          );
                        },
                      ),
                    ),
            ),
            SizedBox(
              height: 42.0,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () async {
          var result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
          if (result == "success") {
            getProductsLocal();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Visit Cart",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.white,
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
