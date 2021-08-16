import 'dart:convert';

import 'package:flutter/services.dart';

class DatabaseService {
  Future getTimeTable() async {
    final String response =
        await rootBundle.loadString('assets/json/time_table.json');
    final data = await json.decode(response);
    return data;
  }
}
