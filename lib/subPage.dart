import 'dart:convert';

import 'package:BmiCalculator/login.dart';
import 'package:BmiCalculator/mainScreen.dart';
import 'package:BmiCalculator/verifyPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class SubscriptionPage extends StatelessWidget {
  final User user;
  String appId = "APP_118927";
  String password = "588f4a29c5d7f15d531f0fc09b65e81c";
  String mobile = "8801831164404";
  Map<String,dynamic> result = {};
  // String mobile = "8801779224826";


  SubscriptionPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subscription Page'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final phoneNumber = data['phone'] as String?;
            mobile = phoneNumber!;
            
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Center(
                    child: Column(
                      children: [
                        Text('Email: ${user.email ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                        Text('Phone: ${phoneNumber ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                        if (userDoc.exists) {
                                var subscriptionStatus = userDoc['subscription'] as bool;
                                if (subscriptionStatus) {
                                  
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => mainScreen(selectedClassification: "WHO", selectedWeight: "kg", selectedHeight: "cm", adultsOnly: false),
                                    ),
                                  );
                                  print('Logged in and subscription is active: ${user.email}');
                                } else {
                                  requestOtp();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OTPVerificationPage(phoneNumber: phoneNumber!,userId: user.uid,result: result,),
                                    ),
                                  );
                                }
                              } else {
                                // Handle the case where the user document does not exist
                                print('User document does not exist');
                                // showErrorDialog(context, 'User document does not exist');
                              }
                            },
                        
                        // Handle subscription logic
                       
    
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(250, 40), // Adjust the width and height here
                      ),
                      child: Text(
                        'Subscribe',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                          'subscription': false,
                        });
                        showSuccessDialog(context);
                        // Handle unsubscription logic
                        print('Unsubscribed');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(250, 40), // Adjust the width and height here
                      ),
                      child: Text(
                        'Unsubscribe',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Handle logout logic
                        await FirebaseAuth.instance.signOut();
                        // Navigate back to the login page or another screen
                        Navigator.pop(context); // Assuming this is a new screen pushed onto the navigator stack
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(250, 40), // Adjust the width and height here
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
  Future<void> requestOtp() async {
    final String reqUrl = "http://45.90.123.6:3000/nazmul/subscription/otp/request";
    final Map<String, dynamic> requestData = {
      'appId': appId,
      'password': password,
      'mobile': mobile,
    
    };
    try {
      final http.Response response = await http.post(
        Uri.parse(reqUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Handle successful response
        print('OTP request successful: $responseBody');
        print(responseBody['referenceNo']);
        result = responseBody;
        // Navigate to OTP verification page
      } else {
        // Handle error response
        print('Failed to request OTP: ${response.body}');
      }
    } catch (e) {
      // Handle exception
      print('Error requesting OTP: $e');
    }

  }
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Unsubscription is successful!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                ),
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
