import 'package:flutter/material.dart';
import 'package:restapi/view/photo/photo.dart';
import 'package:restapi/view/user/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "New flutter application",
      home: User(),
    );
  }
}