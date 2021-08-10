import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimerService {
  String getCurrentDay() {
    return DateFormat('EEEE').format(DateTime.now());
  }

  String getCurrentTime() {
    int hour = DateTime.now().hour;
    int minites = DateTime.now().minute;
    String currentTime = '$hour:$minites';

    return currentTime;
  }

  void getTimeStream() {}

  Future<TimeOfDay> showTimePickerDialog(BuildContext context) async {
    TimeOfDay time = TimeOfDay.now();
    final newTime = await showTimePicker(context: context, initialTime: time);
    time = newTime!;
    print(time);
    return time;
  }
}
