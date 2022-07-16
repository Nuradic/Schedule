import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/GetX/home_bind.dart';
import 'package:schedule/packages/add_screen.dart';
import 'package:schedule/packages/home.dart';
import 'package:schedule/packages/temporary.dart';

void main() {
  runApp(const ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  const ScheduleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.dark,
        darkTheme: MyThemes.light,
        debugShowCheckedModeBanner: false,
        title: 'Schedule',
        getPages: [
          GetPage(
              name: '/home',
              page: () => MyHomePage(title: 'Schedule'),
              binding: HomeBinding()),
          GetPage(
            name: "/addSchedule",
            page: () => AddSchedule(),
          ),
          GetPage(
            name: '/temp',
            page: () => Temp(),
          ),
        ],
        initialRoute: '/home');
  }
}

class MyThemes {
  static final dark = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
  );
  static final light = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
  );
}
