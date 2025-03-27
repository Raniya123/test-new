import 'package:web_socket_channel/web_socket_channel.dart';

// lib docs: https://pub.dev/documentation/web_socket_channel/latest/web_socket_channel/

class WebSocketService {
  late WebSocketChannel _channel;

  void initConnectionToHelmet() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:8000/ws'),
    );

    _channel.stream.listen((message) {
      print('response: $message');
    });
  }

  void communicateWithHelmet(String command) {
    // todo: listen to response  and return it
    _channel.sink.add(command);
  }

  void disconnectHelmet() {
    // todo: assert that it was indeed closed
    _channel.sink.close();
  }
}
