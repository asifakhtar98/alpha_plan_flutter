import 'package:get/get.dart';

import '../Controllers/color_prediction_controller.dart';

class ColorPredictBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColorPredictController());
  }
}
