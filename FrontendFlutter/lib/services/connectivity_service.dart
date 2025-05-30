import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:proyecto/helpers/isonline_func.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  void startListeningForConnection(Future<void> Function() syncFunc) {
    // Cancel any previous subscription
    _subscription?.cancel();

    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        checkServerAvailabilityAndSync(syncFunc);
      }
    });
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }
}
