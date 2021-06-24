import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopat/firebase_repository/auth.dart';
import 'package:shopat/global/colors.dart';
// import 'package:shopat/screens/home_page.dart';
import 'package:shopat/screens/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
      ),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Some Error occured'));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return AuthService().handleAuth();
            }
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: Center(
                child: Column(
                  children: [
                    Image.asset('images/adaptive_icon.png'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
