// ignore_for_file: unnecessary_import

import 'package:async_button_builder/async_button_builder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/App/BuyProduct/Controllers/Buy.Product.Controller.dart';
import 'package:powerbank/App/BuyProduct/Controllers/Commission.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Recharge.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/Investment.Products.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/generated/assets.dart';
import 'package:selectable_container/selectable_container.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();
var _buyProductController = Get.put(BuyProductController());

class BuyProductScreen extends StatefulWidget {
  final int productIndex;

  const BuyProductScreen({Key? key, required this.productIndex})
      : super(key: key);

  @override
  State<BuyProductScreen> createState() => _BuyProductScreenState();
}

class _BuyProductScreenState extends State<BuyProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<CommissionController>().getGlobalReferCommissionData();
    _buyProductController.togglePlan(
      planID: mainInvestmentProductsList[widget.productIndex].uidProduct,
      localPlanPrice:
          mainInvestmentProductsList[widget.productIndex].productPrice,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color4,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.share,
              size: 20,
            ),
          ),
        ],
        title: const Text("Investment Checkout"),
        bottom: PreferredSize(
          preferredSize: MediaQuery.of(context).size * 0.35,
          child: Container(
            alignment: Alignment.center,
            height: Get.height * 0.35,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color4, color4, color2, color1],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              mainInvestmentProductsList[widget.productIndex]
                                  .pImageUrl),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: color3.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                                width: 18, height: 18, child: AppIconWidget()),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              mainInvestmentProductsList[widget.productIndex]
                                  .productName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: colorWhite,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -15,
                      right: -10,
                      child: Lottie.asset("assets/robot-manager.json",
                          width: 100, height: 100),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          child: Obx(() {
            bool isDiscount = (_buyProductController.planServerPrice.value <
                        mainInvestmentProductsList[widget.productIndex]
                            .productPrice &&
                    _buyProductController.isNotHibernated.value)
                ? true
                : false;
            return Stack(
              children: [
                Positioned(
                  right: 23,
                  top: 70,
                  child: Icon(
                    FontAwesomeIcons.server,
                    size: 60,
                    color: color2.withOpacity(0.8),
                  ),
                ),
                Positioned(
                  right: 77,
                  top: 60,
                  child: Icon(
                    FontAwesomeIcons.indianRupeeSign,
                    size: 60,
                    color: color2.withOpacity(0.8),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            height: 50,
                            width: 5,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              gradient: LinearGradient(
                                colors: [color3, color4],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            "Investment\nStadium Details",
                            style: TextStyle(fontSize: 24, color: colorWhite),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.handHoldingUsd,
                                  size: 16,
                                  color: color4,
                                ),
                                Text(
                                  "  Price Of Share   ⇋   Rs. ${mainInvestmentProductsList[widget.productIndex].productPrice}",
                                  style: const TextStyle(
                                      color: colorWhite, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.chartLine,
                                  size: 16,
                                  color: color4,
                                ),
                                Text(
                                  "  Daily Income ⇋   Rs. ${mainInvestmentProductsList[widget.productIndex].dailyIncome}",
                                  style: const TextStyle(
                                      color: colorWhite, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.piggyBank,
                                  size: 16,
                                  color: color4,
                                ),
                                Text(
                                  "  Total Income ⇋   Rs. ${mainInvestmentProductsList[widget.productIndex].totalIncome}",
                                  style: const TextStyle(
                                      color: colorWhite, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.stopwatch,
                                  size: 16,
                                  color: color4,
                                ),
                                Text(
                                  "  Serving Time ⇋   ${mainInvestmentProductsList[widget.productIndex].maturityTime} Days",
                                  style: const TextStyle(
                                      color: colorWhite, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Icon(
                                  FontAwesomeIcons.bolt,
                                  size: 16,
                                  color: color4,
                                ),
                                Text(
                                  "  Availability ⇋  Unlimited",
                                  style: TextStyle(
                                      color: colorWhite, fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              mainInvestmentProductsList[widget.productIndex]
                                  .longDescription,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                color: colorWhite,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                "◆ You receive it's daily income at 12:02 AM after next day of investment. If you purchase the product after 12:00 AM then your fist daily income will arrive on the next day",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: color4),
                              ),
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (isDiscount)
                  DelayedDisplay(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Lottie.asset(Assets.assetsConfettiLottie,
                              width: 200, height: 200),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                if (isDiscount)
                  DelayedDisplay(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: color4,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15))),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(Assets.assetsRupeeCoinLeftRight,
                                    width: 25, height: 25),
                                Text(
                                  "${mainInvestmentProductsList[widget.productIndex].productPrice - _buyProductController.planServerPrice.value} Discount Today  ",
                                  style: const TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 52,
                          )
                        ],
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minWidth: Get.width - 35,
                      color: (_buyProductController.isNotHibernated.value)
                          ? color4
                          : Colors.blueGrey,
                      onPressed: () async {
                        if (_buyProductController.isNotHibernated.value) {
                          SmartDialog.show(
                            alignmentTemp: Alignment.bottomCenter,
                            clickBgDismissTemp: true,
                            widget: Container(
                              width: Get.width - 8,
                              height: 300,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: color2,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    "Select Checkout Wallet",
                                    style: TextStyle(
                                        color: color4,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Obx(() {
                                          return SelectableContainer(
                                            marginColor: color2,
                                            unselectedOpacity: 0.8,
                                            elevation: 0,
                                            borderRadius: 10,
                                            unselectedBorderColor:
                                                color4.withOpacity(0.4),
                                            unselectedBackgroundColor:
                                                color4.withOpacity(0.3),
                                            iconSize: 12,
                                            selected: !_buyProductController
                                                .isDepositWalletSelected.value,
                                            padding: 12,
                                            iconColor: Colors.black,
                                            selectedBorderColor: color4,
                                            selectedBackgroundColor:
                                                color4.withOpacity(0.3),
                                            onValueChanged: (v) {
                                              _buyProductController
                                                  .toggleWallet();
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  "Balance\n₹${_walletBalanceStreamer.withdrawalCoin.value}",
                                                  style: const TextStyle(
                                                      color: colorWhite,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Text(
                                                  "Income Wallet",
                                                  style:
                                                      TextStyle(color: color4),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                      Expanded(
                                        child: Obx(() {
                                          return SelectableContainer(
                                            marginColor: color2,
                                            unselectedOpacity: .8,
                                            elevation: 0,
                                            borderRadius: 10,
                                            unselectedBorderColor:
                                                color4.withOpacity(0.4),
                                            unselectedBackgroundColor:
                                                color4.withOpacity(0.3),
                                            iconSize: 12,
                                            selected: _buyProductController
                                                .isDepositWalletSelected.value,
                                            padding: 12,
                                            iconColor: Colors.black,
                                            selectedBorderColor: color4,
                                            selectedBackgroundColor:
                                                color4.withOpacity(0.3),
                                            onValueChanged: (v) {
                                              _buyProductController
                                                  .toggleWallet();
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  "Balance\n₹${_walletBalanceStreamer.depositCoin.value}",
                                                  style: const TextStyle(
                                                      color: colorWhite,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                const Text(
                                                  "Deposit Wallet",
                                                  style:
                                                      TextStyle(color: color4),
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  Obx(() {
                                    if (_buyProductController
                                        .isDepositWalletSelected.isTrue) {
                                      return const Text(
                                          "Have Investment commissions for 3 upper level members",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: color4, fontSize: 12));
                                    } else {
                                      return const SizedBox();
                                    }
                                  }),
                                  const Spacer(),
                                  Text(
                                      "Final checkout value = ₹${_buyProductController.planServerPrice.value}",
                                      style: const TextStyle(color: color4)),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        onPressed: () {
                                          SmartDialog.dismiss();
                                          Get.toNamed(
                                              RechargeScreen.screenName);
                                        },
                                        child: const Text(
                                          "Recharge",
                                          style: TextStyle(color: color4),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: AsyncButtonBuilder(
                                          loadingWidget:
                                              const Text('Verifying...'),
                                          errorWidget:
                                              const Text("Try Another Option"),
                                          onPressed: () async {
                                            int currentCoin =
                                                (_buyProductController
                                                        .isDepositWalletSelected
                                                        .value)
                                                    ? _walletBalanceStreamer
                                                        .depositCoin.value
                                                    : _walletBalanceStreamer
                                                        .withdrawalCoin.value;
                                            if (currentCoin >=
                                                _buyProductController
                                                    .planServerPrice.value) {
                                              bool isSuccess = await _buyProductController
                                                  .proceedToPlanBuy(
                                                      isDepositWalletSet:
                                                          _buyProductController
                                                              .isDepositWalletSelected
                                                              .value,
                                                      planUid:
                                                          mainInvestmentProductsList[
                                                                  widget
                                                                      .productIndex]
                                                              .uidProduct);
                                              if (isSuccess) {
                                                await Future.delayed(
                                                    const Duration(seconds: 2));

                                                _buyProductController
                                                    .showAfterPurchaseDialog(
                                                        widget.productIndex);
                                              } else {
                                                throw "notSuccess";
                                              }
                                            } else {
                                              _buyProductController
                                                  .toggleWallet();
                                              throw "noBalance";
                                            }
                                          },
                                          builder: (context, child, callback,
                                              buttonState) {
                                            final buttonColor =
                                                buttonState.when(
                                              idle: () => color4,
                                              loading: () => color3,
                                              success: () => Colors.green,
                                              error: () => Colors.blueGrey,
                                            );

                                            return OutlinedButton(
                                              onPressed: callback,
                                              style: OutlinedButton.styleFrom(
                                                primary: Colors.black,
                                                backgroundColor: buttonColor,
                                              ),
                                              child: child,
                                            );
                                          },
                                          child: const Text('Confirm Checkout'),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          SmartDialog.showToast(
                              "${mainInvestmentProductsList[widget.productIndex].productName} servers in hibernation");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FontAwesomeIcons.piggyBank,
                              color: colorWhite.withOpacity(0.7),
                            ),
                            Text(
                              (_buyProductController.isNotHibernated.value)
                                  ? "Buy Shares Of These Stadium"
                                  : "Shares Currently Hibernated",
                              style: const TextStyle(fontSize: 16),
                            ),
                            Icon(
                              FontAwesomeIcons.piggyBank,
                              color: colorWhite.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
