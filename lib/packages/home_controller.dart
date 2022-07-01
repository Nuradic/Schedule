import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/databasehelper.dart';
import '../database/model_schedule.dart';

class HomeController extends GetxController {
  RxList<Schedule> scheduleList = <Schedule>[].obs;
  DateTimeRange? dRange;
  RxList<bool> isDay = <bool>[].obs;

  isCurrentWeekDay() {
    DateTime.now().weekday == 7 ? isDay.add(true) : isDay.add(false);
    for (int i = 1; i < 7; i++) {
      if (i == DateTime.now().weekday) {
        isDay.add(true);
      } else {
        isDay.add(false);
      }
    }
  }

  theDays() {
    RxInt weekDay = DateTime.now().weekday.obs;
    weekDay = weekDay == 7.obs ? 0.obs : weekDay;
    DateTime dates = DateTime.now();

    for (RxInt i = weekDay; i >= 0; i--) {
      dates = dates.add(const Duration(days: -1));
    }

    List<int> days = [];
    for (int i = 0; i < 7; i++) {
      dates = dates.add(const Duration(days: 1));
      days.add(dates.day);
    }
    return days;
  }

  addSchedule(Schedule schedule) {
    scheduleList.add(schedule);
    var db = DatabaseHelper();
    db.insertSchedule(schedule);
  }

  void initiateDb() async {
    var db = DatabaseHelper();
    await db.getScheduleList().then((value) {
      scheduleList = value.obs;
    });
  }

  @override
  onInit() {
    initiateDb();
    isCurrentWeekDay();
    super.onInit();
  }
}
