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
  final textToMorseKey = GlobalKey<TextToMorseCardState>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MorseApp',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MorseApp'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextToMorseCard(key: textToMorseKey),
              MorseToTextCard(
                key: UniqueKey(),
                stopMorseAudio: () => textToMorseKey.currentState?.stopMorseAudio(),
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          primary: Colors.black,
          secondary: Colors.lightBlueAccent,
          tertiary: Colors.amber,
          surface: Colors.teal,
        ),
        useMaterial3: true,
      ),
    );
  }
}