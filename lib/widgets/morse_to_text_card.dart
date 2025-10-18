import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/morse_logic.dart';
import 'converter_card.dart';
import '../utils/tts_util.dart';

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

  Future<void> speak(String text) async {
    await speakText(text);
  }

  Future<void> shareText(String text) async {
    SharePlus.instance.share(ShareParams(text: text));
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
      onPlay: () => speak(output),
      onShare: () => shareText(output),
    );
  }
}