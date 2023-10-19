import 'package:stripe_subscription_demo/utils/config_packages..dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? textize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const TextWidget(
      {super.key,
      required this.text,
      this.textize,
      this.color,
      this.fontWeight,
      this.overflow,
      this.textDirection, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style:  TextStyle(
        color: color??AppColors.black,
        fontSize: textize,
        fontWeight: fontWeight,
        
      ),
    );
  }
}
