import 'package:simple_calculator/controller/calculate_controller.dart';
import 'package:simple_calculator/controller/theme_controller.dart';
import 'package:get/instance_manager.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalculateController());
    Get.lazyPut(() => ThemeController());
  }
}
