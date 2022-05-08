import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:powerbank/App/AboutApp/Ui/About.App.Screen.dart';
import 'package:powerbank/App/BuyProduct/Ui/Buy.Product.Screen.dart';
import 'package:powerbank/App/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/App/ReferIncome/Ui/Refer.Income.Screen.dart';
import 'package:powerbank/App/ReferralProgram/Referral.Program.Screen.dart';
import 'package:powerbank/App/Withdraw/Ui/Withdraw.Screen.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/Constants/Investment.Products.dart';
import 'package:powerbank/Constants/strings.dart';
import 'package:powerbank/GetxStreams/Investment.Products.Stream.dart';
import 'package:powerbank/GetxStreams/Server.Permit.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';

var _walletBalanceStreamer = Get.find<WalletBalanceStreamController>();
var _walletPermissionController = Get.find<WalletPermissionStreamController>();
var _serverPermitStream = Get.find<ServerPermitStreamController>();
var _investmentProductsStreamController =
    Get.find<InvestmentProductsStreamController>();

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static String viewName = "Home";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Obx(() {
              return Visibility(
                visible: (_serverPermitStream.isUpdateAvailable.value)
                    ? true
                    : false,
                child: DelayedDisplay(
                  fadingDuration: const Duration(milliseconds: 300),
                  child: Column(
                    children: [
                      ExpansionTileCard(
                        baseColor: color3,
                        expandedColor: color3,
                        leading: const Icon(
                          FontAwesomeIcons.googlePlay,
                          color: colorWhite,
                        ),
                        title: const Text(
                          "New version available with new features",
                          style: TextStyle(color: Colors.white),
                        ),
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            "Whats New?",
                            style: TextStyle(color: colorWhite),
                          ),
                          const Text(
                            "1) This update fix some minor bugs",
                            style: TextStyle(color: colorWhite),
                          ),
                          const Text(
                            "2) App size is optimized",
                            style: TextStyle(color: colorWhite),
                          ),
                          const Text(
                            "3) App security is enhanced then before",
                            style: TextStyle(color: colorWhite),
                          ),
                          const Text(
                            "3) Transactions are faster now",
                            style: TextStyle(color: colorWhite),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          TextButton(
                            onPressed: () async {
                              var _url = _serverPermitStream.appLink;
                              await canLaunch(_url)
                                  ? await launch(_url)
                                  : throw 'Could not launch $_url';
                            },
                            child: const Text(
                              "             Update App Now             ",
                              style: TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const DelayedDisplay(
              fadingDuration: Duration(milliseconds: 400),
              child: MySlidingImages(),
            ),
            const SizedBox(
              height: 6,
            ),
            const DelayedDisplay(
              fadingDuration: Duration(milliseconds: 500),
              child: RealTimeAllUserActivity(),
            ),
            const SizedBox(
              height: 8,
            ),
            const DelayedDisplay(
              fadingDuration: Duration(milliseconds: 600),
              child: ThreeCards(),
            ),
            const SizedBox(
              height: 12,
            ),
            DelayedDisplay(
              fadingDuration: const Duration(milliseconds: 900),
              child: Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    height: 30,
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
                    "Featured Stadiums",
                    style: TextStyle(fontSize: 24, color: colorWhite),
                  ),
                ],
              ),
            ),
            const DelayedDisplay(
              fadingDuration: Duration(milliseconds: 700),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select a infrastructure from below to start your journey of investment, Monitor your investment on a regular basis to understand in depth perfomance.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: colorWhite),
                ),
              ),
            ),
            Obx(() {
              if (_investmentProductsStreamController
                  .investmentPlansIdList.isNotEmpty) {
                return const DelayedDisplay(
                    fadingDuration: Duration(milliseconds: 800),
                    child: ProductHomeCatalogue());
              } else {
                return Container(
                  alignment: Alignment.center,
                  height: Get.height / 1.5,
                  child: const CircularProgressIndicator(
                    color: color3,
                  ),
                );
              }
            }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 23, height: 23, child: AppIconWidget()),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  appName.toUpperCase(),
                  style: const TextStyle(
                      color: colorWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductHomeCatalogue extends StatelessWidget {
  const ProductHomeCatalogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
      children: [
        for (InvestmentProduct oProduct in mainInvestmentProductsList)
          Obx(() {
            int serverIndexOfPlan = _investmentProductsStreamController
                .investmentPlansIdList
                .indexWhere((element) => element == oProduct.uidProduct);
            int _serverPrice = _investmentProductsStreamController
                .investmentPlansPriceList[serverIndexOfPlan];
            int totalInvestments = _investmentProductsStreamController
                .noOfInvestmentsList[serverIndexOfPlan];
            bool isNotHibernated =
                (_serverPrice >= oProduct.productPrice / 2) ? true : false;
            bool isDiscounted = _serverPrice != oProduct.productPrice;
            return ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: const Radius.circular(60),
                topLeft: isDiscounted
                    ? const Radius.circular(18)
                    : const Radius.circular(60),
                bottomRight: const Radius.circular(18),
                bottomLeft: const Radius.circular(18),
              ),
              child: Obx(
                () {
                  if (_investmentProductsStreamController
                      .noOfInvestmentsList.isEmpty) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.46,
                      height: 170,
                      child: const Center(
                        child: CircularProgressIndicator(color: color3),
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.46,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  color2.withOpacity(0.7),
                                  color3.withOpacity(0.5),
                                ]),
                          ),
                          child: Column(
                            children: [
                              Text(
                                oProduct.productName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16, color: colorWhite),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                  if (isNotHibernated) {
                                    Get.to(
                                      () => BuyProductScreen(
                                        productIndex: mainInvestmentProductsList
                                            .indexOf(oProduct),
                                      ),
                                    );
                                  } else {
                                    SmartDialog.showToast(
                                        "${oProduct.productName} Server in hibernation");
                                  }
                                },
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                      color: color3,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              oProduct.pImageUrl))),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Price:",
                                    style:
                                        TextStyle(color: color4, fontSize: 11),
                                  ),
                                  Text(
                                    "₹${oProduct.productPrice.toString()}",
                                    style: const TextStyle(
                                        color: Colors.amberAccent,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Daily Income:",
                                    style:
                                        TextStyle(color: color4, fontSize: 11),
                                  ),
                                  Text(
                                    "₹${oProduct.dailyIncome.toString()}",
                                    style: const TextStyle(
                                        color: Colors.amberAccent,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Full Income:",
                                    style:
                                        TextStyle(color: color4, fontSize: 11),
                                  ),
                                  Text(
                                    "₹${oProduct.totalIncome.toString()}",
                                    style: const TextStyle(
                                        color: Colors.amberAccent,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Serving Time:",
                                    style:
                                        TextStyle(color: color4, fontSize: 11),
                                  ),
                                  Text(
                                    "${oProduct.maturityTime.toString()} Dy",
                                    style: const TextStyle(
                                        color: Colors.amberAccent,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minWidth: 130,
                                onPressed: () {
                                  if (isNotHibernated) {
                                    Get.to(
                                      () => BuyProductScreen(
                                        productIndex: mainInvestmentProductsList
                                            .indexOf(oProduct),
                                      ),
                                    );
                                  } else {
                                    SmartDialog.showToast(
                                        "${oProduct.productName} Server in hibernation");
                                  }
                                },
                                color: (isNotHibernated)
                                    ? color4
                                    : Colors.blueGrey,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text((isNotHibernated)
                                        ? "₹${oProduct.productPrice}"
                                        : "Hibernated"),
                                  ],
                                ),
                              ),
                              Text(
                                "Total Investments : ${totalInvestments + oProduct.fakeNumber}",
                                style: TextStyle(
                                    color: colorWhite.withOpacity(0.6),
                                    fontSize: 8),
                              )
                            ],
                          ),
                        ),
                        if (_serverPrice != oProduct.productPrice &&
                            isNotHibernated)
                          Positioned(
                            top: -10,
                            left: -35,
                            child: Transform.rotate(
                              angle: -45 * pi / 180,
                              child: Container(
                                width: 120,
                                height: 45,
                                color: color4.withOpacity(0.4),
                              ),
                            ),
                          ),
                        if (_serverPrice != oProduct.productPrice &&
                            isNotHibernated)
                          Positioned(
                            top: 20,
                            left: 2,
                            child: Transform.rotate(
                              angle: -45 * pi / 180,
                              child: AutoSizeText(
                                "${oProduct.productPrice - _serverPrice} Less",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: colorWhite,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                                minFontSize: 10,
                              ),
                            ),
                          ),
                        if (_serverPrice != oProduct.productPrice &&
                            isNotHibernated)
                          const Positioned(
                            top: 8,
                            left: 8,
                            child: Icon(
                              FontAwesomeIcons.fireAlt,
                              size: 14,
                            ),
                          ),
                      ],
                    );
                  }
                },
              ),
            );
          }),
      ],
    );
  }
}

