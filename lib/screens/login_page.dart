import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/firebase_repository/src/firestore_service.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/home_page.dart';
import 'package:shopat/widgets/black_oval_button.dart';
import 'package:shopat/widgets/login_text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  late String verificationId, smsCode;
  bool codeSent = false;
  bool _isOtpSending = false;
  bool _isLoginLoading = false;

  @override
  void initState() {
    super.initState();
    AuthService().isUserLoggedIn();
  }

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
              'Bilaspur Stores',
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
              controller: _phoneCont,
              hint: "Eg: 9876543210",
              textInputType: TextInputType.number,
              trailingActionWidget: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _isOtpSending
                    ? InkWell(
                        onTap: () {
                          BotToast.showText(
                              text: "Please wait while we send OTP");
                        },
                        child: Text(
                          'Sending .....',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          if (_phoneCont.text.trim().length == 10) {
                            print("I am here00");
                            setState(() {
                              _isOtpSending = true;
                            });
                            await verifyPhone("+91" + _phoneCont.text);
                            print("I am here00");
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
                        onPressedAction: () async {
                          // AuthService()
                          //     .signInWithOTP(_passwordCont.text, verificationId);
                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(),
                          //   ),
                          // );
                          setState(() {
                            _isLoginLoading = true;
                          });
                          if (AuthService().getUserId() != null) {
                            await Future.delayed(
                                Duration(seconds: 1, milliseconds: 500));
                            await FirestoreService().getUserByPhone(
                                "+91" + _phoneCont.text,
                                AuthService().getUserId());
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false);
                          } else {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                verificationId: verificationId,
                                smsCode: _passwordCont.text.trim(),
                              ))
                                  .then((value) async {
                                if (value.user != null) {
                                  await FirestoreService().getUserByPhone(
                                      "+91" + _phoneCont.text,
                                      AuthService().getUserId());
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                      (route) => false);
                                }
                              });
                            } catch (e) {
                              BotToast.showText(text: "Invalid OTP");
                            }
                          }

                          setState(() {
                            _isLoginLoading = false;
                          });
                        },
                      )
                : Container(),
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

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
      setState(() {
        _isOtpSending = false;
      });
      BotToast.showText(text: '${authException.message}');
    };

    final PhoneCodeSent codeSent = (String verId, int? forceResend) {
      setState(() {
        this.codeSent = true;
        verificationId = verId;
        _isOtpSending = false;
      });
      BotToast.showText(text: "OTP sent succesfully");
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
        verificationId = verId;
      });
    };
    print(phoneNo);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
