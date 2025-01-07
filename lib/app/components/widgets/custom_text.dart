import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final String fontFamily;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow? overflow;
  final bool? center;
  final bool? alignRight;
  final int? maxLines;
  final FontStyle fontStyle;
  final double? height;
  final double letterSpacing;

  const CustomTextWidget({
    super.key,
    required this.text,
    this.color = AppColors.black,
    this.fontSize = 11,
    this.fontWeight = FontWeight.w400,
    this.overflow = TextOverflow.ellipsis,
    this.center,
    this.alignRight,
    this.maxLines,
    this.fontStyle = FontStyle.normal,
    this.height,
    this.letterSpacing = 0.0,
    this.fontFamily = AppFonts.fontMulish,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow ?? TextOverflow.visible,
      textAlign: center == null
          ? alignRight != null
              ? TextAlign.right
              : TextAlign.left
          : center!
              ? TextAlign.center
              : TextAlign.left,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: 11,
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        height: height,
      ),
    );
  }
}

class CustomRichText extends StatelessWidget {
  //final String text1,text2;
  final double fontSize;
  final TextAlign textAlign;
  final List<TextSpan> spans;
  final double linespacing;
  final String? fontFamily;
  final bool isSp;
  final Color color;
  final int? maxlines;
  final FontWeight? fontWeight;

  const CustomRichText({
    Key? key,
    required this.spans,this.maxlines,
    this.fontSize = 15,
    this.linespacing = 1.2,
    this.textAlign = TextAlign.start,
    this.color = AppColors.black,
    this.fontFamily = AppFonts.fontMulish,
    this.fontWeight,
    this.isSp = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
/*    return RichText(
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis, // TextOverflow.clip // TextOverflow.fade
      text: TextSpan(
        style: TextStyle(fontSize: fontSize,color: f),
        // style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(text: 'bold dsdasdaadssdadasdsasad dsaadsdsadsadsaadsdas ssadsaasddsadsdsa',
              style: TextStyle(fontWeight: FontWeight.bold)),
          //TextSpan(text: ' world!'),
        ],
      ),
    );*/
    return RichText(
        textAlign: textAlign,
        maxLines: maxlines,overflow: maxlines!=null?TextOverflow.ellipsis:TextOverflow.visible,
        softWrap: true,
        text: TextSpan(
          style: TextStyle(
              color: color,
           //   overflow: TextOverflow.ellipsis,
              height: linespacing,fontWeight: fontWeight,
              fontFamily: fontFamily,
              fontSize: fontSize),
          children: spans,
        ));
  }
}

class CustomSpan extends TextSpan {
  CustomSpan(
      {String text = "",double? fontSize,
        Color fontColor = AppColors.black,
        FontWeight? fontWeight,
        bool isSp = true,TextOverflow overflow=TextOverflow.visible,
        void Function()? onTap})
      : super(
      text: text,
      style: TextStyle(
        color: fontColor,
        fontWeight: fontWeight,overflow: overflow,
        fontSize: fontSize,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap);
}