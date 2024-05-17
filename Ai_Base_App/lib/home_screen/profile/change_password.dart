// ignore_for_file: library_private_types_in_public_api, camel_case_types, unused_field, use_build_context_synchronously, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/home_screen/profile.dart';
import 'package:project/signup_login/forget_password.dart';

class Chnage_Pasword extends StatefulWidget {
  const Chnage_Pasword({super.key});

  @override
  _Chnage_PaswordState createState() => _Chnage_PaswordState();
}

class _Chnage_PaswordState extends State<Chnage_Pasword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;
  String _error = '';

  void _showDialog(String Message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green,
        title: const Text('Change Password '),
        content: Text(Message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });
      try {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        throw FirebaseAuthException(
            message: 'Passwords do not match', code: '');
      }
      AuthCredential credential = EmailAuthProvider.credential(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: _currentPasswordController.text,
      );
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser!
          .updatePassword(_newPasswordController.text);

      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('login').doc(userId);
      await userDocRef.update({'password': _newPasswordController.text});
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        ),
      );
    } catch (e) {
      _showDialog(e.toString());
      setState(()
       {
        _error = e is FirebaseAuthException ? e.message! : 'An error occurred';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Color.fromARGB(255, 7, 153, 15),
                Color.fromARGB(255, 7, 153, 15),
                Color.fromARGB(255, 7, 153, 15),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 80),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Change Password",
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Change Password only possible if you know previous password",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 60),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255, 7, 153, 15),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 7, 153, 15),
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                controller: _currentPasswordController,
                                obscureText: false,
                                decoration: const InputDecoration(
                                  hintText: "Current Password ",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 7, 153, 15),
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                obscureText: true,
                                controller: _newPasswordController,
                                decoration: const InputDecoration(
                                  hintText: "New Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color.fromARGB(255, 7, 153, 15),
                                  ),
                                ),
                              ),
                              child: TextFormField(
                                obscureText: true,
                                controller: _confirmPasswordController,
                                decoration: const InputDecoration(
                                  hintText: "COnfirom New Password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Forget_Password(),
                          ),
                        ),
                        child: const Text(
                          'Forget Password ?',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: _changePassword,
                        height: 50,
                        color: const Color.fromARGB(255, 7, 153, 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
