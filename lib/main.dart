import 'package:flutter/material.dart';
import 'package:shopat/global/colors.dart';
import 'package:shopat/screens/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
      ),
      home: HomePage(),
    );
  }
}
