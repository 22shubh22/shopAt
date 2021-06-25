import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/global/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late String name, email, address;

  bool _isLoading = false;
  bool _isUpdating = false;

  Future<void> getProfileDetails() async {
    setState(() {
      _isLoading = true;
    });
    var pList = await FirestoreService().getProfileDetails();

    setState(() {
      _nameController.text = name = pList['name'];
      _emailController.text = email = pList['email'];
      _addressController.text = address = pList['address'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    getProfileDetails();
    super.initState();
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
                      'Profile',
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
            // Expanded(),
            _isLoading
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  )))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your name",
                            labelText: "Name",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF393D4699),
                            ),
                            labelStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF393D4699),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF393D4699),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: _nameController,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            labelText: "Email",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF393D4699),
                            ),
                            labelStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF393D4699),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF393D4699),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: _emailController,
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextField(
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Enter your address",
                            labelText: "Address",
                            hintStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: const Color(0xFF393D4699),
                            ),
                            labelStyle: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF393D4699),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF393D4699),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          controller: _addressController,
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      InkWell(
                        onTap: () async {
                          if (_nameController.text.length > 0 &&
                              _emailController.text.length > 0 &&
                              _addressController.text.length > 0) {
                            setState(() {
                              _isUpdating = true;
                            });
                            await FirestoreService().updateProfileDetails(
                              name: _nameController.text,
                              email: _emailController.text,
                              address: _addressController.text,
                            );
                            setState(() {
                              _isUpdating = false;
                            });
                            Navigator.of(context).pop('success');
                          } else {
                            BotToast.showText(text: "Details cannot be empty");
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _isUpdating
                                    ? Text(
                                        "Updating ....",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        "Update",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                        ),
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
      ),
    );
  }
}
