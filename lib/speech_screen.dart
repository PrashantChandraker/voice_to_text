import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vibration/vibration.dart';
import 'package:voice_to_text/colors.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  
  SpeechToText speechToText = SpeechToText();
  var text = 'Hold The Button and Start Speaking';
  var isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset('assets/note.png'),
        centerTitle: true,
        backgroundColor: appBarColor,
        title: const Text(
          'SPEECH TO TEXT',
          style: TextStyle(
              wordSpacing: 5,
              letterSpacing: 4,
              fontSize: 24,
              color: textColor,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.only(bottom: 150),
          color: Colors.white60,
          child:  Text(
            text,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
      floatingActionButton: floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  AvatarGlow floatingButton() {
    return AvatarGlow(
      glowRadiusFactor: 1,
      duration: const Duration(milliseconds: 1500),
      glowColor: appBarColor,
      repeat: true,
      glowShape: BoxShape.circle,
      glowCount: 5,
      animate: isListening,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GestureDetector(
          onTapDown: (details) async{
            _vibrate();
           if(!isListening){
            var available= await speechToText.initialize();
            if(available){
               setState(() {
              isListening = true;
              speechToText.listen(
                onResult: ((result) {
                  setState(() {
                    text = result.recognizedWords;
                  });
                })
              );
            });
            }
           }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
          },
          child: CircleAvatar(
            backgroundColor: appBarColor,
            radius: 30,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }

  void _vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }
  }
}
