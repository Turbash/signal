import 'package:flutter/material.dart';
import '../utils/morse_logic.dart';
import 'converter_card.dart';

class MorseToTextCard extends StatefulWidget {
  const MorseToTextCard({super.key});

  @override
  State<MorseToTextCard> createState() => _MorseToTextCardState();
}

class _MorseToTextCardState extends State<MorseToTextCard> {
  final controller = TextEditingController();
  String output = '';

  void convert() {
    setState(() {
      output = morseToText(controller.text);
    });
  }

  @override
  void initState() {
    initMorse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConverterCard(
      title: 'Morse to Text',
      controller: controller,
      output: output,
      onConvert: convert,
      onPlay: null,
    );
  }
}