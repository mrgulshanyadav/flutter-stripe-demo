
import 'package:stripe_subscription_demo/constants/app_sizes.dart';
import 'package:stripe_subscription_demo/utils/config_packages..dart';
import 'package:stripe_subscription_demo/utils/widgets/text_widget.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const CustomAppbar({Key? key, required this.title, this.actions})
      : super(key: key);

  static final _appBar = AppBar();
  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(text: title, textize: AppSizes.text18,color: AppColors.white,),
      actions: actions,
    );
  }
}
