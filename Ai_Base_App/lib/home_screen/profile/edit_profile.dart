// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/home_screen/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfile> {
  late String _uid;
  late String _name;
  Uint8List? _image;
  final TextEditingController _nameController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  @override
  void initState() {
    super.initState();
    _fetchUid();
  }

  Future<void> _fetchUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _uid = prefs.getString('uid') ?? '';
    });
    if (_uid.isNotEmpty) {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('login').doc(_uid).get();

    setState(() {
      _name = snapshot.data()?['name'] ?? '';
      _image = snapshot.data()?['image'] ?? '';
    });
    _nameController.text = _name;
  }

  Future<void> _updateUserData() async {
     String imageUrl = await uploadImageToStorage(_uid, _image!);
    await FirebaseFirestore.instance.collection('login').doc(_uid).update({
      'name': _name,
      'image': imageUrl
    });
     Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }

  
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 153, 15),
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: _updateUserData,
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage('assets/profile.jpeg'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              onChanged: (value) => _name = value,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ],
        ),
      ),
    );
  }
}
