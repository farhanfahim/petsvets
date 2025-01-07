import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_text_styles.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'MyText.dart';

class RadioBoxField extends StatefulWidget {
  final void Function(bool val) callback;
  final bool initialValue;
  final bool mandatory;
  final String simpleTitle;

  const RadioBoxField({
    super.key,
    required this.callback,
    this.mandatory = false,
    this.initialValue = false,
    this.simpleTitle = "Please Enter Title",
  });

  @override
  State<RadioBoxField> createState() => _RadioBoxFieldState();
}

class _RadioBoxFieldState extends State<RadioBoxField> {
  // RxBool isActive = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isActive = widget.initialValue;
    });
  }

  bool isActive = false;

  void userActive(bool val) {
    setState(() {
      isActive = val;
    });
    widget.callback(val);
  }

  @override
  void didUpdateWidget(covariant RadioBoxField oldWidget) {
    isActive=widget.initialValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(widget.mandatory){
          widget.callback(widget.initialValue);
        }else{
        userActive(!isActive);
        }
      },

      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              color: AppColors.transparent,
              child: Center(
                child: isActive
                    ? SvgPicture.asset(
                        AppImages.radioSelected,
                      )
                    : SvgPicture.asset(
                        AppImages.radioUnSelected,
                      ),
              ),
            ),
            MyText(
                    text: widget.simpleTitle,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                    fontSize: 14,
                  ),
          ],
        ),
      ),
    );
  }
}
