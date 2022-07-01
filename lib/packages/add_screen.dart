import 'package:flutter/material.dart';
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
  TextEditingController subController = TextEditingController();
  TextEditingController chapController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

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
                            suffixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "Start",
                            hintText: "  19/02/23"),
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextFormField(
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
                            suffixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "End", //todo
                            hintText: "  21/02/23"),
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
                            suffixIcon: Icon(Icons.av_timer),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "Start",
                            hintText: "  19:23"),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 30),
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
                            suffixIcon: Icon(Icons.av_timer),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            labelText: "End",
                            hintText: "  21:23"),
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Day of the week",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                      ),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(left: 4, right: 4),
                          color: Colors.white,
                          child: InkWell(
                            splashColor: Colors.amber,
                            onTap: () {},
                            child: Center(
                              child: Text(
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 188, 193, 205),
                                    fontSize: 20),
                                tabs[index],
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (myFormKey.currentState!.validate()) {
                      myRangeDate =
                          myRange(startDate, endDate, startTime, endTime);
                      if (myRangeDate != null) {
                        homeController.addSchedule(Schedule(
                            subject: subController.text,
                            chapter: chapController.text,
                            dateTimeRange: myRangeDate));
                        Get.back();
                      }
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

//////////////////////////  Main State Class ////////////////////
// class _AddScheduleState extends State<AddSchedule> {
 
//   @override
//   void initState() {
//     subController.addListener(() => {});

//     super.initState();
//   }

//   @override
//   void dispose() {
//     subController.dispose();
//     chapController.dispose();
//     startTimeController.dispose();
//     startDateController.dispose();
//     endTimeController.dispose();
//     endDateController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
    

//     return 
//   }

// }
