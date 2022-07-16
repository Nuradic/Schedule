import 'package:get/get.dart';
import 'package:schedule/GetX/home_controller.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
