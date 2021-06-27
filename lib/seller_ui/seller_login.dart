import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/widgets/black_oval_button.dart';
import 'package:shopat/widgets/login_text_field.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({Key? key}) : super(key: key);

  @override
  _SellerLoginState createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  final TextEditingController _phoneCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  late String verificationId, smsCode;
  bool codeSent = false;
  bool _isOtpSending = false;
  bool _isLoginLoading = false;
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
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset('assets/images/lockCenter.png'),
            ),
            SizedBox(height: 54.0),
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
            Text(
              'Seller App',
              style: GoogleFonts.righteous(
                textStyle: TextStyle(
                  fontSize: 16.0,
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
              controller: _phoneCont,
              hint: "Eg: 9876543210",
              textInputType: TextInputType.number,
              trailingActionWidget: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _isOtpSending
                    ? Text(
                        'Sending .....',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          if (_phoneCont.text.trim().length == 10) {
                            BotToast.showText(text: "Nice mobile number");
                          } else {
                            BotToast.showText(
                                text: "Mobile number should be 10 digits");
                          }
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
              hint: "Enter OTP sent to your number",
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: 16.0,
            ),
            codeSent && _passwordCont.text.isNotEmpty
                ? _isLoginLoading
                    ? BlackOvalButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "Please wait .....",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                          ],
                        ),
                        onPressedAction: () {},
                      )
                    : BlackOvalButton(
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
                        onPressedAction: () async {},
                      )
                : Container(),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Please login to sell your products, you will be registered if not already registered.",
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
