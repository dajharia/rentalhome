import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  final _connectivity = Connectivity();
  final _controller = StreamController<bool>();

  NetworkService() {
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _controller.add(result != ConnectivityResult.none);
    });
  }

  Stream<bool> get networkStream => _controller.stream;

  void dispose() {
    _controller.close();
  }
}
