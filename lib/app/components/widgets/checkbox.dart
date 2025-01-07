import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_text_styles.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'MyText.dart';

class CheckBoxField extends StatefulWidget {
  final void Function(bool val) callback;
  final bool isRichText;
  final bool initialValue;
  final String simpleTitle;
  final String richText1;
  final String richText2;
  final String richText3;
  final Function? richTextCallBack;

  const CheckBoxField({
    super.key,
    required this.callback,
    this.isRichText = false,
    this.initialValue = false,
    this.simpleTitle = "Please Enter Title",
    this.richText1 = "Please Enter 1st Text",
    this.richText2 = "Please Enter 2nd Text",
    this.richText3 = "Please Enter 2nd Text",
    this.richTextCallBack,
  });

  @override
  State<CheckBoxField> createState() => _CheckBoxFieldState();
}

class _CheckBoxFieldState extends State<CheckBoxField> {
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
  void didUpdateWidget(covariant CheckBoxField oldWidget) {
    isActive=widget.initialValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        userActive(!isActive);
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
                        AppImages.imgCheckSelect,
                      )
                    : SvgPicture.asset(
                        AppImages.imgUnCheckSelect,
                      ),
              ),
            ),
            widget.isRichText
                ? Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: widget.richText1,
                        style: AppTextStyles.checkBoxLabelStyle(),
                        children: <TextSpan>[
                          TextSpan(
                            text: " ${widget.richText2}",
                            style: AppTextStyles.checkBoxLabelStyle().copyWith(color: AppColors.blue,fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (widget.richTextCallBack != null) {
                                  widget.richTextCallBack!(widget.richText2);
                                }
                              },
                          ),
                          TextSpan(
                            text: " & ",
                            style: AppTextStyles.checkBoxLabelStyle(),
                          ),
                          TextSpan(
                            text: widget.richText3,
                            style: AppTextStyles.checkBoxLabelStyle().copyWith(color: AppColors.blue,fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (widget.richTextCallBack != null) {
                                  widget.richTextCallBack!(widget.richText3);
                                }
                              },
                          )
                        ],
                      ),
                    ),
                  )
                : MyText(
                    text: widget.simpleTitle,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
          ],
        ),
      ),
    );
  }
}
