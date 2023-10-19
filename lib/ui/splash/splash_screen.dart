import 'package:stripe_subscription_demo/utils/config_packages..dart';

class SplashScreenUI extends StatelessWidget {
  const SplashScreenUI({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (SplashController controller) {
        return Scaffold();
      },
    );
  }
}
