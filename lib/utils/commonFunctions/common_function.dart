import 'package:stripe_subscription_demo/utils/config_packages..dart';

CommonFunction commonFunction = CommonFunction();

class CommonFunction {
  void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}
