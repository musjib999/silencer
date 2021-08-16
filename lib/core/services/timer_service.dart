import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:silencer/core/service_injector/service_injectors.dart';
import 'package:volume/volume.dart';

class TimerService {
  String getCurrentDay() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  Stream<String> getTimeStream() async* {
    DateTime? time;

    while (true) {
      try {
        DateTime currentTime = DateTime.now();
        if (time != currentTime) {
          time = currentTime;
          yield DateFormat('KK:mm a').format(time);
        }
      } catch (e) {
        print(e);
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<String> showTimePickerDialog(BuildContext context) async {
    TimeOfDay time = TimeOfDay.now();
    final newTime = await showTimePicker(context: context, initialTime: time);
    time = newTime!;
    print(time.format(context));
    return time.format(context);
  }

  //schedule timetable
  void scheduleTimeTable() {
    si.timerService.getTimeStream().listen((event) {
      print(event);
      var currentTime = event;
      si.databaseService.getTimeTable().then((value) async {
        for (var item in value) {
          String currentDay = si.timerService.getCurrentDay();
          if (currentDay == item['day']) {
            if (item['time']['start'] == currentTime) {
              await Volume.setVol(0, showVolumeUI: ShowVolumeUI.HIDE);
              print('Its lecture time');
            } else if (item['time']['stop'] == currentTime) {
              await Volume.setVol(7, showVolumeUI: ShowVolumeUI.HIDE);
              print('Time for lecture has finished');
            }
          }
        }
      });
    });
  }
}
