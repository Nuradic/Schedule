import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule/database/model_schedule.dart';

import '../database/databasehelper.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({Key? key}) : super(key: key);

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

//////////////////////////  Main State Class ////////////////////
class _AddScheduleState extends State<AddSchedule> {
  DateTimeRange? dRange;
  TimeOfDay? time;
  DateTime? startDateTime, endDateTime;
  // String test1 = "testing";
  TextEditingController subController = TextEditingController();
  TextEditingController chapController = TextEditingController();
  GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

  List<bool> isOpened = [false, false, false];
  var db = DatabaseHelper();
  @override
  void initState() {
    subController.addListener(() => {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              ExpansionPanelList(
                  elevation: 0,
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: Colors.transparent,
                      isExpanded: isOpened[0],
                      headerBuilder: (context, isOpen) => const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Content of your Schedule",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Column(
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
                                  border: OutlineInputBorder(),
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
                                  border: OutlineInputBorder(),
                                  labelText: "Chapter",
                                  hintText:
                                      " Chapter, Unit, Subtopic  here..."),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ExpansionPanel(
                      backgroundColor: Colors.transparent,
                      isExpanded: isOpened[1],
                      headerBuilder: (context, isOpen) => const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Date",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: const [
                                  Text('Start date'),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Text("04:08:23")
                                ]),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: const [
                                  Text('End  date'),
                                  SizedBox(
                                    width: 200,
                                  ),
                                  Text("14:08:23")
                                ]),
                              )),
                        ],
                      ),
                    ),
                    ExpansionPanel(
                      backgroundColor: Colors.transparent,
                      isExpanded: isOpened[2],
                      headerBuilder: (context, isOpen) => const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      body: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: const [
                                  Text('Start time'),
                                  SizedBox(
                                    width: 240,
                                  ),
                                  Text("04:23")
                                ]),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              margin: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: const [
                                  Text('End  time'),
                                  SizedBox(
                                    width: 240,
                                  ),
                                  Text("06:23")
                                ]),
                              )),
                        ],
                      ),
                    ),
                  ],
                  expansionCallback: (index, isOpen) {
                    // print(isOpened[index]);
                    isOpened[index] = !isOpen;
                    // print(isOpened[index]);
                    setState(() {});
                  }),
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
                        return Container(
                          margin: const EdgeInsets.only(left: 4, right: 4),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(children: [
                            Text(
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 188, 193, 205),
                                  fontSize: 20),
                              tabs[index],
                            ),
                          ]),
                        );
                      }),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Add schedule"),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

///////// Date and time Related Functions /////////////
  Future pickDateRange(BuildContext context) async {
    DateTimeRange? range = await showDateRangePicker(
      context: context,
      firstDate: //dRange != null ? dRange!.start :
          DateTime.now(),
      lastDate: //dRange != null? dRange!.end :
          DateTime.now().add(
        const Duration(days: 12),
      ),
    );

    if (range != null) {
      TimeOfDay? time =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      time ??= TimeOfDay(hour: range.start.hour, minute: range.start.minute);
      return DateTimeRange(
          start: DateTime(range.start.year, range.start.month, range.start.day,
              time.hour, time.minute),
          end: range.end);
    }

    return null;
  }
}
