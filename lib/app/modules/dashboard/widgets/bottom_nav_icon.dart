import 'package:flutter/material.dart';
import '../../../components/widgets/common_image_view.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
    required this.icon,
    required this.selectedIcon,
    this.selected = false,
  });

  final String icon;
  final String selectedIcon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 10),
      child: CommonImageView(
        svgPath: selected ? selectedIcon : icon,
      ),
    );
  }
}
