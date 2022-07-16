// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

// @immutable
class Temp extends StatelessWidget {
  Temp({Key? key}) : super(key: key);
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    // List<String> tabs = ["S", "M", "T", "W", "T", "F", "S"];
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Center(
            child: Column(
          children: [
            Text("${homeController.dateTime.value.second}"),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Click"),
            ),
          ],
        )),
      ),
    );
  }
}
