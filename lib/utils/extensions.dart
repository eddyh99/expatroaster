import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

extension ScreenUtils on num {
  double get w => Get.width * (this / 100);
  double get h => Get.height * (this / 100);
  double get sp => this * (Get.width / 3) / 100;
}
