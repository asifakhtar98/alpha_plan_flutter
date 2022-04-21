import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:powerbank/BuyProduct/Controllers/Commission.Controller.dart';

import 'GetxStreams/Server.Permit.Stream.dart';
import 'HelperClasses/Network.Controller.dart';

class GlobalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put<ServerPermitStreamController>(ServerPermitStreamController(),
        permanent: true);
    Get.put<CommissionController>(CommissionController(), permanent: true);
  }
}
