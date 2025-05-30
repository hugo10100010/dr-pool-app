import 'package:proyecto/helpers/jsonserializable_interface.dart';

abstract class Syncable extends JsonSerializable {
  int get syncStatus;
  set syncStatus(int value);
}