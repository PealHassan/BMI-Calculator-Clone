import 'package:BmiCalculator/mainScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OTPVerificationPage extends StatefulWidget {
  final String phoneNumber;
  final String userId;

  OTPVerificationPage({required this.phoneNumber, required this.userId});
  

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final TextEditingController _otpController = TextEditingController();

  // Method to verify OTP
  void _verifyOTP() {
    String enteredOTP = _otpController.text.trim();
    // Implement OTP verification logic here
    print('Entered OTP: $enteredOTP');
    // For demo purposes, let's assume OTP verification is successful
    // You can replace this with actual OTP verification logic
    if (enteredOTP == '123456') {
      // If OTP is correct, show a success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('OTP Verified'),
          content: Text('OTP verification successful!'),
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
                            builder: (context) => mainScreen(selectedClassification: "WHO", selectedWeight: "kg", selectedHeight: "cm", adultsOnly: false),
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
    } else {
      // If OTP is incorrect, show an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Invalid OTP. Please try again.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
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