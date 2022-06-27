import 'dart:ui';

// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sqflite/sqflite.dart';

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
  List<Map<String, dynamic>> scheduleMap = [
    {
      "subject": "Mathematics",
      "date": "12:09",
      "chapter": "Further on Relation"
    }
  ];
  List<Schedule> scheduleList = [];
  void initiateDb() async {
    var db = DatabaseHelper();
    scheduleList = await db.getScheduleList();
  }

  @override
  void initState() {
    initiateDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  return Container(
                    margin: const EdgeInsets.only(left: 4, right: 4),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Text(
                          style: const TextStyle(
                              color: Color.fromARGB(255, 188, 193, 205),
                              fontSize: 20),
                          tabs[index],
                        ),
                        const Text("23")
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
                  Text("Time"),
                  SizedBox(width: 100),
                  Text("Subject"),
                  SizedBox(width: 130),
                  Icon(Icons.sort_sharp)
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subDetail(int index) {
    return Row(
      children: [
        Column(children: [
          Text(scheduleList[index].subject != null
              ? scheduleList[index].subject!
              : "Nothing really"),
          const SizedBox(height: 10),
          const Text("5:33")
        ]),
        VerticalDivider(
          color: Colors.grey.withOpacity(0.5),
          thickness: 2,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 230, 243, 242),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(scheduleMap[index]["subject"]),
                ],
              ),
              const SizedBox(height: 40),
              Text(scheduleMap[index]["chapter"]),
              const SizedBox(height: 80),
              Row(
                children: const [
                  Icon(
                    Icons.timer,
                    size: 18,
                  ),
                  Text("  Only 10 days left for this Chapter"),
                ],
              ),
              Row(
                children: const [
                  SizedBox(width: 250),
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

class MyDelegate extends SliverPersistentHeaderDelegate {
  Widget? widget;
  MyDelegate(this.widget);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget!;
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
