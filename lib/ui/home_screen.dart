import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/device_state.dart';
import '../providers/device_provider.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeviceProvider>(context);

    String getStatusText(ConnectionStatus status) {
      switch (status) {
        case ConnectionStatus.disconnected:
          return "Disconnected";
        case ConnectionStatus.connecting:
          return "Connecting...";
        case ConnectionStatus.connected:
          return "Connected";
        default:
          return "";
      }
    }

    String getCommandText(DeviceCommand command) {
      switch (command) {
        case DeviceCommand.start:
          return "Start";
        case DeviceCommand.pause:
          return "Pause";
        case DeviceCommand.stop:
          return "Stop";
        default:
          return "None";
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("NR Challenge"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              height: 20,
            ),
            SizedBox(height: 50),
            Text("Helmet Connection Status: ${getStatusText(provider.connectionStatus)}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Last Command: ${getCommandText(provider.lastCommand)}",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
              onPressed: provider.connectionStatus == ConnectionStatus.connected
                  ? null
                  : () => provider.pairDevice(),
              child: Text("Pair"),
            ),
            ElevatedButton(
              onPressed: provider.connectionStatus == ConnectionStatus.connected
                  ? () => provider.unPairDevice()
                  : null,
              child: Text("Un-Pair"),
            ),
              ] ),
            
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: provider.connectionStatus == ConnectionStatus.connected
                        ? () => provider.sendCommand(DeviceCommand.start)
                        : null,
                    child: Text("Start")),
                ElevatedButton(
                    onPressed: provider.connectionStatus == ConnectionStatus.connected
                        ? () => provider.sendCommand(DeviceCommand.pause)
                        : null,
                    child: Text("Pause")),
                ElevatedButton(
                    onPressed: provider.connectionStatus == ConnectionStatus.connected
                        ? () => provider.sendCommand(DeviceCommand.stop)
                        : null,
                    child: Text("Stop")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
