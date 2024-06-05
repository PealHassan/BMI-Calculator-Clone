
import 'package:BmiCalculator/login.dart';
import 'package:BmiCalculator/mainScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
      apiKey: 'AIzaSyAX7a5LzGTdfEcGc7WmC1OjtjyjIDD_sII',
      appId: '1:336465793966:android:766e2c81cbe7dbb9f56e3f',
      messagingSenderId: '336465793966',
      projectId: 'bmi-calculator-52fe2',
      storageBucket: 'bmi-calculator-52fe2.appspot.com',
    )
  );
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
      home : LoginPage(),
      // home: mainScreen(selectedClassification: "WHO", selectedWeight: "kg", selectedHeight: "cm", adultsOnly: false),
    );
  }
}

