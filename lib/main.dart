import 'package:flutter/material.dart';
import 'package:mytravaly_app/Login_Page/google_sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleSignInPage(),
    );
  }
}
