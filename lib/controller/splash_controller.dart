import 'package:stripe_subscription_demo/utils/config_packages..dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    changeScreen();
  }

  void changeScreen() {
    Timer(const Duration(seconds: 2), () {
      Get.offAll(()=> const HomeScreenUI());
    });
  }
}
