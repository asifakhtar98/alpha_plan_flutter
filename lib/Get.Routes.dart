import 'package:get/get.dart';
import 'package:powerbank/App/AllActivityRecords/all_activity_screen.dart';
import 'package:powerbank/App/BuyProduct/Controllers/Commission.Controller.dart';
import 'package:powerbank/App/LoginRegister/GetXControllers/Auth.Controller.dart';
import 'package:powerbank/App/LoginRegister/Ui/Auth.Screen.dart';
import 'package:powerbank/App/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/App/MainFrame/Ui/Main.Frame.Ui.dart';
import 'package:powerbank/App/MainFrame/Ui/OrderWidget/Order.Ui.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Cashfree.Pg.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Razor.Pay.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Controllers/Recharge.Screen.Controller.dart';
import 'package:powerbank/App/RechargeScreen/Recharge.Screen.dart';
import 'package:powerbank/App/ReferIncome/GetxControllers/Refer.Controller.dart';
import 'package:powerbank/App/ReferIncome/Ui/Refer.Income.Screen.dart';
import 'package:powerbank/Games/ColorPrediction/Bindings/color_prediction_bindings.dart';
import 'package:powerbank/Games/ColorPrediction/Views/color_predict_screen.dart';
import 'package:powerbank/GetxStreams/Investment.Products.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';

import 'App/AllActivityRecords/all_activity_controller.dart';
import 'App/RechargeScreen/Controllers/upi_india_controller.dart';
import 'HelperClasses/Notice.Get.Service.dart';
import 'HelperClasses/Password.Renew.Controller.dart';
import 'HelperClasses/Server.Stats.Service.dart';
import 'HelperClasses/route_names.dart';

List<GetPage> myGetRoutes = [
  GetPage(
    name: AuthScreen.screenName,
    page: () => const AuthScreen(),
    binding: BindingsBuilder(
      () => {
        Get.lazyPut<AuthGController>(() => AuthGController(), fenix: true),
        Get.lazyPut<PasswordRenewController>(() => PasswordRenewController(),
            fenix: true),
        Get.lazyPut<ServerStatsController>(() => ServerStatsController(),
            fenix: true),
        Get.lazyPut<NoticeGetxService>(() => NoticeGetxService(), fenix: true),
      },
    ),
  ),
  GetPage(
    name: MainFrame.screenName,
    page: () => const MainFrame(),
    binding: BindingsBuilder(
      () => {
        Get.lazyPut<MainFrameGService>(() => MainFrameGService(), fenix: true),
        //Other Req Controller
        Get.lazyPut<WalletBalanceStreamController>(
            () => WalletBalanceStreamController(),
            fenix: true),
        Get.lazyPut<WalletPermissionStreamController>(
            () => WalletPermissionStreamController(),
            fenix: true),
        Get.lazyPut<InvestmentProductsStreamController>(
            () => InvestmentProductsStreamController(),
            fenix: true),
        Get.lazyPut<OrderUiController>(() => OrderUiController(), fenix: true),
      },
    ),
  ),
  GetPage(
    name: RechargeScreen.screenName,
    page: () => const RechargeScreen(),
    binding: BindingsBuilder(
      () => {
        Get.lazyPut<RechargeScreenController>(() => RechargeScreenController(),
            fenix: true),
        Get.lazyPut<CashfreePgController>(() => CashfreePgController(),
            fenix: true),
        Get.lazyPut<RazorpayController>(() => RazorpayController(),
            fenix: true),
        Get.lazyPut<UpiIndiaController>(() => UpiIndiaController(),
            fenix: true),
        Get.lazyPut<CommissionController>(() => CommissionController(),
            fenix: true),
      },
    ),
  ),
  GetPage(
    name: UserReferIncomeScreen.screenName,
    page: () => const UserReferIncomeScreen(),
    binding: BindingsBuilder(
      () => {
        Get.lazyPut<ReferIncomeController>(() => ReferIncomeController(),
            fenix: true),
        Get.lazyPut<RechargeScreenController>(() => RechargeScreenController(),
            fenix: true),
      },
    ),
  ),
  GetPage(
    name: AllActivityScreen.screenName,
    page: () => AllActivityScreen(),
    binding: BindingsBuilder(
      () => {
        Get.lazyPut<AllActScreenController>(() => AllActScreenController(),
            fenix: true),
      },
    ),
  ),
  GetPage(
    name: Routes.colorPredict,
    page: () => ColorPredictScreen(),
    binding: ColorPredictBinding(),
  ),
];
