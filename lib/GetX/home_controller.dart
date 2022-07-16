import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/databasehelper.dart';
import '../database/model_schedule.dart';

class HomeController extends GetxController {
  RxList<Schedule> scheduleList = <Schedule>[].obs;
  DateTimeRange? dRange;
  RxList<bool> isDay =
      <bool>[false, false, false, false, false, false, false].obs;
  Timer? time;
  RxInt sec = 1.obs;
  Rx<DateTime> dateTime = DateTime.now().obs;
  void startTimer() async {
    time = Timer.periodic(const Duration(seconds: 1), (_) {
      sec.value++;
      dateTime(DateTime.now());
      isCurrentWeekDay();
      theDays();
      // print(isDay);
    });
  }

  isCurrentWeekDay() {
    dateTime.value.weekday == 7 ? isDay[0] = true : isDay[0] = false;
    for (int i = 1; i < 7; i++) {
      if (i == dateTime.value.weekday) {
        isDay[i] = true;
      }
    }
  }

  theDays() {
    RxInt weekDay = DateTime.now().weekday.obs;
    weekDay.value == 7 ? weekDay(0) : weekDay;
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

  void removeSchedule(int index) {
    var db = DatabaseHelper();
    db.deleteSchedule(scheduleList[index]);
    scheduleList.removeAt(index);
  }

  void initiateDb() async {
    var db = DatabaseHelper();
    await db.getScheduleList().then((value) {
      scheduleList(value);
    });
  }

  @override
  void onClose() {
    time!.cancel();
    super.onClose();
  }

  @override
  onInit() {
    startTimer();
    initiateDb();
    super.onInit();
  }
}
