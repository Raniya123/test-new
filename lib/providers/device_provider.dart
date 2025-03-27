import 'package:flutter/material.dart';
import '../models/device_state.dart';
import 'dart:math';
import '../services/websocket_service.dart';

class DeviceProvider extends ChangeNotifier {
  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;
  DeviceCommand _lastCommand = DeviceCommand.none;

  ConnectionStatus get connectionStatus => _connectionStatus;
  DeviceCommand get lastCommand => _lastCommand;

  final websocketService = WebSocketService();

  Future<void> pairDevice() async {
    _connectionStatus = ConnectionStatus.connecting;
    notifyListeners();

    websocketService.initConnectionToHelmet();
    websocketService.communicateWithHelmet("pair");

    _connectionStatus = ConnectionStatus.connected;
    notifyListeners();
  }

  Future<void> unPairDevice() async {
    _connectionStatus = ConnectionStatus.disconnecting;
    notifyListeners();
    websocketService.communicateWithHelmet("stop");
    _connectionStatus = ConnectionStatus.disconnected;
    _lastCommand = DeviceCommand.none;
    notifyListeners();
  }

  void sendCommand(DeviceCommand command) {
    if (_connectionStatus != ConnectionStatus.connected) return;

     websocketService.communicateWithHelmet(command.toString());
    _lastCommand = command;
    notifyListeners();
  }
}