class ThreeCards extends StatelessWidget {
  const ThreeCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                Get.to(() => const WithdrawScreen());
              },
              child: Container(
                height: 165,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [color3, color4],
                  ),
                  // borderRadius: BorderRadius.all(
                  //   Radius.circular(10),
                  // ),
                ),
                child: Stack(
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const AutoSizeText(
                            "My Balance",
                            style: TextStyle(
                                color: colorWhite,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            minFontSize: 10,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Obx(() {
                            return AnimatedFlipCounter(
                              value:
                                  _walletBalanceStreamer.withdrawalCoin.value +
                                      _walletBalanceStreamer.depositCoin.value,
                              prefix: '₹ ',
                              duration: const Duration(seconds: 2),
                              textStyle: const TextStyle(
                                  color: colorWhite,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold),
                            );
                          }),
                          const SizedBox(
                            height: 8,
                          ),
                          Obx(() {
                            return AutoSizeText(
                              "Minimum Withdrawal ${_walletPermissionController.minimumWithdrawAmount.value}",
                              style: const TextStyle(
                                color: colorWhite,
                                fontSize: 12,
                              ),
                              minFontSize: 10,
                              maxLines: 2,
                            );
                          })
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0.9, 1.2),
                      child: CustomPaint(
                        size: Size(100, 50.toDouble()),
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: MountainCPaint(
                          color3.withOpacity(0.4),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(1.6, 1),
                      child: CustomPaint(
                        size: Size(100, 50.toDouble()),
                        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                        painter: MountainCPaint(color4),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.wallet,
                          color: colorWhite.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Expanded(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const ReferralProgramScreen());
                  },
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color3, color4],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(
                                height: 8,
                              ),
                              AutoSizeText(
                                "Get Refer Link",
                                style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                minFontSize: 14,
                                maxLines: 1,
                              ),
                              AutoSizeText(
                                "Invite & Earn",
                                style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 12,
                                ),
                                minFontSize: 10,
                                maxLines: 1,
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.9, 8),
                          child: ClipOval(
                            child: Container(
                              color: color3.withOpacity(0.4),
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(1.3, 6),
                          child: ClipOval(
                            child: Container(
                              color: color4,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                FontAwesomeIcons.sitemap,
                                color: colorWhite.withOpacity(0.6),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const AboutAppScreen());
                  },
                  child: Container(
                    height: 80,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color3, color4],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "About Us",
                                style: TextStyle(
                                    color: colorWhite,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0.9, 8),
                          child: ClipOval(
                            child: Container(
                              color: color3.withOpacity(0.4),
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(1.3, 6),
                          child: ClipOval(
                            child: Container(
                              color: color4,
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              FontAwesomeIcons.fistRaised,
                              color: colorWhite.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RealTimeAllUserActivity extends StatelessWidget {
  const RealTimeAllUserActivity({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          FontAwesomeIcons.bolt,
          size: 20,
          color: color4,
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Obx(() {
            return Get.find<MainFrameGService>().alertBar.value;
          }),
        ),
      ],
    );
  }
}

class MySlidingImages extends StatelessWidget {
  const MySlidingImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
      ),
      items: corouselItemList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => i.onClick(),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(18),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            color4
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(i.pImageUrl)),
                        color: color2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          i.actionName,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorWhite),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

////////////////////////////
class MountainCPaint extends CustomPainter {
  MountainCPaint(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.lineTo(size.width * 0.5000000, 0);
    path0.lineTo(size.width, size.height);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CarouselModel {
  final String pImageUrl;
  final Function onClick;
  final String actionName;

  CarouselModel(
      {required this.actionName,
      required this.pImageUrl,
      required this.onClick});
}

List<CarouselModel> corouselItemList = [
  CarouselModel(
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1652020809/DreamLightCity/AppAssets/GOLDEN-SIGNUP-BANNER_jvt5wc.jpg",
      onClick: () {
        SmartDialog.showToast("Your already signup");
      },
      actionName: ''),
  CarouselModel(
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1652026197/DreamLightCity/AppAssets/GOLDEN-COMMISSION-BANNER_hds7sh.jpg",
      onClick: () {
        Get.toNamed(UserReferIncomeScreen.screenName);
      },
      actionName: ''),
  CarouselModel(
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650567875/DreamLightCity/PlanImages/106698727-1599822851881-SoFi_Stadium_est_2020_ynf0a1.jpg",
      onClick: () {
        Get.to(() => const BuyProductScreen(productIndex: 5));
      },
      actionName: 'Stadium of Rs.1000/Day'),
  CarouselModel(
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650794761/DreamLightCity/AppAssets/telegram3627_qniduu.png",
      onClick: () {
        CustomerSupport.openTelegramChannel();
      },
      actionName: 'Join Group'),
  CarouselModel(
      pImageUrl:
          "https://res.cloudinary.com/promisedpayment/image/upload/v1650793538/DreamLightCity/AppAssets/official-woman12414_v9kwqv.jpg",
      onClick: () {
        CustomerSupport.whatsappSupportAdmin1();
      },
      actionName: 'Contact Now'),
];
