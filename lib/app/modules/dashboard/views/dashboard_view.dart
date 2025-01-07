import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/routes/app_pages.dart';
import 'package:petsvet_connect/utils/Util.dart';
import 'package:petsvet_connect/utils/constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:petsvet_connect/app/baseviews/base_view_screen.dart';
import 'package:petsvet_connect/app/components/widgets/counter_badge.dart';
import 'package:petsvet_connect/app/modules/dashboard/widgets/bottom_nav_icon.dart';
import '../../../../utils/app_decorations.dart';
import '../../../components/resources/app_colors.dart';
import '../../../components/resources/app_images.dart';
import '../../../components/widgets/common_image_view.dart';
import '../view_model/dashboard_view_model.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final DashboardViewModel viewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => BaseViewScreen(
        horizontalPadding: false,
        verticalPadding: false,
        showHeader: viewModel.selectedIndex.value != 1,
        ///Show/hide app bar logo and text based on bottom nav selection
        titleWidget: viewModel.showLogoAppBar()
            ? Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: CommonImageView(
              imagePath: AppImages.appBarLogo,
              width: 20.h,
            ),
          ),
        )
            : null,
        screenName: viewModel.role.value == Constants.roleVet?viewModel.getVetAppBarTitle():viewModel.getPetAppBarTitle(),
        hasBackButton: false.obs,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () async {

                 Get.toNamed(Routes.CHAT);
                },
                icon: const CommonImageView(
                  svgPath: AppImages.chat,
                ),
              ),
              CounterBadge(count: viewModel.unreadMessageCount,),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () async {
                  Get.toNamed(Routes.NOTIFICATION);
                },
                icon: const CommonImageView(
                  svgPath: AppImages.notification,
                ),
              ),
              CounterBadge(count: viewModel.unreadNotificationCount,),
            ],
          ),
        ],
        customBottomBar: Container(
          decoration: AppDecorations.bottomBarDecoration(),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: viewModel.selectedIndex.value,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              elevation: 0,
              backgroundColor: Colors.transparent,
              selectedItemColor: AppColors.red,
              onTap: (index) {

                  if(index == 2){

                    if(viewModel.role.value == Constants.rolePet){
                      Get.toNamed(Routes.SEARCH);
                    }else{
                      viewModel.selectedIndex.value = index;
                      viewModel.changePage(index);
                    }
                  }else{
                    viewModel.selectedIndex.value = index;
                    viewModel.changePage(index);
                  }


              },
              items: [
                BottomNavigationBarItem(
                  icon: BottomNavIcon(
                    selectedIcon: AppImages.homeSelected,
                    icon: AppImages.home,
                    selected: viewModel.selectedIndex.value == 0,
                  ),
                  label: "home".tr,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavIcon(
                    selectedIcon: AppImages.appointmentSelected,
                    icon: AppImages.appointment,
                    selected: viewModel.selectedIndex.value == 1,
                  ),
                  label: viewModel.role.value == Constants.roleVet?"my_booking".tr:"appointment".tr,
                ),
                 if(viewModel.role.value == Constants.rolePet)BottomNavigationBarItem(
                  icon: BottomNavIcon(
                    selectedIcon: AppImages.search,
                    icon: AppImages.search,
                    selected: viewModel.selectedIndex.value == 2,
                  ),
                  label: "search".tr,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavIcon(
                    selectedIcon: AppImages.calenderSelected,
                    icon: AppImages.calender,
                    selected: viewModel.role.value == Constants.rolePet?viewModel.selectedIndex.value == 3:viewModel.selectedIndex.value == 2,
                  ),
                  label: "calender".tr,
                ),
                BottomNavigationBarItem(
                  icon: BottomNavIcon(
                    selectedIcon: AppImages.myProfileSelected,
                    icon: AppImages.myProfile,
                    selected:  viewModel.role.value == Constants.rolePet?viewModel.selectedIndex.value == 4:viewModel.selectedIndex.value == 3,
                  ),
                  label: "my_profile".tr,
                ),
              ],
            ),
          ),
        ),
        child: PageView(
          controller: viewModel.pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: viewModel.screens
        ),
      ),
    );
  }
}
