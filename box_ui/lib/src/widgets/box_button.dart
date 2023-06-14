import 'package:box_ui/src/widgets/box_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../box_ui.dart';

class BoxPrimaryButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final Widget? leading;

  const BoxPrimaryButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: !disabled ? appPrimaryColor : Colors.grey, borderRadius: BorderRadius.circular(6)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () async {
            if (!disabled) await HapticFeedback.vibrate();
            onTap?.call();
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
              alignment: Alignment.center,
              child: !busy
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null) leading!,
                        if (leading != null) horizontal8px,
                        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Roboto')),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BoxLoader(color: Colors.white),
                        horizontal8px,
                        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: 'Roboto'))
                      ],
                    )),
        ),
      ),
    );
  }
}

class BoxSecondaryButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final Widget? leading;

  const BoxSecondaryButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(color: !disabled ? appSecondaryColor : Colors.grey, borderRadius: BorderRadius.circular(6)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          onTap: () async {
            if (!disabled) await HapticFeedback.vibrate();
            onTap?.call();
          },
          borderRadius: BorderRadius.circular(6),
          child: Container(
              alignment: Alignment.center,
              child: !busy
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (leading != null) leading!,
                        if (leading != null) horizontal8px,
                        Text(title, style: const TextStyle(color: appPrimaryColor, fontWeight: FontWeight.w500, fontFamily: 'Roboto')),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const BoxLoader(color: Colors.white),
                        horizontal8px,
                        Text(title, style: const TextStyle(color: appPrimaryColor, fontWeight: FontWeight.w500, fontFamily: 'Roboto'))
                      ],
                    )),
        ),
      ),
    );
  }
}

class BoxFloatingButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final bool disabled;

  const BoxFloatingButton({Key? key, this.onPressed, required this.icon, this.disabled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton.small(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          onPressed: disabled
              ? null
              : () async {
                  await HapticFeedback.vibrate();
                  onPressed?.call();
                },
          backgroundColor: !disabled ? appPrimaryColor : Colors.grey,
          disabledElevation: 0,
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ));
  }
}
