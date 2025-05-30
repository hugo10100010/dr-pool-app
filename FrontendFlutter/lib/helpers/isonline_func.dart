import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'package:proyecto/constants/api_constants.dart';

DateTime? _lastSyncTime;

void debouncedSync(Function syncFunc) {
  final now = DateTime.now();
  if (_lastSyncTime == null || now.difference(_lastSyncTime!) > Duration(seconds: 5)) {
    _lastSyncTime = now;
    checkServerAvailabilityAndSync(() => syncFunc());
  }
}

Future<bool> isOnline() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

Future<bool> isServerAvailable() async {
  try {
    final response = await http.get(Uri.parse('${baseUrl}/ping'))
      .timeout(Duration(seconds: 5));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}

void checkServerAvailabilityAndSync(Future<void> Function() syncFunc) async {
  if (await isServerAvailable()) {
    await syncFunc();
  }
}
