import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/App/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/App/MainFrame/Ui/HomeWidget/Ui/Home.Ui.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/HelperClasses/Notice.Get.Service.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HelperClasses/SpamZone.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/generated/assets.dart';

import 'NavigationBar/Navigation.Bar.Item.dart';
import 'NavigationBar/Navigation.Bar.dart';
import 'OrderWidget/Ui/Order.View.dart';
import 'Profile/Ui/Profile.Ui.dart';

////////////////////////////////////////////

var _mainFrameService = Get.find<MainFrameGService>();
var _noticeGetxService = Get.find<NoticeGetxService>();
var _serverStatsController = Get.find<ServerStatsController>();

//////////////////////////////////////
class MainFrame extends StatefulWidget {
  static const screenName = "/MAINFRAME_SCREEN";

  const MainFrame({Key? key}) : super(key: key);

  @override
  State<MainFrame> createState() => _MainFrameState();
}

class _MainFrameState extends State<MainFrame> {
  @override
  Widget build(BuildContext context) {
    return DoubleBack(
      background: color3,
      child: Scaffold(
        extendBody: true,
        backgroundColor: color1,
        body: SafeArea(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return IndexedStack(
                          index: _mainFrameService.currentNavIndex.value,
                          children: const [
                            HomeView(),
                            OrderView(),
                            ProfileView()
                          ],
                        );
                      }),
                    )
                  ],
                ),
                const CustomAppBar(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MyButtomNavigationBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: color4,
          elevation: 0,
          onPressed: () {
            CustomerSupport.whatsappSupportAdmin1();
          },
          child: Lottie.asset(Assets.assetsSmsBubble, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 65,
          child: ClipPath(
            clipper: const AppBarClipper(),
            child: Container(
              alignment: Alignment.center,
              width: Get.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color1, color2, color3, color3],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  _serverStatsController.showServerStatsDialog();
                },
                onLongPress: () {
                  if (kDebugMode) SpamZone.sendRndmMsgToChannel();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "DREAM ",
                          style: TextStyle(
                              color: color4,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "LIGHT CITY",
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 22,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 8,
          bottom: 12,
          child: InkWell(
            onTap: () {
              _noticeGetxService.showNoticeWallDialog();
            },
            child: Lottie.network(
                "https://assets10.lottiefiles.com/packages/lf20_22votfwd.json",
                fit: BoxFit.contain,
                width: 45,
                height: 45,
                alignment: Alignment.center),
          ),
        ),
        Positioned(
          top: 4,
          left: 8,
          bottom: 12,
          child: GestureDetector(
            onTap: () {
              _serverStatsController.showServerStatsDialog();
            },
            child:
                const SizedBox(width: 30, height: 30, child: AppIconWidget()),
          ),
        ),
      ],
    );
  }
}

class MyButtomNavigationBar extends StatelessWidget {
  const MyButtomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledBottomNavigationBar(
      inactiveStripColor: Colors.transparent,
      activeColor: color4,
      currentIndex: _mainFrameService.currentNavIndex.value,
      // Use this to update the Bar giving a position
      onTap: (index) {
        _mainFrameService.currentNavIndex.value = index;
      },
      items: [
        TitledNavigationBarItem(
          title: Text(HomeView.viewName),
          icon: const Icon(FontAwesomeIcons.hotel),
        ),
        TitledNavigationBarItem(
          title: Text(OrderView.viewName),
          icon: const Icon(FontAwesomeIcons.bagShopping),
        ),
        TitledNavigationBarItem(
          title: Text(ProfileView.viewName),
          icon: const Icon(FontAwesomeIcons.userShield),
        ),
      ],
    );
  }
}

class AppBarClipper extends CustomClipper<Path> {
  const AppBarClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 15);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 15);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
