import 'package:get/get.dart';
import 'package:powerbank/GetxStreams/Investment.Products.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Permission.Stream.dart';
import 'package:powerbank/GetxStreams/Wallet.Value.Stream.dart';
import 'package:powerbank/LoginRegister/GetXControllers/Auth.Controller.dart';
import 'package:powerbank/LoginRegister/Ui/Auth.Screen.dart';
import 'package:powerbank/MainFrame/GetxController/Main.Frame.Service.dart';
import 'package:powerbank/MainFrame/Ui/Main.Frame.Ui.dart';
import 'package:powerbank/RechargeScreen/Controllers/Cashfree.Pg.Controller.dart';
import 'package:powerbank/RechargeScreen/Controllers/Razor.Pay.Controller.dart';
import 'package:powerbank/RechargeScreen/Controllers/Recharge.Screen.Controller.dart';
import 'package:powerbank/RechargeScreen/Controllers/Upi.Pay.Controller.dart';
import 'package:powerbank/RechargeScreen/Recharge.Screen.dart';
import 'AllActivityRecords/all_activity_controller.dart';
import 'AllActivityRecords/all_activity_screen.dart';
import 'HelperClasses/Password.Renew.Controller.dart';
import 'HelperClasses/Notice.Get.Service.dart';
import 'HelperClasses/Server.Stats.Service.dart';
import 'LoginRegister/GetXControllers/Dynamic.Link.Controller.dart';
import 'OrderWidget/Order.Ui.Controller.dart';
import 'BuyProduct/Controllers/Commission.Controller.dart';
import 'ReferIncome/GetxControllers/Refer.Controller.dart';
import 'ReferIncome/Ui/Refer.Income.Screen.dart';

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
        Get.lazyPut<DynamicLinkController>(() => DynamicLinkController(),
            fenix: true),
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
        Get.lazyPut<UpiPayController>(() => UpiPayController(), fenix: true),
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
];
