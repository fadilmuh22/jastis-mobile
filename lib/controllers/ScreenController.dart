part of 'controllers.dart';

class ScreenController extends GetxController {
  static ScreenController to = Get.find();

  var mainTabIndex = 0.obs;
  var listPageTabIndex = 0.obs;

  void onTabTapped(int index) {
    mainTabIndex.value = index;
  }
}
