import 'package:vibration/vibration.dart';
import 'dart:async';
import 'package:flutter_beep_plus/flutter_beep_plus.dart';

Future<void> playMorse(String morse) async {
  final beepPlayer = FlutterBeepPlus();

  for (var word in morse.trim().split(' / ')) {
    for (var letter in word.trim().split(' ')) {
      for (var ch in letter.split('')) {
        final duration = ch == '.' ? 200 : 400;

        beepPlayer.playSysSound(
          ch == '.' 
            ? AndroidSoundID.TONE_PROP_PROMPT 
            : AndroidSoundID.TONE_CDMA_ABBR_ALERT
        );
        Vibration.vibrate(duration: duration);

        await Future.delayed(Duration(milliseconds: 400));
      }

      await Future.delayed(Duration(milliseconds: 600));
    }

    await Future.delayed(Duration(milliseconds: 800));
  }
}