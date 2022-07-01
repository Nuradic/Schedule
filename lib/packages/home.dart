import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

//Todo: for some reason after restart the Getx is not working properly needed fixing this
//The CRUD operations are not Complete insert and fetching are working perfectly ,while delete and upgrade needs to be worked on

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final HomeController homeController = Get.find();
  final String title;

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(shrinkWrap: true, slivers: [
        SliverAppBar(
          shadowColor: Colors.transparent,
          stretch: true,
          pinned: true,
          backgroundColor: Colors.white.withAlpha(0).withOpacity(0),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.transparent),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.toNamed('/temp');
              },
              child: const Text(
                "Today",
                style: TextStyle(
                    color: Color.fromARGB(255, 1, 132, 127), fontSize: 16),
              ),
            )
          ],
          title: Text(
            title,
            style: const TextStyle(color: Colors.teal),
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: MyDelegate(header()),
        ),
        sliverBuild(),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/addSchedule');
        },
        tooltip: 'Add New Schedule',
        child: const Icon(Icons.add),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  Widget adapter(Widget widget) {
    return SliverToBoxAdapter(
      child: widget,
    );
  }

//////////// sliverheader////////////////////////////////
  Widget header() {
    List<String> tabs = ["S", "M", "T", "W", "T", "F", "S"];
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          color: Colors.white.withOpacity(0.8).withAlpha(0),
          child: Column(
            children: [
              GridView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.only(left: 4, right: 4),
                      color: homeController.isDay[index]
                          ? Colors.amber
                          : Colors.white,
                      child: InkWell(
                        splashColor: Colors.teal,
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              style: TextStyle(
                                  color: homeController.isDay[index]
                                      ? Colors.white
                                      : const Color.fromARGB(
                                          255, 188, 193, 205),
                                  fontSize: 20),
                              tabs[index],
                            ),
                            Text(homeController
                                .theDays()[index]
                                .toString()
                                .padLeft(2, '0'))
                          ],
                        ),
                      ),
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
                child: Row(children: [
                  const Text("Time",
                      style: TextStyle(
                          color: Color.fromARGB(255, 188, 193, 205),
                          fontSize: 16)),
                  const SizedBox(width: 100),
                  const Text("Subject",
                      style: TextStyle(
                          color: Color.fromARGB(255, 188, 193, 205),
                          fontSize: 16)),
                  const SizedBox(width: 130),
                  IconButton(
                    onPressed: () {},
                    splashColor: Colors.teal,
                    icon: const Icon(
                      Icons.sort_sharp,
                      color: Color.fromARGB(255, 188, 193, 205),
                    ),
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
    var shour = homeController.scheduleList[index].dateTimeRange!.start.hour
        .toString()
        .padLeft(2, '0');
    var sminute = homeController.scheduleList[index].dateTimeRange!.start.minute
        .toString()
        .padLeft(2, '0');
    var ehour = homeController.scheduleList[index].dateTimeRange!.end.hour
        .toString()
        .padLeft(2, '0');
    var eminute = homeController.scheduleList[index].dateTimeRange!.end.minute
        .toString()
        .padLeft(2, '0');
    var duration =
        homeController.scheduleList[index].dateTimeRange!.duration.inDays;

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
        Card(
          margin: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: const Color.fromARGB(255, 230, 243, 242),
          child: SizedBox(
            height: 300,
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        homeController.scheduleList[index].subject,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Expanded(child: SizedBox(width: 160)),
                    IconButton(
                        splashColor: Colors.teal,
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          // print("Hello");
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      homeController.scheduleList[index].chapter,
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
                            color: Color.fromARGB(255, 112, 112, 112)))
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
        ),
      ],
    );
  }

  Widget sliverBuild() {
    print(homeController.scheduleList);
    return Obx(
      () => SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, index) {
            return subDetail(index);
          },
          childCount: homeController.scheduleList.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 1.6,
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<MyHomePage> {
//   DateTimeRange? myDayRange;
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

/////////////////////////////////// Functions //////////////////////////////////

/////////////////////////delegate for sliver object/////////////////////////////
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
  double get minExtent => 135;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
