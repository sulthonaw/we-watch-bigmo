import 'package:flutter/material.dart';
import 'package:narabuna/pages/chatbot/chatbot_page.dart';
import 'package:narabuna/pages/home/home_page.dart';
import 'package:narabuna/pages/kondisi/kondisi_page.dart';
import 'package:narabuna/pages/login/login_page.dart';
import 'package:narabuna/pages/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Narabuna',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SFProDisplay'),
      home: LoginPage(),
    );
  }
}
