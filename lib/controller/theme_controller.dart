import 'package:get/get.dart';

class ThemeController extends GetxController {
  bool isDark = true;

  lightTheme() {
    isDark = false;
    update();
  }

  darkTheme() {
    isDark = true;
    update();
  }

  trueOrFalse() {
    if (isDark == true) {
      return lightTheme();
    } else {
      darkTheme();
    }
  }
}
