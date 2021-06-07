import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/home_page.dart';
import 'package:shopat/widgets/black_oval_button.dart';
import 'package:shopat/widgets/login_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _usernameCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/Lock.png'),
            ),
            SizedBox(height: 45.0),
            Text(
              'Shop At',
              style: GoogleFonts.righteous(
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'Phone number',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginTextField(
              controller: _usernameCont,
              hint: "Eg: 9876543210",
              trailingActionWidget: Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {
                    print(" \n\n TODO: put the send otp action here. \n\n");
                  },
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'OTP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginTextField(
              controller: _passwordCont,
              hint: "Enter  OTP sent to your number",
            ),
            SizedBox(
              height: 16.0,
            ),
            BlackOvalButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                ],
              ),
              onPressedAction: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Please login to get Started, you will be registered if not already registered.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.accentColor.withOpacity(0.60),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }
}
