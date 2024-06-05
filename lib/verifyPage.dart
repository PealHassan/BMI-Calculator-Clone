import 'package:BmiCalculator/login.dart';
import 'package:BmiCalculator/mainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String userId;
  final Map<String,dynamic> result;
  OTPVerificationPage({required this.phoneNumber, required this.userId, required this.result});
  

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();
  String appId = "APP_118927";
  String password = "588f4a29c5d7f15d531f0fc09b65e81c";
  String mobile = "8801831164404";

  // Method to verify OTP
  Future<void> _verifyOTP() async {
    String enteredOTP = _otpController.text.trim();
    String verUrl = "http://45.90.123.6:3000/nazmul/subscription/otp/verify";
    final Map<String, dynamic> requestData = {
      'appId': appId,
      'password': password,
      'referenceNo': widget.result['referenceNo'],
      'otp': enteredOTP,
    
    };
    final http.Response response = await http.post(
        Uri.parse(verUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
    );
    
    // print(response);
    try {
    if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        // Handle successful response
        print('OTP match request successful: $responseBody');
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('OTP Info'),
          content: Text(responseBody['statusDetail']),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
                  'subscription': true,
                });
                // Close the dialog
                Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                );
                // Navigate to the next screen
                // Replace SubscriptionPage() with your desired destination
                
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
        // Navigate to OTP verification page
      } else {
        // Handle error response
        print('Failed to match request OTP: ${response.body}');
      }
    } catch (e) {
      // Handle exception
      print('Error requesting OTP: $e');
    }

    

    // Implement OTP verification logic here
    print('Entered OTP: $enteredOTP');
    // For demo purposes, let's assume OTP verification is successful
    // You can replace this with actual OTP verification logic
    // if (enteredOTP == '123456') {

      
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the OTP sent to ${widget.phoneNumber}',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: Size(200, 40), // Adjust the width and height here
              ),
              onPressed: _verifyOTP,
              child: Text('Verify OTP', style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}