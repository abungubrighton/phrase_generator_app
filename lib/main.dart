import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:logger/logger.dart';
var logger = Logger();



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    logger.i(wordPair);


    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple[900]
      ),
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
            'Word Pair Generator',
          )),
          body: Center(
            child: Text(wordPair.asPascalCase),
          )),
    );
  }
}
