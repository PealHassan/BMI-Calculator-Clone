
import 'package:bmicalculator/mainScreen.dart';
import 'package:flutter/material.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      home: mainScreen(selectedClassification: "WHO", selectedWeight: "kg", selectedHeight: "cm", adultsOnly: false),
    );
  }
}

