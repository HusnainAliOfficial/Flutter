// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forget_Password extends StatefulWidget {
  @override
  _Forget_PasswordState createState() => _Forget_PasswordState();
}

class _Forget_PasswordState extends State<Forget_Password> {
  final TextEditingController _emailController = TextEditingController();

  void _sendResetEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);
      _showSuccessDialog();
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Email Sent'),
        content: Text(
            'A password reset email has been sent to ${_emailController.text}.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration:const InputDecoration(
                labelText: 'Enter your Email',
              ),
            ),
           const  SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendResetEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Background color
              ),
              child: const Text('Submit'),
              
            ),
          ],
        ),
      ),
    );
  }
}
