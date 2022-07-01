import 'package:get/get.dart';
import 'package:schedule/packages/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
