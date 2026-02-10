import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'javanese_transliterator.dart';

class TypingPage extends StatefulWidget {
  const TypingPage({super.key});

  @override
  State<TypingPage> createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Listen for changes in the input field to update the output field
    _inputController.addListener(_onInputChanged);
  }

  void _onInputChanged() {
    // For now, this just copies the text.
    // Later, you can replace this with a call to a translation API.
    setState(() {
      _outputController.text = _inputController.text;
    });
  }

  @override
  void dispose() {
    _inputController.removeListener(_onInputChanged);
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _MainTranslatorCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainTranslatorCard extends StatefulWidget {
  const _MainTranslatorCard();

  @override
  State<_MainTranslatorCard> createState() => _MainTranslatorCardState();
}

class _MainTranslatorCardState extends State<_MainTranslatorCard> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  final FocusNode _inputFocus = FocusNode();
  bool _latinToJavanese = true;
  bool _showJavaneseKeyboard = true;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      _translate();
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    _inputFocus.dispose();
    super.dispose();
  }

  void _swapLanguages() {
    setState(() {
      _latinToJavanese = !_latinToJavanese;
      final previousOutput = _outputController.text;
      _inputController.text = previousOutput;
      _translate();
    });
  }

  void _translate() {
    final text = _inputController.text;
    final result = _latinToJavanese
        ? latinToJavanese(text)
        : javaneseToLatin(text);
    setState(() {
      _outputController.text = result;
    });
  }

  String get _sourceLanguage => _latinToJavanese ? 'Latin' : 'Aksara Jawa';
  String get _targetLanguage => _latinToJavanese ? 'Aksara Jawa' : 'Latin';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showKeyboard = !_latinToJavanese && _showJavaneseKeyboard;
        final keyboardHeight = constraints.maxHeight * 0.42;
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFF1F243F),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const _TopBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: _TranslationBox(
                              language: _sourceLanguage,
                              controller: _inputController,
                              isInput: true,
                              useJavaneseFont: !_latinToJavanese,
                              readOnlyInput: !_latinToJavanese,
                              focusNode: _inputFocus,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: _TranslationBox(
                              language: _targetLanguage,
                              controller: _outputController,
                              isInput: false,
                              useJavaneseFont: _latinToJavanese,
                              readOnlyInput: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _LanguageSelector(
                    sourceLanguage: _sourceLanguage,
                    targetLanguage: _targetLanguage,
                    onSwap: _swapLanguages,
                  ),
                  if (!_latinToJavanese && !showKeyboard)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _showJavaneseKeyboard = !_showJavaneseKeyboard;
                            });
                          },
                          icon: const Icon(Icons.keyboard,
                              color: Colors.white70),
                          label: const Text(
                            'Tampilkan Keyboard',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 12),
                ],
              ),
              if (showKeyboard)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: keyboardHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B2038),
                      border: Border(
                        top: BorderSide(color: Colors.white.withOpacity(0.08)),
                      ),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _showJavaneseKeyboard = false;
                              });
                            },
                            icon: const Icon(Icons.keyboard_hide,
                                color: Colors.white70),
                            label: const Text(
                              'Sembunyikan Keyboard',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            child: _buildJavaneseKeyboard(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJavaneseKeyboard() {
    final aksaraDasar = [
      'ꦲ', 'ꦤ', 'ꦕ', 'ꦫ', 'ꦏ', 'ꦢ', 'ꦠ', 'ꦱ', 'ꦮ', 'ꦭ',
      'ꦥ', 'ꦝ', 'ꦗ', 'ꦪ', 'ꦚ', 'ꦩ', 'ꦒ', 'ꦧ', 'ꦛ', 'ꦔ',
    ];
    final swara = ['ꦄ', 'ꦆ', 'ꦈ', 'ꦌ', 'ꦎ'];
    final sandhangan = ['ꦶ', 'ꦸ', 'ꦼ', 'ꦺ', 'ꦺꦴ', '꧀'];
    final panyigeg = ['ꦁ', 'ꦂ', 'ꦃ'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyRow('Aksara Dasar', aksaraDasar),
        const SizedBox(height: 8),
        _buildKeyRow('Swara', swara),
        const SizedBox(height: 8),
        _buildKeyRow('Sandhangan', sandhangan),
        const SizedBox(height: 8),
        _buildKeyRow('Panyigeg', panyigeg),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _actionKey(
                label: 'Spasi',
                onPressed: () => _insertText(' '),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _actionKey(
                label: 'Hapus',
                onPressed: _backspace,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildKeyRow(String label, List<String> keys) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keys
              .map(
                (k) => _glyphKey(
                  label: k,
                  onPressed: () => _insertText(k),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _glyphKey({required String label, required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: GoogleFonts.notoSansJavanese(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _actionKey({required String label, required VoidCallback onPressed}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label),
    );
  }

  void _insertText(String text) {
    _focusInput();
    var start = _inputController.selection.start;
    var end = _inputController.selection.end;
    if (start < 0 || end < 0) {
      start = _inputController.text.length;
      end = _inputController.text.length;
    }
    final newText = _inputController.text.replaceRange(start, end, text);
    final newSelection = start + text.length;
    _inputController.text = newText;
    _inputController.selection = TextSelection.collapsed(offset: newSelection);
    _translate();
  }

  void _backspace() {
    _focusInput();
    var start = _inputController.selection.start;
    var end = _inputController.selection.end;
    if (start < 0 || end < 0) {
      start = _inputController.text.length;
      end = _inputController.text.length;
    }
    if (start != end) {
      final newText = _inputController.text.replaceRange(start, end, '');
      _inputController.text = newText;
      _inputController.selection = TextSelection.collapsed(offset: start);
      _translate();
      return;
    }
    if (start == 0) return;
    final runes = _inputController.text.runes.toList();
    if (runes.isEmpty) return;
    runes.removeAt(runes.length - 1);
    final newText = String.fromCharCodes(runes);
    final newOffset = newText.length;
    _inputController.text = newText;
    _inputController.selection = TextSelection.collapsed(offset: newOffset);
    _translate();
  }

  void _focusInput() {
    if (!_inputFocus.hasFocus) {
      _inputFocus.requestFocus();
    }
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Translator',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _TranslationBox extends StatelessWidget {
  final String language;
  final TextEditingController controller;
  final bool isInput;
  final bool useJavaneseFont;
  final bool readOnlyInput;
  final FocusNode? focusNode;

  const _TranslationBox({
    required this.language,
    required this.controller,
    required this.isInput,
    required this.useJavaneseFont,
    required this.readOnlyInput,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF262D4D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            language,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              readOnly: !isInput || readOnlyInput,
              showCursor: isInput,
              style: useJavaneseFont
                  ? GoogleFonts.notoSansJavanese(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.6,
                    )
                  : const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
              maxLines: null, // Allows for multiline input
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: isInput
                    ? (useJavaneseFont
                        ? 'Ketik Aksara Jawa...'
                        : 'Ketik Latin (e` untuk taling, e untuk pepet)...')
                    : '',
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.copy_outlined, color: Colors.grey[400], size: 22),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: controller.text));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Text copied to clipboard')),
                  );
                },
              ),
              const Spacer(),
              IconButton(
                icon: Icon(Icons.volume_up_outlined, color: Colors.grey[400], size: 22),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LanguageSelector extends StatelessWidget {
  final String sourceLanguage;
  final String targetLanguage;
  final VoidCallback onSwap;

  const _LanguageSelector({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(sourceLanguage, style: const TextStyle(color: Colors.white, fontSize: 16)),
          InkWell(
            onTap: onSwap,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF3D52F8),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.swap_horiz, color: Colors.white, size: 24),
            ),
          ),
          Text(targetLanguage, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}








// import 'package:flutter/material.dart';
//
// class TypingPage extends StatelessWidget {
//   const TypingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Text Translator will be here',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
//
// class TypingPage extends StatelessWidget {
//   const TypingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text(
//         'Typing Page',
//         style: TextStyle(fontSize: 24, color: Colors.white),
//       ),
//     );
//   }
// }
