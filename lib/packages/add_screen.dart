import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/database/model_schedule.dart';

import '../database/databasehelper.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

//////////////  Main State Class ////////////////////
class _AddScheduleState extends State<AddSchedule> {
  DateTimeRange? range;
  TextEditingController? subController;
  TextEditingController? chapController;
  GlobalKey<FormState> myFormkey = GlobalKey<FormState>();

  // void initiateDb() async {
  //   var db = DatabaseHelper();
  //   scheduleList = await db.getScheduleList();
  // }
  var db = DatabaseHelper();
  @override
  void initState() {
    // initiateDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white.withAlpha(200).withOpacity(0.8),
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
          key: myFormkey,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: subController,
                validator: (userInput) {
                  if (userInput!.isEmpty) {
                    return "Please add Subject to the schedule of Study";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Subject",
                    hintText: "Add Subject here..."),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: chapController,
                validator: (userInput) {
                  if (userInput!.isEmpty) {
                    return "Please add Chapter to the schedule of Study";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Chapter",
                    hintText: "Add Chapter here..."),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 40, top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 30)),
                      onPressed: () {
                        if (myFormkey.currentState!.validate()) {
                          db.insertSchedule(
                            Schedule(
                              subject: "Physics",
                              description: "description",
                              startDate: DateTime(2001),
                              endDate: DateTime(2004),
                            ),
                          );
                        }
                      },
                      child: const Text("Start Date"),
                    ),
                  ),
                  const SizedBox(width: 80),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 30)),
                      onPressed: () async {
                        range =
                            await pickDateRange(context).then((value) => value);
                      },
                      child: const Text("End Date"),
                    ),
                  ),
                ],
              ),
            ]),
          )),
    );
  }

///////// Date and time Related Functions /////////////
  Future pickDateRange(BuildContext context) async {
    DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 12),
      ),
    );
    return range;
  }

  Future pickTime(BuildContext context) async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    return time;
  }
}
