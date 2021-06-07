import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/cart_page.dart';
import 'package:shopat/screens/description_page.dart';
import 'package:shopat/screens/place_order_page.dart';
import 'package:shopat/screens/profile_settings_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
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
              ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DescriptionPage()));
                    },
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
                                  "Flutter Logo",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  "This is official Flutter Logo",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  "Size : 40",
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
                                      "₹ 500/-",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(width: 36.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: AppColors.accentColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " x01 ",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        color: AppColors.accentColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
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
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
              )
            ],
          ),
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
                  " (₹ 500) ",
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
