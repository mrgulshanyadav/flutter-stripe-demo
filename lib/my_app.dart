
import 'package:stripe_subscription_demo/utils/config_packages..dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      
    );
  }
}