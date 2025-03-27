import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'providers/device_provider.dart';
import 'ui/home_screen.dart';

void main() {
  runApp(NRChallengeApp());
}

class NRChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DeviceProvider(),
      child: MaterialApp(
        title: 'NR Challenge',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreenWrapper(),
      ),
    );
  }
}

class HomeScreenWrapper extends StatefulWidget {
  @override
  _HomeScreenWrapperState createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  @override
  void initState() {
    super.initState();
    runPythonScript();
  }

  Future<void> runPythonScript() async {
    try {
      // Load script from assets
      String script = await rootBundle.loadString('assets/simulator.py');

      // Write to temporary file
      final tempDir = await Directory.systemTemp.createTemp();
      final tempScriptFile = File('${tempDir.path}/simulator.py');
      await tempScriptFile.writeAsString(script);

      // Run the Python script
      ProcessResult result = await Process.run('python3', [tempScriptFile.path]);

      print('Output: ${result.stdout}');
      print('Errors: ${result.stderr}');
    } catch (e) {
      print('Error running Python script: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
