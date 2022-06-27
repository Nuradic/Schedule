class Schedule {
  DateTime? startDate, endDate;
  int? id;
  String? subject, chapter, description;
  Schedule(
      {required this.subject,
      required this.description,
      required this.startDate,
      required this.endDate,
      id});

  static Map<String, dynamic> toMap(Schedule schedule) {
    return {
      if (schedule.id != null) "id": schedule.id,
      "subject": schedule.subject,
      "description": schedule.subject,
    };
  }

  static Schedule fromMap(Map<String, dynamic> map) {
    return Schedule(
        subject: map["subject"],
        description: map["description"],
        startDate: map["date"],
        endDate: map["date"]);
  }
}
