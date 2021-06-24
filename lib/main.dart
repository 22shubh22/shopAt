import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/home_page.dart';
// import 'package:shopat/screens/home_page.dart';
import 'package:shopat/screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
      ),
      home: AuthService().getUserId() != null ? HomePage() : LoginPage(),
    );
  }
}
