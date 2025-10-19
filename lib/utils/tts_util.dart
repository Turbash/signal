import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

final FlutterTts flutterTts = FlutterTts();
final StreamController<bool> _ttsSpeakingController = StreamController<bool>.broadcast();
bool _isSpeaking = false;

Stream<bool> get ttsSpeakingStream => _ttsSpeakingController.stream;

Future<void> speakText(String text) async {
  if (text.isEmpty) return;

  if (_isSpeaking) {
    await flutterTts.stop();
    _isSpeaking = false;
    _ttsSpeakingController.add(false);
    return;
  }

  await flutterTts.setLanguage("en-US");
  await flutterTts.setPitch(1.0);
  await flutterTts.setVolume(1.0);
  await flutterTts.setPitch(1.0);

  _isSpeaking = true;
  _ttsSpeakingController.add(true);
  await flutterTts.speak(text);

  flutterTts.setCompletionHandler(() {
    _isSpeaking = false;
    _ttsSpeakingController.add(false);
  });
}

Future<void> stopTTS() async {
  if (_isSpeaking) {
    await flutterTts.stop();
    _isSpeaking = false;
    _ttsSpeakingController.add(false);
  }
}