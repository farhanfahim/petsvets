import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/app/modules/vet_module/statistics/widgets/statistics_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/argument_constants.dart';
import '../../../../../utils/dimens.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/widgets/MyText.dart';
import '../../../../data/enums/status_type.dart';
import '../../../../routes/app_pages.dart';
import '../view_model/statistics_view_model.dart';
import '../widgets/days_widget.dart';
import '../widgets/statistics_widget.dart';

class StatisticsView extends StatelessWidget {
  final StatisticsViewModel viewModel = Get.put(StatisticsViewModel());

  StatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        backgroundColor: AppColors.white,
        showAppBar: true,
        hasBackButton: true.obs,
        horizontalPadding: false,
        centerTitle: true,
        screenName: "statistic".tr,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const  SizedBox(height: AppDimen.pagesVerticalPadding,),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(AppDimen.pagesHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "here_is_a_showcase".tr,fontWeight: FontWeight.w400,fontSize: 14,color: AppColors.gray600,),
                    const SizedBox(
                        height: AppDimen.pagesVerticalPaddingNew
                    ),
                    SizedBox(
                        height: 35,
                        child: Obx(
                              () => ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: viewModel.arrOfDays.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DaysWidget(
                                onTap: () {

                                  for(var item in viewModel.arrOfDays){
                                    item.isSelected!.value = false;
                                  }

                                  viewModel.arrOfDays[index].isSelected!.value = true;
                                },
                                model: viewModel.arrOfDays[index],
                              );
                            },
                          ),
                        )),
                    const SizedBox(
                        height: AppDimen.pagesVerticalPaddingNew
                    ),
                    Row(
                      children: [
                        Container(
                          width:22.w,
                          child: StatisticsWidget(
                            onTap: () {},
                            title: "\$64k",
                            subTitle: "total_earnings".tr,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          width:38.w,
                          child: StatisticsWidget(
                            onTap: () {},
                            title: "35",
                            subTitle: "appointments_completed".tr,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          width:26.w,
                          child: StatisticsWidget( 
                            onTap: () {},
                            title: "\$35",
                            subTitle: "pending_amount".tr,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: AppDimen.pagesVerticalPaddingNew,
              ),
              Container(
                color: AppColors.white,
                padding: const EdgeInsets.all(AppDimen.pagesHorizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "consultation_fees_tracking".tr,fontWeight: FontWeight.w600,fontSize: 16,color: AppColors.black,),
                    const SizedBox(
                        height: AppDimen.pagesVerticalPadding
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.arrOfVets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            StatisticsTile(
                              model: viewModel.arrOfVets[index],
                              onTap: () {
                                Get.toNamed(Routes.STATISTIC_DETAIL,arguments: {
                                  ArgumentConstants.type: StatusType.completed,
                                  ArgumentConstants.subType: viewModel.arrOfVets[index].type,
                                });
                              },
                            ),
                          ],
                        );
                      },
                    ),
          
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
