// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Schedule {
  DateTimeRange? dateTimeRange;
  int? id;
  int? sid, cid, did, weekId, date;
  String subject, chapter;
  Map<String, int> whichDay = {
    "sunday": 0,
    "monday": 0,
    "tuesday": 0,
    "wednesday": 0,
    "thursday": 0,
    "friday": 0,
    "saturday": 0
  };
  Schedule(
      {required this.subject,
      required this.chapter,
      required this.dateTimeRange,
      this.sid});

  static List<Map<String, dynamic>> listMap(Schedule schedule) {
    return [
      {
        if (schedule.sid != null) "sid": schedule.sid,
        "subject": schedule.subject,
        "did": schedule.did,
        "cid": schedule.cid,
      },
      {
        "did": schedule.did, // "did": schedule.did,
        "hour": schedule.dateTimeRange!.start.hour,
        "minute": schedule.dateTimeRange!.start.minute,
        "weekId": schedule.weekId,
      },
      {
        "cid": schedule.cid, //"cid": schedule.cid,
        "name": schedule.chapter,
      },
      {
        " date": schedule.date, //"weekId":
        "sday": schedule.dateTimeRange!.start.day,
        "smonth": schedule.dateTimeRange!.start.month,
        "syear": schedule.dateTimeRange!.start.year,
        "eday": schedule.dateTimeRange!.end.day,
        "emonth": schedule.dateTimeRange!.end.month,
        "eyear": schedule.dateTimeRange!.end.year,
      },
      schedule.whichDay
    ];
  }

  static Schedule fromMap(List<Map<String, dynamic>> listMap) {
    return Schedule(
        subject: listMap[0]["subject"],
        chapter: listMap[2]["name"],
        dateTimeRange: DateTimeRange(
          start: DateTime(
            listMap[3]["syear"],
            listMap[3]["smonth"],
            listMap[3]["sday"],
            listMap[1]["hour"],
            listMap[1]["minute"],
          ),
          end: DateTime(
            listMap[3]["eyear"],
            listMap[3]["emonth"],
            listMap[3]["eday"],
          ),
        ),
        sid: listMap[0]["sid"]);
  }
}
