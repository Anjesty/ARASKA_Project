import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransliterationHistoryEntry {
  final String text;
  final DateTime createdAt;
  final String? imagePath;

  TransliterationHistoryEntry({
    required this.text,
    required this.createdAt,
    this.imagePath,
  });

  Map<String, dynamic> toMap() => {
        'text': text,
        'createdAt': createdAt.toIso8601String(),
        'imagePath': imagePath,
      };

  static TransliterationHistoryEntry fromMap(Map<String, dynamic> map) {
    return TransliterationHistoryEntry(
      text: map['text'] as String? ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? '') ??
          DateTime.now(),
      imagePath: map['imagePath'] as String?,
    );
  }
}

class TransliterationHistory extends ChangeNotifier {
  TransliterationHistory._();
  static final TransliterationHistory instance = TransliterationHistory._();

  static const String _storageKey = 'transliteration_history_v1';
  static const String _imageCacheDir = 'history_images';

  final List<TransliterationHistoryEntry> _items = [];
  bool _loaded = false;

  List<TransliterationHistoryEntry> get items =>
      List.unmodifiable(_items);

  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw == null || raw.isEmpty) {
        return;
      }
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        _items
          ..clear()
          ..addAll(
            decoded
                .whereType<Map<String, dynamic>>()
                .map(TransliterationHistoryEntry.fromMap),
          );
        notifyListeners();
      }
    } catch (_) {
      // Ignore malformed storage.
    }
  }

  Future<void> add(String text, {String? imagePath}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }
    final cachedImagePath = await _cacheImage(imagePath);
    _items.insert(
      0,
      TransliterationHistoryEntry(
        text: trimmed,
        createdAt: DateTime.now(),
        imagePath: cachedImagePath,
      ),
    );
    await _save();
    notifyListeners();
  }

  Future<void> remove(TransliterationHistoryEntry entry) async {
    _items.remove(entry);
    await _deleteImageIfExists(entry.imagePath);
    await _save();
    notifyListeners();
  }

  Future<void> clear() async {
    final imagePaths = _items
        .map((e) => e.imagePath)
        .whereType<String>()
        .toList();
    _items.clear();
    for (final path in imagePaths) {
      await _deleteImageIfExists(path);
    }
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = _items.map((e) => e.toMap()).toList();
      await prefs.setString(_storageKey, jsonEncode(data));
    } catch (_) {
      // Ignore storage errors.
    }
  }

  Future<String?> _cacheImage(String? sourcePath) async {
    if (sourcePath == null || sourcePath.trim().isEmpty) {
      return null;
    }
    final sourceFile = File(sourcePath);
    if (!await sourceFile.exists()) {
      return null;
    }
    try {
      final dir = await getApplicationDocumentsDirectory();
      final cacheDir = Directory(p.join(dir.path, _imageCacheDir));
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }
      final base = p.basenameWithoutExtension(sourcePath);
      final ext = p.extension(sourcePath);
      final safeBase = base.isEmpty ? 'image' : base;
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_$safeBase$ext';
      final targetPath = p.join(cacheDir.path, fileName);
      final copied = await sourceFile.copy(targetPath);
      return copied.path;
    } catch (_) {
      return null;
    }
  }

  Future<void> _deleteImageIfExists(String? path) async {
    if (path == null || path.trim().isEmpty) {
      return;
    }
    try {
      final normalized = p.normalize(path);
      if (!normalized.contains(_imageCacheDir)) {
        return;
      }
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // Ignore delete errors.
    }
  }
}
