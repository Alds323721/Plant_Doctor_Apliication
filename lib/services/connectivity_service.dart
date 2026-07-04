import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/logger.dart';

/// Service for checking network connectivity
class ConnectivityService {
  static ConnectivityService? _instance;
  final Connectivity _connectivity;
  StreamSubscription<ConnectivityResult>? _subscription;

  // Stream controller for connectivity changes
  final _connectivityController = StreamController<bool>.broadcast();

  // Private constructor
  ConnectivityService._({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  // Singleton instance
  static ConnectivityService get instance {
    _instance ??= ConnectivityService._();
    return _instance!;
  }

  /// Get stream of connectivity changes
  Stream<bool> get onConnectivityChanged => _connectivityController.stream;

  /// Check if device has internet connection
  Future<bool> hasConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return _isConnected(result);
    } catch (e) {
      Logger.error('Error checking connectivity', tag: 'ConnectivityService', error: e);
      return false;
    }
  }

  /// Start listening to connectivity changes
  void initialize() {
    if (_subscription != null) return;

    _subscription = _connectivity.onConnectivityChanged.listen(
      (result) {
        final isConnected = _isConnected(result);
        Logger.info(
          'Connectivity changed: ${isConnected ? "Connected" : "Disconnected"}',
          tag: 'ConnectivityService',
        );
        if (!_connectivityController.isClosed) {
          _connectivityController.add(isConnected);
        }
      },
      onError: (error) {
        Logger.error('Connectivity stream error', tag: 'ConnectivityService', error: error);
        if (!_connectivityController.isClosed) {
          _connectivityController.add(false);
        }
      },
    );
  }

  /// Check if connectivity result indicates connection
  bool _isConnected(ConnectivityResult result) {
    return result != ConnectivityResult.none;
  }

  /// Get connection type as string
  Future<String> getConnectionType() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.wifi) {
        return 'WiFi';
      } else if (result == ConnectivityResult.mobile) {
        return 'Mobile Data';
      } else if (result == ConnectivityResult.ethernet) {
        return 'Ethernet';
      } else {
        return 'No Connection';
      }
    } catch (e) {
      Logger.error('Error getting connection type', tag: 'ConnectivityService', error: e);
      return 'Unknown';
    }
  }

  /// Dispose resources
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    if (!_connectivityController.isClosed) {
      _connectivityController.close();
    }
  }
}