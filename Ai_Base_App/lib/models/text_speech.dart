// ignore_for_file: camel_case_types, use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Text_Speech extends StatefulWidget 
{
  const Text_Speech({Key? key}) : super(key: key);

  @override
  _Text_SpeechScreenState createState() => _Text_SpeechScreenState();
}

class _Text_SpeechScreenState extends State<Text_Speech> 
{
  FlutterTts flutterTts = FlutterTts();
  TextEditingController textEditingController = TextEditingController();
  bool isSpeaking = false;

  @override
  void initState() 
  {
    super.initState();
    flutterTts.setLanguage("en-US");
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(



      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 153, 15),
        centerTitle: true,
        title:const Text(
          'Text to Speech',
          textAlign: TextAlign.center,
          style:TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
       backgroundColor: Colors.grey,

      body: Padding(
        padding: const EdgeInsets.all(16.0),


        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[


            Container(
                padding:const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: textEditingController,
                  maxLines: 5,
                  decoration:const InputDecoration(
                    hintText: 'Enter text',
                    border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.green), // Set border color
                  ),
                  ),
                ),
              ),


            
            const SizedBox(height: 20),


            ElevatedButton(

              onPressed: isSpeaking ? stopSpeaking : startSpeaking,
              style: ElevatedButton.styleFrom(
                backgroundColor: isSpeaking
                    ? Colors.red
                    : const Color.fromARGB(255, 7, 153, 15), // Change button color based on speaking state
              ),
              child: Text(isSpeaking ? 'Stop Speaking' : 'Speak'),
            ),


          ],
        ),
      ),
    );
  }

  Future<void> startSpeaking() async 
  {
    String text = textEditingController.text;
    if (text.isNotEmpty) 
    {
      await flutterTts.setVolume(1.0);
      await flutterTts.setSpeechRate(0.8);
      await flutterTts.setPitch(1.0);
      await flutterTts.setLanguage("en-US");

      await flutterTts.speak(text);
      setState(() 
      {
        isSpeaking = true;
      });
    }
  }

  Future<void> stopSpeaking() async 
  {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  void dispose() 
  {
    flutterTts.stop();
    // flutterTts.shutdown();
    super.dispose();
  }
}
