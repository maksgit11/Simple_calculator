import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/theme_controller.dart';
import '../controller/calculate_controller.dart';
import '../utils/colors.dart';
import '../widget/button.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "AC",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();
    var themeController = Get.find<ThemeController>();

    return GetBuilder<ThemeController>(builder: (context) {
      return Scaffold(
        backgroundColor: themeController.isDark
            ? DarkColors.scaffoldBgColor
            : LightColors.scaffoldBgColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GetBuilder<CalculateController>(builder: (context) {
                return outPutSection(themeController, controller);
              }),
              inPutSection(themeController, controller),
            ],
          ),
        ),
      );
    });
  }

  Expanded inPutSection(
      ThemeController themeController, CalculateController controller) {
    return Expanded(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: themeController.isDark
                ? DarkColors.sheetBgColor
                : LightColors.sheetBgColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 20),
            itemCount: buttons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (contex, index) {
              switch (index) {
                case 0:
                  return CustomButton(
                      buttonTapped: () {
                        controller.clearInputAndOutput();
                      },
                      color: themeController.isDark
                          ? DarkColors.btnBgColor
                          : LightColors.btnBgColor,
                      textColor: themeController.isDark
                          ? DarkColors.leftOperatorColor
                          : LightColors.leftOperatorColor,
                      text: buttons[index]);
                case 1:
                  return CustomButton(
                      buttonTapped: () {
                        controller.deleteBtnAction();
                      },
                      color: themeController.isDark
                          ? DarkColors.btnBgColor
                          : LightColors.btnBgColor,
                      textColor: themeController.isDark
                          ? DarkColors.leftOperatorColor
                          : LightColors.leftOperatorColor,
                      text: buttons[index]);
                case 19:
                  return CustomButton(
                      buttonTapped: () {
                        controller.equalPressed();
                      },
                      color: themeController.isDark
                          ? DarkColors.btnBgColor
                          : LightColors.btnBgColor,
                      textColor: themeController.isDark
                          ? DarkColors.leftOperatorColor
                          : LightColors.leftOperatorColor,
                      text: buttons[index]);
                default:
                  return CustomButton(
                      buttonTapped: () {
                        controller.onBtnTapped(buttons, index);
                      },
                      color: themeController.isDark
                          ? DarkColors.btnBgColor
                          : LightColors.btnBgColor,
                      textColor: isOperator(buttons[index])
                          ? LightColors.operatorColor
                          : themeController.isDark
                              ? Colors.white
                              : const Color.fromARGB(255, 51, 50, 64),
                      text: buttons[index]);
              }
            }),
      ),
    );
  }

  Expanded outPutSection(
      ThemeController themeController, CalculateController controller) {
    final icon = themeController.isDark
        ? const Icon(Icons.light_mode_outlined, color: Colors.white, size: 30)
        : const Icon(Icons.dark_mode_outlined,
            color: Color.fromARGB(255, 51, 50, 64), size: 30);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: themeController.isDark
                      ? DarkColors.sheetBgColor
                      : LightColors.sheetBgColor,
                  borderRadius: BorderRadius.circular(23)),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => themeController.trueOrFalse(),
                  child: icon,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  maxLines: 3,
                  controller.userInput,
                  style: TextStyle(
                      color: themeController.isDark
                          ? Colors.white
                          : const Color.fromARGB(255, 51, 50, 64),
                      fontSize: 37,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Text(
                  controller.userOutput,
                  style: TextStyle(
                      color: themeController.isDark
                          ? Colors.white
                          : const Color.fromARGB(255, 51, 50, 64),
                      fontSize: 47,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "AC") {
      return true;
    }
    return false;
  }
}
