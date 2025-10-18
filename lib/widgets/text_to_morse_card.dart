import 'package:flutter/material.dart';
import '../utils/morse_signal.dart';
import '../utils/morse_logic.dart';
import 'converter_card.dart';

class TextToMorseCard extends StatefulWidget {
  const TextToMorseCard({super.key});

  @override
  State<TextToMorseCard> createState() => _TextToMorseCardState();
}

class _TextToMorseCardState extends State<TextToMorseCard> {
  final inputController = TextEditingController();
  String output = '';

  void convert() {
    setState(() {
      output = textToMorse(inputController.text);
    });
  }

  void play(){
    playMorse(output);
  }

  @override
  Widget build(BuildContext context) {
    return ConverterCard(
      title: 'Text to Morse',
      controller: inputController,
      output: output,
      onConvert: convert,
      onPlay: play,
    );
  }

}