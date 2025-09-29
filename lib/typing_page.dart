import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _sourceLanguage = 'Indonesia';
  String _targetLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _inputController.addListener(() {
      // Placeholder for translation logic
      setState(() {
        _outputController.text = _inputController.text;
      });
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _swapLanguages() {
    setState(() {
      final tempLang = _sourceLanguage;
      _sourceLanguage = _targetLanguage;
      _targetLanguage = tempLang;

      final tempText = _inputController.text;
      _inputController.text = _outputController.text;
      _outputController.text = tempText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F243F),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
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
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: _TranslationBox(
                      language: _targetLanguage,
                      controller: _outputController,
                      isInput: false,
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
          const SizedBox(height: 20),
        ],
      ),
    );
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

  const _TranslationBox({
    required this.language,
    required this.controller,
    required this.isInput,
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
              readOnly: !isInput,
              style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
              maxLines: null, // Allows for multiline input
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter text...',
                hintStyle: TextStyle(color: Colors.grey),
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
