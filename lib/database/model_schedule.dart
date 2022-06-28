// import 'package:flutter/material.dart';

class Schedule {
  DateTime? startDate, endDate;
  int? id;
  int? sid, cid, did, weekId, stid;
  String? subject, chapter;
  Map<String, dynamic> whichDay = {
    // if(schedule.weekId!=null)"weekId":schedule.weekId,
    "weekId": null,
    "sunday": false,
    "monday": false,
    "tuesday": false,
    "wednesday": false,
    "thursday": false,
    "friday": false,
    "saturday": false
  };
  Schedule(
      {required this.subject,
      required this.chapter,
      required this.startDate,
      required this.endDate,
      this.sid});

  static Map<String, Map<String, dynamic>> toMapMap(Schedule schedule) {
    return {
      "scTab": {
        if (schedule.sid != null) "sid": schedule.sid,
        "subject": schedule.subject,
        "did": schedule.did,
        "cid": schedule.cid,
      },
      "chapter": {
        if (schedule.cid != null) "cid": schedule.cid, //"cid": schedule.cid,
        "chapter": schedule.chapter,
      },
      "dateTimeTab": {
        if (schedule.did != null) "did": schedule.sid, // "did": schedule.did,
        "hour": schedule.startDate!.hour,
        "minute": schedule.startDate!.minute,
        "weekId": schedule.weekId,
      },
      "dateTab": {
        if (schedule.stid != null) "stid": schedule.stid, //"weekId":
        "sday": schedule.startDate!.day,
        "smonth": schedule.startDate!.month,
        "syear": schedule.startDate!.year,
        "eday": schedule.startDate!.day,
        "emonth": schedule.startDate!.month,
        "eyear": schedule.startDate!.year,
      },
      "weekTab": schedule.whichDay
    };
  }

  static Schedule fromMap(Map<String, Map<String, dynamic>> map) {
    return Schedule(
        subject: map['scTab']!["subject"],
        chapter: map["chapter"]!["chapter"],
        startDate: DateTime(
            map["dateTab"]!["syear"],
            map['dateTab']!["smonth"],
            map["dateTab"]!["sday"],
            map["dateTimeTab"]!["hour"],
            map["dateTimeTab"]!["minute"]),
        endDate: DateTime(
          map["dateTab"]!["eyear"],
          map['dateTab']!["emonth"],
          map["dateTab"]!["eday"],
        ),
        sid: map["sciTab"]!["sid"]);
  }
}
