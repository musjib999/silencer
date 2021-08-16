import 'package:flutter/material.dart';
import 'package:silencer/core/service_injector/service_injectors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedTime = '';

  String selectedDay = '';
  List day = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  @override
  void initState() {
    super.initState();
    si.soundService.initAudioStreamType();
    // si.permissionService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            DropdownButtonFormField<dynamic>(
              validator: (value) {
                if (value == null) {
                  return 'Please select a state';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: Text('Select a Day'),
              items: day.map((item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                selectedDay = value;
              },
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {
                si.timerService.showTimePickerDialog(context).then((value) {
                  setState(() {
                    selectedTime = value;
                  });
                });
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(),
                ),
                child: Text(selectedTime == '' ? 'Choose Time' : selectedTime),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
