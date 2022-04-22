import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:powerbank/Constants/strings.dart';

//not yet implemented
class DynamicLinkController extends GetxController {
  final dynamicLink = FirebaseDynamicLinks.instance;
  buildShortDynamicLink() async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      // The Dynamic Link URI domain. You can view created URIs on your Firebase console
      uriPrefix: appWebsiteLink,
      // The deep Link passed to your application which you can use to affect change
      link: Uri.parse('$appWebsiteLink?refcode=alpln5256261616'),
      // Android application details needed for opening correct app on device/Play Store
      androidParameters: const AndroidParameters(
        packageName: "com.alphacorp.alphaplan2",
        minimumVersion: 1,
      ),
      // iOS application details needed for opening correct app on device/App Store
      iosParameters: const IOSParameters(
        bundleId: "iosBundleId",
        minimumVersion: '1',
      ),
    );
    final ShortDynamicLink shortDynamicLink =
        await dynamicLink.buildShortLink(parameters);
    final Uri uri = shortDynamicLink.shortUrl;
    print(uri.toString());
  }

  /////////////////////////////////
  late final PendingDynamicLinkData? initialLink;
  Future<void> handleDynamicLink() async {
    initialLink = await dynamicLink.getInitialLink();
    if (initialLink != null) {
      final Uri? deepLink = initialLink?.link;
      // Example of using the dynamic link to push the user to a different screen
      SmartDialog.showToast(deepLink.toString());
    }
  }
}
