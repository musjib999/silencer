import 'dart:convert';

import 'package:silencer/core/service_injector/service_injectors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/utils/sound_profiles.dart';
import 'package:volume/volume.dart';
import 'package:sound_mode/sound_mode.dart';

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
        si.databaseService.readJson().then((value) async {
          for (var item in value) {
            String currentDay = si.timerService.getCurrentDay();
            if (currentDay == item['day']) {
              if (item['time']['start'] == decodedData['time']) {
                bool? isGranted = await PermissionHandler.permissionsGranted;

                if (!isGranted!) {
                  // Opens the Do Not Disturb Access settings to grant the access
                  await PermissionHandler.openDoNotDisturbSetting();
                }
                await SoundMode.setSoundMode(Profiles.SILENT);

                // await Volume.setVol(0, showVolumeUI: ShowVolumeUI.SHOW);
                print('Its lecture time');
              } else if (item['time']['stop'] == decodedData['time']) {
                await Volume.setVol(7, showVolumeUI: ShowVolumeUI.SHOW);
                print('Time for lecture has finished');
              }
            }
          }
        });
      },
    );
  }
}
