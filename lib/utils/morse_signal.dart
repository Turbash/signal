import 'package:vibration/vibration.dart';
import 'dart:async';
import 'package:flutter_beep_plus/flutter_beep_plus.dart';

Future<void> playMorse(String morse) async {
  final beepPlayer = FlutterBeepPlus();

  for (var st in morse.split(' ')) {
    for(var ch in st.split('')){
      if (ch=='.'){
        await beepPlayer.playSysSound(AndroidSoundID.TONE_PROP_PROMPT);
        await Vibration.vibrate(duration: 200);
        await Future.delayed(const Duration(milliseconds: 300));
      }
      else if (ch=='-'){
        await beepPlayer.playSysSound(AndroidSoundID.TONE_CDMA_ABBR_ALERT);
        await Vibration.vibrate(duration: 400);
        await Future.delayed(const Duration(milliseconds: 500));
      }
    }
    await Future.delayed(const Duration(milliseconds: 700));
  }
}