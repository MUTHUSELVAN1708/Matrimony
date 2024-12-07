// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:matrimony/network_provider/network_state.dart';

class NetworkProvider extends StateNotifier<NetworkState> {
  NetworkProvider() : super(const NetworkInitial());

  void _setLowNetworkState() =>
      state = LowNetwork(connectivityResult: state.connectivityResult);

  StreamSubscription<ConnectivityResult>? subscription;

  void disposeState() {
    subscription?.cancel();
    state = const NetworkInitial();
  }

  Future<void> initialize() async {
    final initialResult = await Connectivity().checkConnectivity();
    state = state.copyWith(connectivityResult: initialResult);
    subscribe();
  }

  void subscribe() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      state = state.copyWith(connectivityResult: result);
    });
  }

  Future<bool> checkNetworkLatency() async {
    final url = Uri.parse('https://www.google.com');

    if (kIsWeb) {
      return false;
    } else {
      try {
        final response = await get(url).timeout(const Duration(seconds: 1),
            onTimeout: () async {
          return Response('Request timed out', 408);
        });

        if (response.statusCode == 200) {
          return false;
        } else {
          if (state.connectivityResult != ConnectivityResult.none) {
            _setLowNetworkState();
          }
          return true;
        }
      } catch (e) {
        if (state.connectivityResult != ConnectivityResult.none) {
          _setLowNetworkState();
        }
        return true;
      }
    }
  }
}
