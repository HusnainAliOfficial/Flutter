// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget 
{
  const SpeechScreen({super.key});

  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> 
{
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';


  @override
  void initState() 
  {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 7, 153, 15),
        centerTitle: true,
        
        title: const Text(
          'Speech to Text',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          
        ),
      ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
           backgroundColor:const Color.fromARGB(255, 7, 153, 15),
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),


      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          height: 500,
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: Text(
            _text,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async 
  {
    if (!_isListening) 
    {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) 
      {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() 
          {
            _text = val.recognizedWords;
          }),
        );
      }
    } 
    else 
    {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

