import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/packages/home.dart';

void main() {
  runApp(const ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  const ScheduleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Schedules'),
    );
  }
}

class DarkOrLight {}
