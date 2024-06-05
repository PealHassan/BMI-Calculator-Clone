import 'package:BmiCalculator/login.dart';
import 'package:BmiCalculator/verifyPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionPage extends StatelessWidget {
  final User user;

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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPVerificationPage(phoneNumber: phoneNumber!,userId: user.uid,),
                          ),
                        );
                        // Handle subscription logic
                        print('Subscribed');
                      },
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
