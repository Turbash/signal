import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<String> generateMorseAudio(String morse) async {
  final sampleRate = 44100;
  final frequency = 800.0;
  final dotDuration = 0.2;
  final dashDuration = 0.4;
  final symbolPause = 0.4;
  final letterPause = 0.6;
  final wordPause = 0.8;
  
  List<int> samples = [];

  List<int> generateTone(double duration) {
    int count = (duration * sampleRate).toInt();
    List<int> buffer = [];
    for(int i=0;i<count;i++){
      double t=i/sampleRate;
      double value = sin(2*pi*frequency*t);
      int intVal = (value * 32767).toInt();
      buffer.addAll([intVal & 0xFF, (intVal >> 8) & 0xFF]);
    }
    return buffer;
  }

  List<int> generateSilence(double duration) {
    int count = (duration * sampleRate).toInt();
    return List.filled(count * 2, 0);
  }

  for (var word in morse.trim().split('/')){
    for (var letter in word.trim().split(' ')){
      for (var ch in letter.split('')){
        if (ch == '.'){
          samples.addAll(generateTone(dotDuration));
        }
        else{
          samples.addAll(generateTone(dashDuration));
        }
        samples.addAll(generateSilence(symbolPause));
      }
      samples.addAll(generateSilence(letterPause));
    }
    samples.addAll(generateSilence(wordPause));
  }

  final tempDir = await getTemporaryDirectory();
  final filePath = '${tempDir.path}/morse_audio.wav';
  final file = File(filePath);

  final byteData = Uint8List(44 + samples.length);

  byteData[0] = 'R'.codeUnitAt(0);
  byteData[1] = 'I'.codeUnitAt(0);
  byteData[2] = 'F'.codeUnitAt(0);
  byteData[3] = 'F'.codeUnitAt(0);
  int fileSize = byteData.length - 8;
  byteData[4] = fileSize & 0xFF;
  byteData[5] = (fileSize >> 8) & 0xFF;
  byteData[6] = (fileSize >> 16) & 0xFF;
  byteData[7] = (fileSize >> 24) & 0xFF;
  byteData[8] = 'W'.codeUnitAt(0);
  byteData[9] = 'A'.codeUnitAt(0);
  byteData[10] = 'V'.codeUnitAt(0);
  byteData[11] = 'E'.codeUnitAt(0);

  byteData[12] = 'f'.codeUnitAt(0);
  byteData[13] = 'm'.codeUnitAt(0);
  byteData[14] = 't'.codeUnitAt(0);
  byteData[15] = ' '.codeUnitAt(0);
  byteData[16] = 16;  
  byteData[17] = 0;
  byteData[18] = 0;
  byteData[19] = 0;
  byteData[20] = 1;
  byteData[21] = 0;
  byteData[22] = 1;
  byteData[23] = 0;
  byteData[24] = sampleRate & 0xFF;
  byteData[25] = (sampleRate >> 8) & 0xFF;
  byteData[26] = (sampleRate >> 16) & 0xFF;
  byteData[27] = (sampleRate >> 24) & 0xFF;
  int byteRate = sampleRate * 2;
  byteData[28] = byteRate & 0xFF; 
  byteData[29] = (byteRate >> 8) & 0xFF;
  byteData[30] = (byteRate >> 16) & 0xFF;
  byteData[31] = (byteRate >> 24) & 0xFF;
  byteData[32] = 2;
  byteData[33] = 0;
  byteData[34] = 16;
  byteData[35] = 0;

  byteData[36] = 'd'.codeUnitAt(0);
  byteData[37] = 'a'.codeUnitAt(0);
  byteData[38] = 't'.codeUnitAt(0);
  byteData[39] = 'a'.codeUnitAt(0);
  int dataSize = samples.length;
  byteData[40] = dataSize & 0xFF;
  byteData[41] = (dataSize >> 8) & 0xFF;
  byteData[42] = (dataSize >> 16) & 0xFF;
  byteData[43] = (dataSize >> 24) & 0xFF;

  byteData.setRange(44, 44 + samples.length, samples);

  await file.writeAsBytes(byteData, flush: true);

  return filePath;
}