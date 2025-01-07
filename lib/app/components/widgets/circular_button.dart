import 'package:flutter/material.dart';
import 'package:petsvet_connect/app/components/widgets/shadow_container.dart';
import 'mono_icons.dart';

class CircularButton extends StatelessWidget {
  final double diameter;
  final String icon;
  final Color? color, bgColor;
  final void Function()? onTap;
  final BorderSide border;
  final double elevation;
  final double ratio;
  final bool isSvg;

  const CircularButton({
    Key? key,
    required this.diameter,
    required this.icon,
    this.bgColor ,
    this.elevation = 0,
    this.ratio = 0.4,
    this.border = const BorderSide(width: 0, color: Colors.transparent),
    this.onTap,
    this.color ,
    this.isSvg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
        radius: diameter / 2,
        elevation: elevation,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
               color: bgColor,
              border: Border.fromBorderSide(border)),
          child: Material(
             color: Colors.transparent,
            child: InkWell(onTap: onTap, child: Center(child: buildChild())),
          ),
        ));
  }

  Widget buildChild() {
    return CustomMonoIcon(
      size: diameter * ratio,
      icon: icon,
      isSvg: isSvg,
      color: color,
    );
  }
}