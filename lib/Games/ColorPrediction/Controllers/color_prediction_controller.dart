import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';

class ColorPredictController extends GetxController {
  final countDownController = CountDownController();
  final zoomDrawerController = ZoomDrawerController();
  final contractAmountController = StreamController<int>();
  final contractAmountMultiplierController = StreamController<int>();
}
