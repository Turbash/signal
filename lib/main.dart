import 'package:flutter/material.dart';
import 'widgets/morse_to_text_card.dart';
import 'widgets/text_to_morse_card.dart';

void main() {
  runApp(const MorseSignalApp());
}

class MorseSignalApp extends StatelessWidget {
  const MorseSignalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Morse Signal App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Morse Signal Converter'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              TextToMorseCard(),
              MorseToTextCard(),
            ],
          ),
        ),
      ),
    );
  }
}