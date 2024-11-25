import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final bool flagIcon;
  final Widget? child;
  final Function() onTap;
  final bool? isSelected;
  final Color? iconColor;
  final double iconSize;
  final double titleSize;
  DrawerTile(
      {
        required this.title,
        required this.icon,
        required this.flagIcon,
        required this.child,
        required this.onTap,
        this.iconSize = 20,
        this.titleSize = 15,
        this.isSelected = false,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: isSelected! ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              flagIcon?Icon(icon, size: iconSize, color: const Color.fromRGBO(0, 0, 0, 0.7)):child!,
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(title!,
                    style: TextStyle(
                        letterSpacing: .3,
                        fontSize: titleSize,
                        color: isSelected!
                            ? const Color.fromRGBO(0, 0, 0, 0.7)
                            : const Color.fromRGBO(0, 0, 0, 0.7))),
              )
            ],
          )),
    );
  }
}
