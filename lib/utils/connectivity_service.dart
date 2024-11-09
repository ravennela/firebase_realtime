import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() {
    return _instance;
  }

  ConnectivityService._internal();

  Connectivity get connectivity => _connectivity;

  void listenToConnectionChanges(Function(ConnectivityResult) onChange) {
    _subscription = _connectivity.onConnectivityChanged.listen(onChange);
  }

  void dispose() {
    _subscription?.cancel();
  }
}
