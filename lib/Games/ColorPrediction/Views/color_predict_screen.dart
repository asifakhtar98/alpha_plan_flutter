import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:powerbank/Constants/Colors.dart';

import '../Controllers/color_prediction_controller.dart';

final sController = Get.find<ColorPredictController>();

class ColorPredictScreen extends StatefulWidget {
  const ColorPredictScreen({Key? key}) : super(key: key);

  @override
  State<ColorPredictScreen> createState() => _ColorPredictScreenState();
}

class _ColorPredictScreenState extends State<ColorPredictScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8),
            Text("Color Light City\nBy Dream Light City",
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: Get.width - 10,
                  height: 45,
                  decoration: BoxDecoration(
                    color: color4,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                CircularCountDownTimer(
                  duration: 10,
                  initialDuration: 0,
                  controller: sController.countDownController,
                  width: 45,
                  height: 45,
                  ringColor: Colors.grey[300]!,
                  ringGradient: null,
                  fillColor: color2,
                  fillGradient: null,
                  backgroundColor: color3,
                  backgroundGradient: null,
                  strokeWidth: 10,
                  strokeCap: StrokeCap.round,
                  textStyle: TextStyle(
                      fontSize: 33.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: true,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: true,
                  onStart: () {
                    debugPrint('Countdown Started');
                  },
                  onComplete: () {
                    sController.countDownController.start();
                    debugPrint('Countdown Ended');
                  },
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Periods",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Prices",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    "Outcomes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    for (int i = 0; i < 30; i++)
                      Container(
                        margin: EdgeInsets.all(4),
                        height: 20,
                        width: Get.width - 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "547",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "4",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 6),
              height: 45,
              decoration: BoxDecoration(
                color: color4,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                  bottom: Radius.circular(50),
                ),
              ),
              child: Text(
                "Current Period: 20221456457",
                style: TextStyle(
                    fontSize: 22, color: color1, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            ColorAndContract(),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              decoration: BoxDecoration(
                color: color4,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                  bottom: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.indianRupeeSign,
                    color: color1,
                  ),
                  AnimatedFlipCounter(
                    value: 98888888888,
                    duration: const Duration(seconds: 2),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        color: color1,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorAndContract extends StatelessWidget {
  const ColorAndContract({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.2,
      child: ZoomDrawer(
        controller: sController.zoomDrawerController,
        style: DrawerStyle.defaultStyle,
        menuScreen: ContractValueSelection(),
        mainScreen: ColorAndNumberTiles(),
        slideWidth: Get.width,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}

class ColorAndNumberTiles extends StatelessWidget {
  const ColorAndNumberTiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (var itm in ["Green", "Violet", "Orange"])
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: MaterialButton(
                    onPressed: () {
                      sController.zoomDrawerController.toggle!();
                    },
                    child: Text("$itm"),
                    color: color3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.count(
            crossAxisCount: 5,
            childAspectRatio: 1.8,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              for (var itm in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: MaterialButton(
                    onPressed: () {
                      sController.zoomDrawerController.toggle!();
                    },
                    child: Text("$itm"),
                    color: color3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContractValueSelection extends StatelessWidget {
  const ContractValueSelection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: FortuneBar(
              items: [
                FortuneItem(child: Text('Han Solo')),
                FortuneItem(child: Text('Yoda')),
                FortuneItem(child: Text('Obi-Wan Kenobi')),
              ],
              selected: sController.contractAmountController.stream,
            ),
          ),
          Expanded(
            child: FortuneBar(
              items: [
                FortuneItem(child: Text('Han Solo')),
                FortuneItem(child: Text('Yoda')),
                FortuneItem(child: Text('Obi-Wan Kenobi')),
              ],
              selected: sController.contractAmountMultiplierController.stream,
            ),
          ),
        ],
      ),
    );
  }
}
