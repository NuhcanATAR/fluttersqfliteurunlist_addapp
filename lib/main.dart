import 'package:flutter/material.dart';
import 'package:sqflite_demo/screens/product_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     home: ProductList(),
   );
  }
}
