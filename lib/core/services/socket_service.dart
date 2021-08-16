import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;

late IO.Socket socket;

class SocketService {
  Future<void> connectToSocketServer() async {
    try {
      // Configure socket transports must be sepecified
      socket = IO.io('http://192.168.43.219:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (data) async {
        print('Connected to socket server ');
        getCurrentTime();
      });
    } catch (e) {
      print("Error connecting to socket server $e");
    }
  }

  void getCurrentTime() {
    socket.on(
      'EVENT:CURRENT:TIME',
      (data) {
        var decodedData = json.decode(data);
        print('The time is ${decodedData['time']}');
      },
    );
  }
}
