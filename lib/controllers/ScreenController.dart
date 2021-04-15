part of 'controllers.dart';

class ScreenController extends GetxController {
  static ScreenController to = Get.find();

  var tabIndex = 0.obs;

  void onTabTapped(int index) {
    tabIndex.value = index;
    update();
  }
}
