import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:proyecto/helpers/syncable_interface.dart';

class SyncManager {
  static Future<void> sync<T extends Syncable>({
    required String tableName,
    required T Function(Map<String, dynamic>) fromJson,
    required Future<bool> Function(T item) onUpload,
    required Future<bool> Function(int id) onDelete,
  }) async {
    final unsynced = await AppDatabase.getAll<T>(
      tableName: tableName,
      fromJson: fromJson,
    );

    for (final item in unsynced.where((i) => i.syncStatus != 0)) {
      try {
        if (item.syncStatus == 1) {
          // Create or update on server
          final success = await onUpload(item);
          if (success) {
            item.syncStatus = 0;
            await AppDatabase.update(item);
            if(item.id<0) {
              await AppDatabase.delete(tableName, item.id);
            }
          }
        } else if (item.syncStatus == 2) {
          // Delete on server
          final success = await onDelete(item.id);
          if (success) {
            await AppDatabase.delete(tableName, item.id);
          }
        }
      } catch (e) {
        print('Sync failed for $tableName item ${item.id}: $e');
      }
    }
  }
}
