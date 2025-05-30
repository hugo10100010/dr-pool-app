import 'package:proyecto/helpers/casillahorario_db.dart';

class LocalIdGenerator {
  /// Generates a temporary negative ID for local-only entries.
  /// Ensures no conflict with positive server-assigned IDs.
  static Future<int> generate(String tableName) async {
    final db = await AppDatabase.getDatabase();
    final result = await db.rawQuery('SELECT MIN(id) as minId FROM $tableName');
    final minId = result.first['minId'] as int?;
    return (minId != null && minId < 0) ? minId - 1 : -1;
  }
}
