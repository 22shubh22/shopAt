import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({Key? key}) : super(key: key);

  @override
  _SellerHomeState createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Shop At",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontWeight: FontWeight.w400,
                                color: AppColors.accentColor,
                                fontSize: 26.0,
                              ),
                            ),
                            Text(
                              "Seller App",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontWeight: FontWeight.w400,
                                color: AppColors.accentColor,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Icon(
                          Icons.logout_outlined,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Order requests",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu_rounded,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Your submissions",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_box_outlined,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Submit a product",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home_outlined,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Inventory",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Your Profile",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.17,
                        width: MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Contact Admin",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
