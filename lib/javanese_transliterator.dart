const String _pangkon = '꧀';
const String _cecak = 'ꦁ';
const String _layar = 'ꦂ';
const String _wignyan = 'ꦃ';
const String _pengkal = 'ꦾ';
const String _cakra = 'ꦿ';
const String _wulu = 'ꦶ';
const String _suku = 'ꦸ';
const String _pepet = 'ꦼ';
const String _taling = 'ꦺ';
const String _tarung = 'ꦴ';

const Map<String, String> _consonants = {
  'h': 'ꦲ',
  'n': 'ꦤ',
  'c': 'ꦕ',
  'r': 'ꦫ',
  'k': 'ꦏ',
  'd': 'ꦢ',
  't': 'ꦠ',
  's': 'ꦱ',
  'w': 'ꦮ',
  'l': 'ꦭ',
  'p': 'ꦥ',
  'dh': 'ꦝ',
  'j': 'ꦗ',
  'y': 'ꦪ',
  'ny': 'ꦚ',
  'm': 'ꦩ',
  'g': 'ꦒ',
  'b': 'ꦧ',
  'th': 'ꦛ',
  'ng': 'ꦔ',
};

// Rekan (approximation with cecak telu ꦳)
const Map<String, String> _rekan = {
  'f': 'ꦥ꦳',
  'v': 'ꦮ꦳',
  'z': 'ꦗ꦳',
  'kh': 'ꦏ꦳',
  'gh': 'ꦒ꦳',
  'sy': 'ꦱ꦳',
  'dz': 'ꦢ꦳',
};

const Map<String, String> _swara = {
  'a': 'ꦄ',
  'i': 'ꦆ',
  'u': 'ꦈ',
  'e`': 'ꦌ',
  'o': 'ꦎ',
};

String latinToJavanese(String input) {
  final lower = input.toLowerCase();
  final out = StringBuffer();
  var i = 0;
  while (i < input.length) {
    final ch = input[i];
    final lowerCh = lower[i];
    if (!_isLatinOrMarker(lowerCh)) {
      out.write(ch);
      i += 1;
      continue;
    }

    final vowel = _matchVowel(lower, i);
    if (vowel != null) {
      out.write(_independentVowel(vowel));
      i += vowel.length;
      continue;
    }

    final cons = _matchConsonant(lower, i);
    if (cons == null) {
      out.write(ch);
      i += 1;
      continue;
    }

    final consGlyph = _consonantGlyph(cons);
    final nextIndex = i + cons.length;

    final glide = _matchGlide(lower, nextIndex);
    if (glide != null) {
      final vowelAfterGlide = _matchVowel(lower, nextIndex + 1);
      if (vowelAfterGlide != null) {
        out.write(consGlyph);
        out.write(glide == 'y' ? _pengkal : _cakra);
        out.write(_vowelSign(vowelAfterGlide));
        i = nextIndex + 1 + vowelAfterGlide.length;
        continue;
      }
    }

    final vowelAfter = _matchVowel(lower, nextIndex);
    if (vowelAfter != null) {
      out.write(consGlyph);
      out.write(_vowelSign(vowelAfter));
      i = nextIndex + vowelAfter.length;
      continue;
    }

    if (_hasPreviousSound(out)) {
      if (cons == 'ng') {
        out.write(_cecak);
        i = nextIndex;
        continue;
      }
      if (cons == 'r') {
        out.write(_layar);
        i = nextIndex;
        continue;
      }
      if (cons == 'h') {
        out.write(_wignyan);
        i = nextIndex;
        continue;
      }
    }

    out.write(consGlyph);
    out.write(_pangkon);
    i = nextIndex;
  }

  return out.toString();
}

