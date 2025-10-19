import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/morse_logic.dart';
import 'converter_card.dart';
import '../utils/tts_util.dart';

class MorseToTextCard extends StatefulWidget {
  final VoidCallback? stopMorseAudio;
  const MorseToTextCard({super.key, this.stopMorseAudio});

  @override
  State<MorseToTextCard> createState() => _MorseToTextCardState();
}

class _MorseToTextCardState extends State<MorseToTextCard> {
  final controller = TextEditingController();
  String output = '';

  bool isSpeaking = false;
  VoidCallback? stopMorseAudio;
  late final Stream<bool> _ttsStream;

  void convert() {
    setState(() {
      output = morseToText(controller.text);
    });
  }

  Future<void> speak(String text) async {
  widget.stopMorseAudio?.call();
    if (isSpeaking) {
      await stopTTS();
      return;
    }
    await speakText(text);
  }

  Future<void> shareText(String text) async {
    SharePlus.instance.share(ShareParams(text: text));
  }

  @override
  void initState() {
    initMorse();
    _ttsStream = ttsSpeakingStream;
    _ttsStream.listen((speaking) {
      if (mounted) setState(() => isSpeaking = speaking);
    });
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
      isPlaying: isSpeaking,
    );
  }
}