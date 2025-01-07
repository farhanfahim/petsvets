import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../resources/app_colors.dart';
import 'MyText.dart';

class ProgressDialog extends StatelessWidget {

  final ProgressDialogController controller;
  final bool showProgress;
  const ProgressDialog({super.key,required this.controller,this.showProgress=false,});

  @override
  Widget build(BuildContext context) {
    final double diam = 30;
    final double radius = 10;
    final double spacing = 5;

    return PopScope(
      onPopInvoked: (val){
        print("val is: $val");
        controller._isShowing=false;
      },
      child: Material(
        color: AppColors.transparent,
        child: Center(
          child: Container(
            //  width: height,height: height,
            padding: const EdgeInsets.symmetric(vertical: 20,
                horizontal: 10),
            decoration: BoxDecoration(color: AppColors.black,borderRadius: BorderRadius.circular(radius)),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(radius: diam/2,color: AppColors.white,),
                ListenableBuilder(listenable: controller, builder: (con,wid){
                  return Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: MyText(
                        text: controller._text,fontWeight: FontWeight.w700,
                        // text: "some",
                        fontSize: 18,
                        color: AppColors.white,),
                    ),
                    Visibility(visible: showProgress && controller._prgressText.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: MyText(text: controller._prgressText, center: true,
                          fontSize: 16, color: AppColors.white, fontWeight: FontWeight.w500,),
                      ),),
                  ],);
                })
              ],),
          ),
        ),
      ),
    );
  }
}

class ProgressDialogController extends ChangeNotifier{

  String _text="",_prgressText="";
  bool _isShowing=false;

  final BuildContext context;

  ProgressDialogController(this.context,);

  void show({String? text,bool showProgress=false}){
    if(!_isShowing) {
      _isShowing=true;
      showDialog(context: context,

          builder: (con){
            return ProgressDialog(controller: this.._text=text??"Please Wait..",
              showProgress: showProgress,);
          });
    }
  }

  void hide(){
    if(_isShowing){
      _isShowing=false;
      _prgressText="";
      Navigator.pop(context);
    }
  }

  void setText(String text){
    _text=text;
    notifyListeners();
  }

  void setProgress(String text){
    _prgressText=text;
    notifyListeners();
  }

}