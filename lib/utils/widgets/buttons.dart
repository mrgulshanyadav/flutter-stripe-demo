import 'package:flutter/cupertino.dart';
import 'package:stripe_subscription_demo/utils/config_packages..dart';

class CommonIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const CommonIconButton(
      {super.key, required this.onTap, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: IconButton(
          // constraints: const BoxConstraints(),
          // splashRadius: 5,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          highlightColor: AppColors.grey.withOpacity(.1),
          onPressed: onTap,
          icon: child),
    );
  }
}

class CommonMaterialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double? radius;
  const CommonMaterialButton(
      {super.key, this.onTap, required this.child, this.radius});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      child,
      Positioned.fill(
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 0)),
          padding: EdgeInsets.zero,
          onPressed: onTap,
        ),
      ),
    ]);
  }
}

class CommonCupertinoButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? pressedOpacity;
  const CommonCupertinoButton({super.key, required this.onTap, required this.child, this.padding, this.pressedOpacity});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 10,
      pressedOpacity: pressedOpacity ?? .7,
      padding: padding ?? EdgeInsets.zero,
      onPressed: onTap,
      child: child,
    );
  }
}
