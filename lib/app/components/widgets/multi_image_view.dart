import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as path;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/data/enums/image_type.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/app_font_size.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../utils/bottom_sheet_service.dart';
import '../../../utils/file_picker_util.dart';
import '../../data/enums/PickerType.dart';
import '../../data/models/Attachments.dart';
import '../resources/app_colors.dart';
import '../resources/app_images.dart';
import 'MyText.dart';
import 'common_image_view.dart';
import 'image_picker_view.dart';
import 'media_tile.dart';

class MultiImageView extends StatelessWidget {

  RxList<Attachments>? arrOfImage = List<Attachments>.empty().obs;
  String? coverTitle  ;
  bool? showPicker ;
  bool? showDivider ;
  bool? sidePadding ;
  bool? showTitle ;
  bool? showColor ;
  double? bottomPadding ;
  RxInt imageCount = 10.obs;
  MultiImageView({this.showTitle=true,this.showColor=false,this.sidePadding=false,this.showDivider = true,this.showPicker = true,this.bottomPadding= 5.0,this.arrOfImage,this.coverTitle= "", super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible:showPicker! && showTitle!,
          child: Padding(

            padding: EdgeInsets.only(
                left: sidePadding!?AppDimen.pagesHorizontalPadding:0,
                right:  sidePadding!?AppDimen.pagesHorizontalPadding:0,
                bottom: bottomPadding!),
          child: MyText(
            text: "you_can_upload".tr,
            color: AppColors.grey,
            fontSize: AppFontSize.extraSmall,
          ),
        ),),
        Visibility(
          visible:showPicker!,
          child: GestureDetector(
          onTap: () {
            Util.hideKeyBoard(context);
            if(arrOfImage!.length < 10) {
              onPick();
            }else{
              Util.showToast("You can upload a maximum of 10 attachments.");
            }

          },
          child: Container(
            color: showColor!?AppColors.white:null,
            padding: EdgeInsets.symmetric(vertical: AppDimen.pagesVerticalPadding,horizontal: sidePadding!?AppDimen.pagesHorizontalPadding:0),

            child: DottedBorder(
              borderType: BorderType.RRect,
              dashPattern: const [8, 7],
              color: AppColors.grey.withOpacity(0.6),
              strokeWidth: 1,
              radius: const Radius.circular(AppDimen.borderRadius),
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.fieldsBgColor,
                    borderRadius: BorderRadius.all(
                        Radius.circular(10))),
                height: 25.w,
                width: double.maxFinite,
                child: Stack(
                  alignment: Alignment.center,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        const CommonImageView(
                            svgPath: AppImages.imgCover
                        ),
                        const SizedBox(height: AppDimen.verticalSpacing,),
                        MyText(
                          text: coverTitle!,
                          color: AppColors.grey,
                          fontSize:AppFontSize.extraSmall,
                        ),
                        MyText(
                          text: "img_pdf".tr,
                          color: AppColors.grey,
                          fontSize: AppFontSize.extraSmall,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),),
          Visibility(
            visible: showDivider!,
            child: Container(
            color: AppColors.backgroundColor,
            height: AppDimen.pagesVerticalPaddingNew,
                    ),
          ),
        Obx(() =>  Visibility(
          visible: arrOfImage!.isNotEmpty,
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: AppDimen.pagesVerticalPadding,horizontal: sidePadding!? AppDimen.pagesHorizontalPadding:0),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:  3,
              mainAxisSpacing: AppDimen.gridSpacing,
              crossAxisSpacing:AppDimen.gridSpacing,
              mainAxisExtent:170,
            ),

            itemCount: arrOfImage!.length,
            itemBuilder: (context, index) {
              return MediaTile( data:arrOfImage![index],showClose: true,onCloseTap: (){
                imageCount.value++;
                arrOfImage!.removeAt(index);
                arrOfImage!.refresh();
              },);
            },
          ),
        ),)


      ],
    );
  }


  onPick(){
    BottomSheetService.showGenericBottomSheet(
      child: ImagePickerView(
        takePictureTap: () {
          pickImageFromCamera();
        },
        uploadPictureTap: () {
          pickImageFromGallery(imageCount.value);

        },
        fileTap: (){
          pickAttachments();

        },
      ),
    );
  }

  void pickImageFromCamera() async {
    final pickedFile = await FilePickerUtil.pickImages(pickerType: PickerType.camera);
    if (pickedFile != null && pickedFile.isNotEmpty) {
      for(var item in pickedFile){
        imageCount.value--;
        arrOfImage!.add( Attachments(url: item.path!,name: path.basename(item.path!),imageType: ImageType.image,size: item.path!.length / (1024 * 1024),isNetwork: false));
      }

    }
  }

  void pickImageFromGallery(count) async {
    final pickedFile = await FilePickerUtil.pickImages(count: imageCount.value);
    if (pickedFile != null && pickedFile.isNotEmpty) {
      for(var item in pickedFile){
        imageCount.value--;
        arrOfImage!.add( Attachments(url: item.path!,name: path.basename(item.path!),imageType: ImageType.image,size: item.path!.length / (1024 * 1024),isNetwork: false));
      }
    }
  }

  void pickAttachments() async {
    final pickedFile = await FilePickerUtil.pickFile();
    if (pickedFile != null) {
      for(var item in pickedFile){
        print(item.extension);
        imageCount.value--;
        if(item.extension! == "pdf"){
          arrOfImage!.add( Attachments(url: item.path!,name: path.basename(item.path!),imageType: ImageType.pdf,size: item.path!.length / (1024 * 1024),isNetwork: false));
        }
        if(item.extension! == "doc" || item.extension! == "docx"){
          arrOfImage!.add( Attachments(url: item.path!,name: path.basename(item.path!),imageType: ImageType.doc,size: item.path!.length / (1024 * 1024),isNetwork: false));
        }
      }
    }
  }

  Widget getAddImageView({String? imagePath,Function()? onRemove, Function()? onTapPick}) {
    return Expanded(
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [8, 7],
        radius: const Radius.circular(10),
        color: AppColors.grey,
        strokeWidth: 1,
        child: Container(
          decoration: BoxDecoration(color: AppColors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          height: 8.h,
          child: Stack(
            children: [
              imagePath!.isNotEmpty
                  ? imagePath.contains("https://")?CommonImageView(
                      url: imagePath,
                      height: 14.h,
                      width: double.maxFinite,
                      fit: BoxFit.cover):CommonImageView(
                      file: File(imagePath.isNotEmpty ? imagePath : ""),
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover) : Align(
                alignment: Alignment.center,
                child: Container(),
              ),

              InkWell(
                  onTap: onTapPick,
                  child: Container(
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 80,
                    width: 80,
                  )),

              Visibility(
                visible: imagePath.isNotEmpty,
                child: Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: onRemove,
                    child: Container(

                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const CommonImageView(
                            svgPath: AppImages.close
                        )
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