String javaneseToLatin(String input) {
  final out = StringBuffer();
  var i = 0;
  while (i < input.length) {
    final ch = input[i];
    if (_swaraToLatin.containsKey(ch)) {
      final vowel = _swaraToLatin[ch]!;
      if (ch == 'ꦄ' && i + 1 < input.length && input[i + 1] == _pepet) {
        out.write('e');
        i += 2;
        continue;
      }
      out.write(vowel);
      i += 1;
      continue;
    }

    if (_baseToLatin.containsKey(ch)) {
      final cons = _baseToLatin[ch]!;
      var j = i + 1;
      var glide = '';
      if (j < input.length && (input[j] == _pengkal || input[j] == _cakra)) {
        glide = input[j] == _pengkal ? 'y' : 'r';
        j += 1;
      }

      var vowel = 'a';
      if (j < input.length && _isVowelSign(input[j])) {
        if (input[j] == _taling) {
          if (j + 1 < input.length && input[j + 1] == _tarung) {
            vowel = 'o';
            j += 2;
          } else {
            vowel = 'e`';
            j += 1;
          }
        } else {
          vowel = _vowelSignToLatin[input[j]] ?? vowel;
          j += 1;
        }
      }

      if (j < input.length && input[j] == _pangkon) {
        vowel = '';
        j += 1;
      }

      out.write(cons);
      if (glide.isNotEmpty) {
        out.write(glide);
      }
      out.write(vowel);

      if (j < input.length) {
        if (input[j] == _cecak) {
          out.write('ng');
          j += 1;
        } else if (input[j] == _layar) {
          out.write('r');
          j += 1;
        } else if (input[j] == _wignyan) {
          out.write('h');
          j += 1;
        }
      }

      i = j;
      continue;
    }

    if (ch == _cecak) {
      out.write('ng');
      i += 1;
      continue;
    }
    if (ch == _layar) {
      out.write('r');
      i += 1;
      continue;
    }
    if (ch == _wignyan) {
      out.write('h');
      i += 1;
      continue;
    }

    out.write(ch);
    i += 1;
  }
  return out.toString();
}

String _consonantGlyph(String cons) =>
    _rekan[cons] ?? _consonants[cons] ?? cons;

String _independentVowel(String vowel) {
  if (vowel == 'e') {
    return 'ꦄꦼ';
  }
  return _swara[vowel] ?? vowel;
}

String _vowelSign(String vowel) {
  switch (vowel) {
    case 'i':
      return _wulu;
    case 'u':
      return _suku;
    case 'e':
      return _pepet;
    case 'e`':
      return _taling;
    case 'o':
      return '$_taling$_tarung';
    case 'a':
    default:
      return '';
  }
}

String? _matchVowel(String text, int index) {
  if (index + 1 < text.length && text.substring(index, index + 2) == 'e`') {
    return 'e`';
  }
  final ch = text[index];
  if ('aiueo'.contains(ch)) {
    return ch;
  }
  return null;
}

String? _matchGlide(String text, int index) {
  if (index >= text.length) return null;
  final ch = text[index];
  if (ch == 'y' || ch == 'r') {
    return ch;
  }
  return null;
}

String? _matchConsonant(String text, int index) {
  const digraphs = ['ng', 'ny', 'dh', 'th', 'kh', 'gh', 'sy', 'dz'];
  for (final d in digraphs) {
    if (index + d.length <= text.length &&
        text.substring(index, index + d.length) == d) {
      return d;
    }
  }
  final ch = text[index];
  if (_consonants.containsKey(ch) || _rekan.containsKey(ch)) {
    return ch;
  }
  return null;
}

bool _isLatinOrMarker(String ch) {
  if (ch == '`') return true;
  final code = ch.codeUnitAt(0);
  return code >= 97 && code <= 122;
}

bool _hasPreviousSound(StringBuffer out) {
  final text = out.toString();
  for (var i = text.length - 1; i >= 0; i -= 1) {
    final ch = text[i];
    if (ch.trim().isNotEmpty) {
      return true;
    }
  }
  return false;
}

const Map<String, String> _baseToLatin = {
  'ꦲ': 'h',
  'ꦤ': 'n',
  'ꦕ': 'c',
  'ꦫ': 'r',
  'ꦏ': 'k',
  'ꦢ': 'd',
  'ꦠ': 't',
  'ꦱ': 's',
  'ꦮ': 'w',
  'ꦭ': 'l',
  'ꦥ': 'p',
  'ꦝ': 'dh',
  'ꦗ': 'j',
  'ꦪ': 'y',
  'ꦚ': 'ny',
  'ꦩ': 'm',
  'ꦒ': 'g',
  'ꦧ': 'b',
  'ꦛ': 'th',
  'ꦔ': 'ng',
};

const Map<String, String> _swaraToLatin = {
  'ꦄ': 'a',
  'ꦆ': 'i',
  'ꦈ': 'u',
  'ꦌ': 'e`',
  'ꦎ': 'o',
};

const Map<String, String> _vowelSignToLatin = {
  _wulu: 'i',
  _suku: 'u',
  _pepet: 'e',
};

bool _isVowelSign(String ch) =>
    ch == _wulu || ch == _suku || ch == _pepet || ch == _taling;
