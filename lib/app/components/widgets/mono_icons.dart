import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
abstract class ResizableIcon extends Widget{
  const ResizableIcon({super.key});

  double get getIconSize;
}


class CustomMonoIcon extends StatelessWidget implements ResizableIcon{

  final double? size;
  final Color? color;
  final String icon;
  final bool isSvg;
  const CustomMonoIcon({super.key, required this.icon,required this.size,this.color=Colors.black,
    this.isSvg=true,});

  @override
  Widget build(BuildContext context) {
    return isSvg?SvgPicture.asset(icon,width: size,height: size,color: color,
      fit: BoxFit.contain,)
        :ImageIcon(AssetImage(icon),size: size,color: color);
  }

  @override
  double get getIconSize => size!;
}

class CustomIcon extends Icon implements ResizableIcon{

  const CustomIcon({super.key, required IconData data,double? size,Color? color}):super(data,
    size:size,color:color,);

  @override
  double get getIconSize => size!;
}

