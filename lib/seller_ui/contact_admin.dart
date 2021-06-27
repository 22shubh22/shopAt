import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';

class ContactAdmin extends StatefulWidget {
  const ContactAdmin({Key? key}) : super(key: key);

  @override
  _ContactAdminState createState() => _ContactAdminState();
}

class _ContactAdminState extends State<ContactAdmin> {
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
                      'Contact Admin',
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
            Expanded(
              child: Column(
                children: [
                  SizedBox(height: 16.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Veere Badra',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      '+91 9639891011',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
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
                              Icons.phone_outlined,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "Call",
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
                              Icons.whatshot_sharp,
                              color: Color(0XFF130F26),
                              size: 40,
                            ),
                            SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              "WhatsApp",
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
