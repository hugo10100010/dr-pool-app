abstract class JsonSerializable {
  Map<String, Object?> toJson();
  String get tablename;
  int get id;
}
