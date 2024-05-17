import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/signup_login/login.dart';
import 'firebase/firebase.dart';

void main() async 
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: android);

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Login()));
}
