// ignore_for_file: camel_case_types, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:project/models/speech_text.dart';
import 'package:project/models/text_generate.dart';
import 'package:project/models/text_speech.dart';

class Models_list extends StatelessWidget {
  final List<String> classNames = [
    'Generate_Chat',
    'Speech_text',
    'text_speech'
  ];
  final List<String> classText = [
    'Enter an Prompt in the foam of text Then press Enter button Our Model Generate an output on Screen ',
    'Press the Speech button on the below on Screen Then Speck something in Mic the data written in the Above Field',
    'Enter text in input Field the press speak button then you can hear audio from speaker directly and you can match audio with input text '
  ];

  Models_list({super.key}); // Add more class names here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Models List',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 7, 153, 15),
      ),
      backgroundColor: Colors.grey,
      body: ListView.builder(
        itemCount: classNames.length,
        itemBuilder: (context, index) {
          const SizedBox(
            height: 30,
          );
          return GestureDetector(
            onTap: () {
              String className = classNames[index];
             // String classText = classNames[index];
              navigateToClass(context, className);
            },
            child: Card(
               color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      classNames[index], // Title
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(
                        height: 10), // Add some space between title and text
                    Text(
                      classText[index], // Text below title
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              elevation: 4, // Add elevation for a shadow effect
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
               
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToClass(BuildContext context, String className) {
    switch (className) {
      case 'Generate_Chat':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Generate_Text()),
        );
        break;
      case 'Speech_text':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SpeechScreen()),
        );
        break;
      case 'text_speech':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Text_Speech()),
        );
        break;

      default:
        break;
    }
  }
}
