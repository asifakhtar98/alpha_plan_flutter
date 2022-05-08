import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:powerbank/App/RechargeScreen/Recharge.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/Investment.Products.dart';
import 'package:powerbank/Constants/firestore_strings.dart';
import 'package:powerbank/GetxStreams/Investment.Products.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

import '../Order.Ui.Controller.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();
var _orderUiController = Get.find<OrderUiController>();
var _investmentProductsStreamController =
    Get.find<InvestmentProductsStreamController>();

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);
  static String viewName = "Orders";

  @override
  Widget build(BuildContext context) {
    _orderUiController.userInvestedPlans;
    return Column(
      children: [
        const SizedBox(height: 50),
        Container(
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color2, color3],
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Investment\nReturn",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color4.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return AnimatedFlipCounter(
                        value: _walletBalanceStreamer.investReturn.value,
                        prefix: '₹ ',
                        duration: const Duration(seconds: 2),
                        textStyle: const TextStyle(
                            color: colorWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                width: 2,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [color3, color4])),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Upcoming\nIncome",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color4.withOpacity(0.7)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return AnimatedFlipCounter(
                        value: _walletBalanceStreamer.upcomingIncome.value,
                        prefix: '₹ ',
                        duration: const Duration(seconds: 2),
                        textStyle: const TextStyle(
                            color: colorWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      );
                    })
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 40),
                width: 2,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [color3, color4])),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(RechargeScreen.screenName);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Deposit\nBalance",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: color4.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return AnimatedFlipCounter(
                          value: _walletBalanceStreamer.depositCoin.value,
                          prefix: '₹ ',
                          duration: const Duration(seconds: 2),
                          textStyle: const TextStyle(
                              color: colorWhite,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Obx(() {
            //This check is required else it will throw index -1 error
            if (_orderUiController.userInvestedPlans.isEmpty ||
                _investmentProductsStreamController
                    .noOfInvestmentsList.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Divider(
                      color: color3,
                      indent: 100,
                      endIndent: 100,
                    ),
                    Text(
                      "No investment on any infrastructure yet",
                      style: TextStyle(color: color4.withOpacity(0.6)),
                    ),
                    const Divider(
                      color: color3,
                      indent: 30,
                      endIndent: 30,
                    ),
                    const Text(
                      "Your can only earn by investing on our featured stadiums stated in app home page",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: color3),
                    ),
                    const Divider(
                      color: color3,
                      indent: 100,
                      endIndent: 100,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: _orderUiController.userInvestedPlans.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            foregroundDecoration: RotatedCornerDecoration(
                              textSpan: TextSpan(
                                text:
                                    (_orderUiController.userInvestedPlans[index]
                                            [FireString.isCompleted])
                                        ? "Expired"
                                        : "Running",
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              color:
                                  (_orderUiController.userInvestedPlans[index]
                                          [FireString.isCompleted])
                                      ? Colors.grey
                                      : color4,
                              geometry: const BadgeGeometry(
                                  width: 50,
                                  height: 50,
                                  cornerRadius: 0,
                                  alignment: BadgeAlignment.topRight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 1,
                                  width: Get.width,
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [color1, color4])),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "⬤  Start Date ► ${DateFormat.yMMMEd().format(((_orderUiController.userInvestedPlans[index][FireString.planCapturedDate].toDate()).add(const Duration(days: 1))))}",
                                  style: const TextStyle(color: color4),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: color4.withOpacity(0.4),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Ord Id: ${_orderUiController.userInvestedPlans[index][FireString.docID].split("+").removeAt(2).replaceAll("[", "").replaceAll("]", "")} ",
                                          style: const TextStyle(color: color4),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                  text:
                                                      "${_orderUiController.userInvestedPlans[index][FireString.docID]}"),
                                            ).then(
                                              (value) => SmartDialog.showToast(
                                                  "Order Id Copied"),
                                            );
                                          },
                                          child: const Icon(
                                            FontAwesomeIcons.copy,
                                            size: 18,
                                            color: color4,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          color3,
                                          color2,
                                        ]),
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              child: CachedNetworkImage(
                                                  width: Get.width * 0.36,
                                                  imageUrl: mainInvestmentProductsList[
                                                          mainInvestmentProductsList
                                                              .indexWhere((element) =>
                                                                  element
                                                                      .uidProduct ==
                                                                  _orderUiController
                                                                              .userInvestedPlans[
                                                                          index]
                                                                      [
                                                                      FireString
                                                                          .planUid])]
                                                      .pImageUrl),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                const SizedBox(height: 6),
                                                Text(
                                                  mainInvestmentProductsList[mainInvestmentProductsList
                                                          .indexWhere((element) =>
                                                              element
                                                                  .uidProduct ==
                                                              _orderUiController
                                                                          .userInvestedPlans[
                                                                      index][
                                                                  FireString
                                                                      .planUid])]
                                                      .productName,
                                                  style: const TextStyle(
                                                      color: colorWhite,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  "Price: ${_orderUiController.userInvestedPlans[index][FireString.planCapturedAt]}",
                                                  style: const TextStyle(
                                                      color: Colors.amber),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  "Daily Income: ₹${mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == _orderUiController.userInvestedPlans[index][FireString.planUid])].dailyIncome}",
                                                  style: const TextStyle(
                                                      color: Colors.amber),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  "Total Income: ₹${mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == _orderUiController.userInvestedPlans[index][FireString.planUid])].totalIncome}",
                                                  style: const TextStyle(
                                                      color: Colors.amber),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              "Served Time: ${_orderUiController.userInvestedPlans[index][FireString.servedDays]}/20",
                                              style: const TextStyle(
                                                  color: Colors.amber),
                                            ),
                                            Text(
                                              "Already Returned: ₹${_orderUiController.userInvestedPlans[index][FireString.returnedAmount]}",
                                              style: const TextStyle(
                                                  color: Colors.amber),
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          (_orderUiController
                                                      .userInvestedPlans[index]
                                                  [FireString.isCompleted])
                                              ? "Server need reinvestment to start"
                                              : "Running with other ${_investmentProductsStreamController.noOfInvestmentsList[_investmentProductsStreamController.investmentPlansIdList.indexWhere((element) => element == _orderUiController.userInvestedPlans[index][FireString.planUid])] + mainInvestmentProductsList[mainInvestmentProductsList.indexWhere((element) => element.uidProduct == _orderUiController.userInvestedPlans[index][FireString.planUid])].fakeNumber} instances",
                                          style: TextStyle(
                                              fontSize: 9,
                                              color:
                                                  colorWhite.withOpacity(0.3)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Positioned(
                            bottom: 14,
                            right: 14,
                            child: Opacity(
                              opacity: 0.1,
                              child: SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: AppIconWidget()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
        )
      ],
    );
  }
}

const String cloudnaryTag =
    "https://res.cloudinary.com/asifakhtarcloudinary/image/upload/v1636887259/PowerBankImages/Places";
