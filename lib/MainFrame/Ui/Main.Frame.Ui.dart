import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:powerbank/Constants/Colors.dart';
import 'package:powerbank/HelperClasses/Widgets.dart';
import 'package:powerbank/HelperClasses/Notice.Get.Service.dart';
import 'package:powerbank/HelperClasses/Server.Stats.Service.dart';
import 'package:powerbank/HomeWidget/Ui/Home.Ui.dart';
import 'package:powerbank/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/OrderWidget/Ui/Order.View.dart';
import 'package:powerbank/Profile/Ui/Profile.Ui.dart';
import 'package:powerbank/generated/assets.dart';
import 'NavigationBar/Navigation.Bar.Item.dart';
import 'NavigationBar/Navigation.Bar.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    const CustomAppBar(),
                    Positioned(
                      top: 8,
                      bottom: 8,
                      right: 8,
                      child: InkWell(
                        onTap: () {
                          _noticeGetxService.showNoticeWallDialog();
                        },
                        child: Lottie.network(
                            "https://assets10.lottiefiles.com/packages/lf20_22votfwd.json",
                            fit: BoxFit.contain,
                            alignment: Alignment.center),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      bottom: 8,
                      child: GestureDetector(
                        onTap: () {
                          _serverStatsController.showServerStatsDialog();
                        },
                        child: const SizedBox(
                            width: 25, height: 25, child: AppIconWidget()),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Obx(() {
                    return IndexedStack(
                      index: _mainFrameService.currentNavIndex.value,
                      children: const [HomeView(), OrderView(), ProfileView()],
                    );
                  }),
                )
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
          icon: const Icon(Icons.home),
        ),
        TitledNavigationBarItem(
          title: Text(OrderView.viewName),
          icon: const Icon(Icons.shopping_cart),
        ),
        TitledNavigationBarItem(
          title: Text(ProfileView.viewName),
          icon: const Icon(Icons.person_outline),
        ),
      ],
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: Get.width,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color1,
            color2,
            color3.withOpacity(0.5),
            color3.withOpacity(0.5)
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          _serverStatsController.showServerStatsDialog();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              "DREAM ",
              style: TextStyle(
                  color: color4, fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Text(
              "LIGHT CITY",
              style: TextStyle(
                  color: colorWhite, fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}
