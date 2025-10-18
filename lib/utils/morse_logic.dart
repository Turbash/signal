
  final Map<String, String> _charToMorse = {
    'A': '.-',    'B': '-...',  'C': '-.-.',  'D': '-..',
    'E': '.',     'F': '..-.',  'G': '--.',   'H': '....',
    'I': '..',    'J': '.---',  'K': '-.-',   'L': '.-..',
    'M': '--',    'N': '-.',    'O': '---',   'P': '.--.',
    'Q': '--.-',  'R': '.-.',   'S': '...',   'T': '-',
    'U': '..-',   'V': '...-',  'W': '.--',   'X': '-..-',
    'Y': '-.--',  'Z': '--..',
    '0': '-----', '1': '.----', '2': '..---', '3': '...--',
    '4': '....-', '5': '.....', '6': '-....', '7': '--...',
    '8': '---..', '9': '----.',
    ' ': '/'
  };

  late final Map<String, String> _morseToChar;

  void initMorse() {
    _morseToChar = {for (var e in _charToMorse.entries) e.value: e.key
    };
  }

  String textToMorse(String text) {
    final sb = StringBuffer();
    for (var ch in text.trim().toUpperCase().split('')){
      final morse = _charToMorse[ch];
      if (morse != null) {
          sb.write('$morse ');
      }
    }
    return sb.toString().trim();
  }

  String morseToText(String morse) {
    final words = morse.trim().split('/');
    final decodeWords = words.map((word) {
      final letters = word.trim().split(' ');
      final chars = letters.map((l) => _morseToChar[l] ?? '?').join();
      return chars;
    });
    return decodeWords.join(' ');
  }