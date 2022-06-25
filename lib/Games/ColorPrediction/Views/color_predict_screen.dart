import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';

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
            const SizedBox(height: 8),
            const Text("Color Light City\n45 SEC COLOR PARITY",
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: Get.width - 10,
                  height: 45,
                  decoration: const BoxDecoration(
                    color: color4,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                CircularCountDownTimer(
                  duration: 45,
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
                  textStyle: const TextStyle(
                      fontSize: 20.0,
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
              children: const [
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
                        margin: const EdgeInsets.all(4),
                        height: 20,
                        width: Get.width - 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            const Expanded(
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
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Text(
                                    "4",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
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
              margin: const EdgeInsets.symmetric(horizontal: 6),
              height: 45,
              decoration: const BoxDecoration(
                color: color4,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10),
                  bottom: Radius.circular(50),
                ),
              ),
              child: const Text(
                "Current Period: 20221456457",
                style: TextStyle(
                    fontSize: 20, color: color1, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const ColorAndContract(),
            const Text("This gaming project is under development",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: MaterialButton(
                onPressed: () {
                  CustomerSupport.openFirestoreExternalLinks(
                      fbFieldName: FireString.donationLink);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: highlightColor2,
                child: const Text(
                  "DONATE FOR THIS PROJECT",
                  style: TextStyle(color: color1, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              height: 45,
              decoration: const BoxDecoration(
                color: color4,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                  bottom: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    FontAwesomeIcons.indianRupeeSign,
                    color: color1,
                  ),
                  AnimatedFlipCounter(
                    value: 98888888888,
                    duration: Duration(seconds: 2),
                    textStyle: TextStyle(
                        fontSize: 20,
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
        menuScreen: const ContractValueSelection(),
        mainScreen: const ColorAndNumberTiles(),
        slideWidth: Get.width - 10,
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
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var itm in ["Green", "Violet", "Red"])
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: MaterialButton(
                    onPressed: () {
                      sController.zoomDrawerController.toggle!();
                    },
                    color: color3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(itm),
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
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (var itm in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: MaterialButton(
                    onPressed: () {
                      sController.zoomDrawerController.toggle!();
                    },
                    color: color3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("$itm"),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Contract Value",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color4),
              ),
              StepperSwipe(
                initialValue: 50,
                speedTransitionLimitCount: 3, //Trigger count for fast counting
                onChanged: (int value) => print('new value $value'),
                firstIncrementDuration: const Duration(
                    milliseconds: 250), //Unit time before fast counting
                secondIncrementDuration: const Duration(
                    milliseconds: 100), //Unit time during fast counting
                direction: Axis.horizontal,
                dragButtonColor: color4,
                maxValue: 5000,
                minValue: 50, stepperValue: 50,
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Multiplier",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color4),
              ),
              StepperSwipe(
                initialValue: 1,
                speedTransitionLimitCount: 3, //Trigger count for fast counting
                onChanged: (int value) => print('new value $value'),
                firstIncrementDuration: const Duration(
                    milliseconds: 250), //Unit time before fast counting
                secondIncrementDuration: const Duration(
                    milliseconds: 100), //Unit time during fast counting
                direction: Axis.horizontal,
                dragButtonColor: color4,
                maxValue: 100,
                minValue: 1, stepperValue: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
