import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'speech_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Speech to Text',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SpeechScreen(),
    );
  }
}
