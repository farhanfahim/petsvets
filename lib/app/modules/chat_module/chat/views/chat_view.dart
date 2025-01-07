import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:petsvet_connect/app/modules/chat_module/current_chats/views/current_chat_view.dart';
import 'package:petsvet_connect/app/modules/pet_module/my_appointment/widgets/search_widget.dart';
import 'package:petsvet_connect/utils/dimens.dart';
import '../../../../../utils/Util.dart';
import '../../../../baseviews/base_view_screen.dart';
import '../../../../components/resources/app_colors.dart';
import '../../../../components/widgets/custom_tabbar_widget.dart';
import '../../follow_up_chats/views/follow_up_chat_view.dart';
import '../view_model/chat_view_model.dart';

class ChatView extends StatelessWidget {
  final ChatViewModel viewModel = Get.put(ChatViewModel());

  ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseViewScreen(
        showAppBar: true,
        showHeader: false,
        hasBackButton: true.obs,
        verticalPadding: false,
        horizontalPadding: false,
        centerTitle: true,
        screenName: "chats".tr,
        child: Column(
          children: [
            SearchWidget(
                focusNode: viewModel.searchNode,
                color: AppColors.white,
                showClose: false,
                showFilter: false,
                showPadding: true,
                searchController: viewModel.searchController,
                onTap: () {},
                onChange: (v) {
                  viewModel.searchController.value.text = v;
                  viewModel.searchController.refresh();
                },
                onTapSuffix: () {
                  viewModel.searchController.value.text = "";
                  viewModel.searchController.refresh();
                  Util.hideKeyBoard(context);
                },
                onTapClose: () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),

              child: CustomTabbar(
                controller: viewModel.tabController!,
                tabs: [
                  for (int i = 0; i < viewModel.tabController!.length; i++)
                    Tab(
                        child: Text(
                      viewModel.tabs[i],
                    )),
                ],
                selectedColor: AppColors.gray600,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.pagesHorizontalPadding),
                  child: TabBarView(
                                controller: viewModel.tabController,
                                children: [
                  CurrentChatView(),
                  FollowUpChatView(),
                                ],
                              ),
                )),
          ],
        ));
  }
}
