import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../database/databasehelper.dart';
import '../database/model_schedule.dart';
import 'add_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

////////////////////////////////////////////////////
class _MyHomePageState extends State<MyHomePage> {
  DateTimeRange? myDayRange;
  // myDayRange.
  // List<Map<String, dynamic>> scheduleMap = [
  //   {
  //     "subject": "Mathematics",
  //     "date": "12:09",
  //     "chapter": "Further on Relation"
  //   }
  // ];
  List<Schedule> scheduleList = [];
  void initiateDb() async {
    var db = DatabaseHelper();
    await db.getScheduleList().then((value) {
      scheduleList = value;
      setState(() {});
    });
  }

  @override
  void initState() {
    initiateDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(scheduleList);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(shrinkWrap: true, slivers: [
        SliverAppBar(
          shadowColor: Colors.transparent,
          stretch: true,
          pinned: true,
          backgroundColor: Colors.white.withAlpha(200).withOpacity(0.8),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.transparent),
            ),
          ),
          actions: [
            TextButton(
              // style: TextButton.styleFrom(
              //     fixedSize: const Size(10, 5), backgroundColor: Colors.blue),
              onPressed: () {},
              child: const Text(
                "Today",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 132, 127), fontSize: 16),
              ),
            )
          ],
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.teal),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: MyDelegate(
            header(),
          ),
        ),
        sliverBuild(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddSchedule());
        },
        tooltip: 'Add New Schedule',
        child: const Icon(Icons.add),
      ),
    );
  }

/////////////////////////////////// Functions //////////////////////////////////
  Widget adapter(Widget widget) {
    return SliverToBoxAdapter(
      child: widget,
    );
  }

  Widget header() {
    List<String> tabs = ["S", "M", "T", "W", "T", "F", "S"];
    var weekDay = DateTime.now().weekday;
    weekDay = weekDay == 7 ? 0 : weekDay;
    DateTime currentDate = DateTime.now();
    // int sunDate = 11;
    for (int i = weekDay; i >= 0; i--) {
      currentDate = currentDate.add(const Duration(days: -1));
    }
    // print(weekDay);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
          child: Column(
            children: [
              GridView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  currentDate = currentDate.add(const Duration(days: 1));
                  String tempDay = currentDate.day.toString().padLeft(2, '0');
                  return Container(
                    margin: const EdgeInsets.only(left: 4, right: 4),
                    decoration: BoxDecoration(
                        color: weekDay != index ? Colors.white : Colors.amber),
                    child: Column(
                      children: [
                        Text(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 188, 193, 205),
                              fontSize: 20),
                          tabs[index],
                        ),
                        Text(tempDay)
                      ],
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                shrinkWrap: true,
              ),
              Padding(
                // height: 20,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Row(children: const [
                  Text("Time",
                      style: TextStyle(
                          color: Color.fromARGB(255, 188, 193, 205),
                          fontSize: 16)),
                  SizedBox(width: 100),
                  Text("Subject",
                      style: TextStyle(
                          color: Color.fromARGB(255, 188, 193, 205),
                          fontSize: 16)),
                  SizedBox(width: 130),
                  Icon(
                    Icons.sort_sharp,
                    color: Color.fromARGB(255, 188, 193, 205),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subDetail(int index) {
    var shour = scheduleList[index]
        .dateTimeRange!
        .start
        .hour
        .toString()
        .padLeft(2, '0');
    var sminute = scheduleList[index]
        .dateTimeRange!
        .start
        .minute
        .toString()
        .padLeft(2, '0');
    var ehour =
        scheduleList[index].dateTimeRange!.end.hour.toString().padLeft(2, '0');
    var eminute = scheduleList[index]
        .dateTimeRange!
        .end
        .minute
        .toString()
        .padLeft(2, '0');
    var duration = scheduleList[index].dateTimeRange!.duration.inDays;

    return Row(
      children: [
        Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text("$shour:$sminute",
                style: TextStyle(
                    color: Colors.black.withAlpha(180), fontSize: 16)),
          ),
          const SizedBox(height: 10),
          Text(
            "$ehour:$eminute",
            style: const TextStyle(
                color: Color.fromARGB(255, 188, 193, 205), fontSize: 16),
          )
        ]),
        VerticalDivider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 2,
        ),
        Container(
          height: 285,
          width: 280,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 230, 243, 242),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      scheduleList[index].subject,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Expanded(child: SizedBox(width: 160)),
                  const Icon(Icons.more_vert),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    scheduleList[index].chapter,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 112, 112, 112),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Row(
                children: [
                  const Icon(
                    Icons.timer,
                    size: 18,
                  ),
                  Text("   $duration days left for the Chapter",
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 112, 112, 112))),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: 240),
                  Icon(Icons.radio_button_off,
                      size: 20, color: Color.fromARGB(255, 196, 196, 196)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget sliverBuild() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, index) {
          return subDetail(index);
        },
        childCount: scheduleList.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 1.6,
      ),
    );
  }
}

////////////delegate for sliver object////////////
class MyDelegate extends SliverPersistentHeaderDelegate {
  Widget? widget;
  MyDelegate(this.widget);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget!;
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 120;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
