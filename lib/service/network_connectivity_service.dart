import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_app/common/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._();

  ConnectivityService._();

  factory ConnectivityService() => _instance;

  List<ConnectivityResult> connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();

  ///should only called once
  Future<void> init() async {
    try {
      connectionStatus = await _connectivity.checkConnectivity();
      _connectionStreamSubscription();
    } on PlatformException catch (e) {
      print('Couldn\'t check connectivity status $e');
    }
  }

  Future<void> _connectionStreamSubscription() async {
    _connectivity.onConnectivityChanged.listen((_) async {
      connectionStatus = await _connectivity.checkConnectivity();
      print('checkkk connectivity  ${connectionStatus}');
      if (navigatorKey.currentState != null) {
        BuildContext context = navigatorKey.currentState!.context;

        if (connectionStatus.contains(ConnectivityResult.none)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Internet Connection')));
          }
        }
        if (connectionStatus.contains(ConnectivityResult.wifi) ||
            connectionStatus.contains(ConnectivityResult.mobile)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Connected to Internet')));
          }
        }
      }
    });
  }
}
