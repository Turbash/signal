import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/morse_logic.dart';
import '../utils/generate_morse_audio.dart';
import '../utils/tts_util.dart';
import 'converter_card.dart';

class TextToMorseCard extends StatefulWidget {
  final VoidCallback? onStopMorseAudio;
  const TextToMorseCard({super.key, this.onStopMorseAudio});

  @override
  State<TextToMorseCard> createState() => TextToMorseCardState();
}

class TextToMorseCardState extends State<TextToMorseCard> {
  final inputController = TextEditingController();
  String output = '';

  final AudioPlayer _audioPlayer = AudioPlayer();
  File? _lastTempFile;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onPlayerComplete.listen((_) async {
      setState(() => isPlaying = false);
      await _deleteTempFile();
    });
  }

  void convert() {
    setState(() {
      output = textToMorse(inputController.text);
    });
  }

  Future<void> playMorseAudio(String morse) async {
    await stopTTS();
    if (morse.trim().isEmpty) return;

    await stopTTS();

    if (isPlaying) {
      await _audioPlayer.stop();
      await _deleteTempFile();
      setState(() => isPlaying = false);
      return;
    }

    try {
      await _audioPlayer.stop();
    } catch (_) {}

    final filePath = await generateMorseAudio(morse);

    _lastTempFile = File(filePath);

    setState(() => isPlaying = true);

    await _audioPlayer.play(DeviceFileSource(filePath));
  }

  Future<void> stopMorseAudio() async {
    if (isPlaying) {
      await _audioPlayer.stop();
      await _deleteTempFile();
      setState(() => isPlaying = false);
    }
  }

  Future<void> shareMorseAudio(String morse) async {
    if (morse.trim().isEmpty) return;

    final filePath = await generateMorseAudio(morse);
    final file = File(filePath);
    if (!await file.exists()) return;

    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)], text: 'Here is my Morse message'));
  }

  Future<void> _deleteTempFile() async {
    try {
      if (_lastTempFile != null && await _lastTempFile!.exists()) {
        await _lastTempFile!.delete();
      }
    } catch (_) {}
    _lastTempFile = null;
  }

  @override
  void dispose() {
    inputController.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _deleteTempFile();
    super.dispose();
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
      onShareAudio: () => shareMorseAudio(output),
      isPlaying: isPlaying,
    );
  }
}