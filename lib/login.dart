import 'package:BmiCalculator/mainScreen.dart';
import 'package:BmiCalculator/register.dart';
import 'package:BmiCalculator/register.dart';
import 'package:BmiCalculator/subPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            isLogin?CircularProgressIndicator():
            ElevatedButton(
              
              onPressed: () async {
                setState(() {
                  isLogin = true;
                });
                print(isLogin);
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  if (userCredential.user != null) {
                    User user = userCredential.user!;
                    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubscriptionPage(user: user),
                          ),
                    );
                  }
                  else {
                    // Handle the case where userCredential.user is null
                    print('User is null');
                    showErrorDialog(context, 'User is null');
                  }
                } on FirebaseAuthException catch (e) {
                  // Handle login error
                  showErrorDialog(context, e.message ?? 'Failed to login');
                  print('Failed to login: $e');
                } catch (e) {
                  // Handle any other errors
                  showErrorDialog(context, 'An unexpected error occurred');
                  print('An unexpected error occurred: $e');
                }
                setState(() {
                  isLogin = false;
                });
              },

              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Don\'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
