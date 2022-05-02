import 'package:flutter/material.dart';
import 'src/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFFF0131E)),
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}
