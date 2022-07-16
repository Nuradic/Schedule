import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:schedule/database/model_schedule.dart';
import '../database/databasehelper.dart';
import 'home_controller.dart';

class AddSchedule extends StatelessWidget {
  AddSchedule({Key? key}) : super(key: key);
  final homeController = Get.put(HomeController());
  DateTimeRange? dRange;
  TimeOfDay? time;
  DateTime? startDateTime, endDateTime;
  final subController = TextEditingController();
  final chapController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  DateTimeRange? myRangeDate;
  TimeOfDay? startTime, endTime;
  DateTime? startDate, endDate;
  var db = DatabaseHelper();

  @override
  Widget build(context) {
    List<String> tabs = ["S", "M", "T", "W", "T", "F", "S"];
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 1, 132, 127),
          ),
        ),
        title: const Text(
          "Add your Schedule",
          style: TextStyle(
            color: Color.fromARGB(255, 1, 132, 127),
          ),
        ),
      ),
      body: Form(
        key: myFormKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Add your Schedule",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.transparent,
                        )
                      ],
                      color: Colors.transparent,
                    ),
                    child: TextFormField(
                      controller: subController,
                      onChanged: (userInput) {
                        myFormKey.currentState!.validate();
                      },
                      validator: (userInput) {
                        if (userInput!.isEmpty) {
                          return "Please add Subject to the schedule of Study ";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          labelText: "Subject",
                          hintText: "  Subject, Course, Topic..."),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      onChanged: (userInput) {
                        myFormKey.currentState!.validate();
                      },
                      controller: chapController,
                      validator: (userInput) {
                        if (userInput!.isEmpty) {
                          return "Please add Chapter to the schedule of Study";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                          labelText: "Chapter",
                          hintText: " Chapter, Unit, Subtopic  here..."),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 20, right: 20, bottom: 8),
                child: Row(children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        onChanged: (userInput) {
                          myFormKey.currentState!.validate();
                        },
                        controller: startDateController,
                        validator: (userInput) {
                          if (startDate == null) {
                            return 'please pick start date for your schedule';
                          }
                          return null;
                        },
                        cursorColor: Colors.white.withOpacity(0).withAlpha(0),
                        onTap: () async {
                          startDate = await pickDate(context);
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.none,
                        decoration: const InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.calendarDays,
                                  size: 20),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "Start",
                            hintText: "  _*_/_*_/_*_"),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        onChanged: (userInput) {
                          myFormKey.currentState!.validate();
                        },
                        controller: endDateController,
                        validator: (userInput) {
                          if (endDate == null) {
                            return 'please pick end date for your schedule';
                          }
                          return null;
                        },
                        cursorColor: Colors.white.withOpacity(0).withAlpha(0),
                        onTap: () async {
                          endDate = await pickDate(context);
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.none,
                        decoration: const InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.calendarDays,
                                  size: 20),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "End", //todo
                            hintText: "  _*_/_*_/_*_"),
                      ),
                    ),
                  ),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Time interval",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 20, right: 20, bottom: 8),
                child: Row(children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        controller: startTimeController,
                        validator: (userInput) {
                          if (startTime == null) {
                            return 'please pick start time for your schedule';
                          }
                          return null;
                        },
                        cursorColor: Colors.white.withOpacity(0).withAlpha(0),
                        onTap: () async {
                          startTime = await pickTime(context);
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.none,
                        decoration: const InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.clock, size: 20),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "Start",
                            hintText: "  _*_:_*_"),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
                        cursorColor: Colors.white.withOpacity(0).withAlpha(0),
                        controller: endTimeController,
                        validator: (userInput) {
                          if (endTime == null) {
                            return 'please pick end time for your schedule';
                          }
                          return null;
                        },
                        onTap: () async {
                          endTime = await pickTime(context);
                        },
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.none,
                        decoration: const InputDecoration(
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: FaIcon(FontAwesomeIcons.clock, size: 20),
                            ),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "End",
                            hintText: "  _*_:_*_"),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (myFormKey.currentState!.validate()) {
                      var tempSchedule = Schedule(
                          subject: subController.text,
                          chapter: chapController.text,
                          dateTimeRange: myRangeDate);
                      Get.defaultDialog(
                          backgroundColor: Colors.teal,
                          title: 'Choose Days of the week',
                          cancel: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.redAccent)),
                          ),
                          confirm: ElevatedButton(
                            onPressed: () {
                              bool add = false;
                              for (int i = 0; i < 7; i++) {
                                if (tempSchedule.whichDayToListBool()[i]) {
                                  add = true;
                                  break;
                                }
                              }
                              if (add) {
                                myRangeDate = myRange(
                                    startDate, endDate, startTime, endTime);
                                if (myRangeDate != null) {
                                  homeController.addSchedule(tempSchedule);
                                  Get.back();
                                }
                              }
                            },
                            child: const Text('Ok',
                                style: TextStyle(color: Colors.white)),
                          ),
                          content: SizedBox(
                            height: 250,
                            width: 200,
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                ),
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 0,
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 4),
                                    color: tempSchedule.whichDay[index] == 1
                                        ? Colors.amber
                                        : Colors.white,
                                    child: InkWell(
                                      splashColor: Colors.amber,
                                      onTap: () {
                                        tempSchedule
                                                .whichDayToListBool()[index] =
                                            !tempSchedule
                                                .whichDayToListBool()[index];
                                      },
                                      child: Center(
                                        child: Text(
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 188, 193, 205),
                                              fontSize: 20),
                                          tabs[index],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )); /////////

                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add schedule"),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  } ////////////////////////Date and time Related Function/////////////////////////

  DateTimeRange? myRange(
      DateTime? sday, DateTime? eday, TimeOfDay? stime, TimeOfDay? etime) {
    if (sday != null && eday != null && stime != null && etime != null) {
      return DateTimeRange(
          start: DateTime(
              sday.year, sday.month, sday.day, stime.hour, stime.minute),
          end: DateTime(
              eday.year, eday.month, eday.day, etime.hour, etime.minute));
    }
    return null;
  }

  Future pickDate(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -10)),
      lastDate: DateTime.now().add(
        const Duration(days: 12),
      ),
    );

    return date;
  }

  Future pickTime(context) async {
    return await showTimePicker(context: context, initialTime: TimeOfDay.now());
  }
}
