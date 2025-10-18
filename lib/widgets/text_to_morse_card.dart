import 'package:flutter/material.dart';
// import '../utils/morse_signal.dart';
import '../utils/morse_logic.dart';
import 'converter_card.dart';
import 'package:audioplayers/audioplayers.dart';
import '../utils/generate_morse_audio.dart';
import 'package:share_plus/share_plus.dart';

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

  Future<void> playMorseAudio(String morse) async {
    final filePath = await generateMorseAudio(morse);
    final player = AudioPlayer();
    await player.play(DeviceFileSource(filePath));
  }

  Future<void> shareMorseAudio(String morse) async {
    final filePath = await generateMorseAudio(morse);
    await SharePlus.instance.share(ShareParams(text: 'Here is my Morse message', files: [XFile(filePath)]));
  }

  @override
  Widget build(BuildContext context) {
    return ConverterCard(
      title: 'Text to Morse',
      controller: inputController,
      output: output,
      onConvert: convert,
      onPlay: () => playMorseAudio(output),
      onShare: () => shareMorseAudio(output),
    );
  }
}