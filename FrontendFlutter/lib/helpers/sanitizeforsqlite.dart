import 'dart:convert';

Map<String, dynamic> sanitizeForSqlite(Map<String, dynamic> data) {
  return data.map((key, value) {
    if (value is Map || value is List) {
      return MapEntry(key, jsonEncode(value));
    }
    return MapEntry(key, value);
  });
}