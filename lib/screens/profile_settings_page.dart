import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/my_orders.dart';
import 'package:shopat/screens/profile.dart';
import 'package:shopat/screens/wishlist_page.dart';

import 'login_page.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({Key? key}) : super(key: key);

  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool _isLoading = false;
  late String name, email;

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  getProfileDetails() async {
    setState(() {
      _isLoading = true;
    });
    var details = await FirestoreService().getProfileDetails();
    setState(() {
      name = details['name'];
      email = details['email'];
      _isLoading = false;
    });
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
                      'Profile & Settings',
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
                  ))
                : Expanded(
                    child: Column(
                      children: [
                        SizedBox(height: 16.0),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '${AuthService().getPhoneNumber()?.substring(3)}',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '$name',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.70),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            '$email',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.70),
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 14.0),
                        Divider(
                          color: AppColors.accentColor.withOpacity(0.15),
                          height: 0.5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyOrdersPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                top: 24.0,
                                bottom: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'My Orders',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Icon(Icons.chevron_right_outlined),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.accentColor.withOpacity(0.15),
                          height: 0.5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WishListPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                top: 24.0,
                                bottom: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'My Wishlist',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Icon(Icons.chevron_right_outlined)
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.accentColor.withOpacity(0.15),
                          height: 0.5,
                        ),
                        InkWell(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfilePage(),
                              ),
                            );

                            if (result == "success") {
                              getProfileDetails();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                top: 24.0,
                                bottom: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Change Profile & Address',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Icon(Icons.chevron_right_outlined)
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.accentColor.withOpacity(0.15),
                          height: 0.5,
                        ),
                        InkWell(
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            while (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0,
                                right: 24.0,
                                top: 24.0,
                                bottom: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.accentColor.withOpacity(0.15),
                          height: 0.5,
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
