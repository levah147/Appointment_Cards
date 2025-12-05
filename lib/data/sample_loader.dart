import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/calendar_models.dart';

class SampleLoader {
  static const String assetPath = 'assets/data/sampleData.json';

  static Future<CalendarData> load() async {
    final raw = await rootBundle.loadString(assetPath);
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
    return CalendarData.fromJson(json);
  }
}

