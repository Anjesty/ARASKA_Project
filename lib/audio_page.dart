import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'transliteration_history.dart';
import 'tts_utils.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  final FlutterTts _tts = FlutterTts();
  bool _ttsReady = false;
  String _query = '';
  _DateFilter _dateFilter = _DateFilter.all;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    try {
      await _tts.setLanguage('id-ID');
      await _tts.setSpeechRate(0.45);
      await _tts.setPitch(1.0);
      await _tts.setVolume(1.0);
      _ttsReady = true;
    } catch (e) {
      _ttsReady = false;
    }
  }

  Future<void> _speak(String text) async {
    if (!_ttsReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Text-to-speech belum siap.')),
      );
      return;
    }
    final speakText = normalizeForTts(text);
    await _tts.stop();
    await _tts.speak(speakText);
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TransliterationHistory.instance,
      builder: (context, _) {
        final items = TransliterationHistory.instance.items;
        final now = DateTime.now();
        final query = _query.trim().toLowerCase();
        final dateFiltered = items
            .where((e) => _matchesDateFilter(e.createdAt, now, _dateFilter))
            .toList();
        final filtered = query.isEmpty
            ? dateFiltered
            : dateFiltered
                .where((e) => e.text.toLowerCase().contains(query))
                .toList();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Riwayat Transliterasi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: items.isEmpty
                        ? null
                        : () async {
                            await TransliterationHistory.instance.clear();
                          },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _DateFilter.values.map((filter) {
                  final selected = _dateFilter == filter;
                  return ChoiceChip(
                    label: Text(_dateFilterLabel(filter)),
                    selected: selected,
                    onSelected: (_) =>
                        setState(() => _dateFilter = filter),
                    selectedColor: const Color(0xFF3D52F8),
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.white70,
                    ),
                    backgroundColor: const Color(0xFF1F243F),
                    side: BorderSide(
                      color: selected
                          ? const Color(0xFF3D52F8)
                          : Colors.transparent,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              TextField(
                onChanged: (value) => setState(() => _query = value),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Cari riwayat...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF1F243F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (items.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Belum ada riwayat.',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                )
              else if (filtered.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Tidak ada hasil pencarian.',
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      final hasImage = item.imagePath != null &&
                          File(item.imagePath!).existsSync();
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F243F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            if (hasImage)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(item.imagePath!),
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.white54,
                                ),
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.text,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    _formatTime(item.createdAt),
                                    style: const TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.volume_up_outlined),
                              color: Colors.blueAccent,
                              onPressed: () => _speak(item.text),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.redAccent,
                              onPressed: () async {
                                await TransliterationHistory.instance
                                    .remove(item);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

String _formatTime(DateTime time) {
  final two = (int n) => n.toString().padLeft(2, '0');
  return '${two(time.hour)}:${two(time.minute)}  ${two(time.day)}-${two(time.month)}-${time.year}';
}

enum _DateFilter { all, today, last7, thisMonth }

String _dateFilterLabel(_DateFilter filter) {
  switch (filter) {
    case _DateFilter.today:
      return 'Hari Ini';
    case _DateFilter.last7:
      return '7 Hari';
    case _DateFilter.thisMonth:
      return 'Bulan Ini';
    case _DateFilter.all:
    default:
      return 'Semua';
  }
}

bool _matchesDateFilter(DateTime date, DateTime now, [_DateFilter? filter]) {
  final selected = filter ?? _DateFilter.all;
  if (selected == _DateFilter.all) {
    return true;
  }
  final dateOnly = DateTime(date.year, date.month, date.day);
  final todayOnly = DateTime(now.year, now.month, now.day);
  switch (selected) {
    case _DateFilter.today:
      return dateOnly == todayOnly;
    case _DateFilter.last7:
      final start = todayOnly.subtract(const Duration(days: 6));
      return !dateOnly.isBefore(start);
    case _DateFilter.thisMonth:
      return date.year == now.year && date.month == now.month;
    case _DateFilter.all:
      return true;
  }
}
