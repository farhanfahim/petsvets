import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:petsvet_connect/app/components/resources/app_colors.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../baseviews/base_view_screen.dart';
import '../../../components/widgets/MyText.dart';
import '../../../components/widgets/Skeleton.dart';
import '../../../data/models/notification_model.dart';
import '../../../data/models/vet_response_model.dart';
import '../../../repository/notification_repository.dart';
import '../view_model/notification_view_model.dart';
import '../widgets/notification_tile.dart';

class NotificationView extends StatelessWidget {

  NotificationViewModel viewModel = Get.put(NotificationViewModel(repository: Get.find<NotificationRepository>()));

  NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
      backgroundColor: AppColors.white,
        showAppBar: true,
        hasBackButton: true.obs,
        screenName: "notification".tr,
        centerTitle: true,
        horizontalPadding: false,
        verticalPadding: false,
        actions:  [
          GestureDetector(
            onTap: (){
              viewModel.readAll();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
              child: MyText(
                text: "mark_all_read".tr,
                fontWeight: FontWeight.w500,
                color: AppColors.gray600,
                fontSize: 14,
              ),
            ),
          ),
        ],
        child: Column(
          children: [
            const SizedBox(height: AppDimen.contentSpacing,),

            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  return Future.delayed(const Duration(seconds: 2), () {
                    viewModel.refreshData();
                  });
                },
                child: PagedListView<int, NotificationData>.separated(
                  pagingController: viewModel.vetListController,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  builderDelegate: PagedChildBuilderDelegate<NotificationData>(
                    itemBuilder: (context_, item, index) {
                      return NotificationTile(
                        isLast: viewModel.vetListController.itemList!.length -1 == index,
                        model: viewModel.vetListController.itemList![index],
                        onTap: () {

                        },
                      );
                    },
                    noItemsFoundIndicatorBuilder: (context) => SizedBox(
                      height: 70.h,
                      child: const Center(
                        child: MyText(
                            text: 'No Notifications Found',
                            fontSize: 12,
                            center: true,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColor
                        ),
                      ),
                    ),
                    newPageProgressIndicatorBuilder: (context) =>
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: SizedBox(
                          width: 15.0,
                          height: 15.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
                    ),
                    firstPageProgressIndicatorBuilder: (context) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.0,
                              width: double.maxFinite,
                              child: Skeleton(),
                            ),

                            SizedBox(height: 10.0,),

                            SizedBox(
                              height: 50.0,
                              width: double.maxFinite,
                              child: Skeleton(),
                            ),

                            SizedBox(height: 10.0,),

                            SizedBox(
                              height: 50.0,
                              width: double.maxFinite,
                              child: Skeleton(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
