import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/riverpod/interest_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';

class BlockListScreen extends ConsumerStatefulWidget {
  const BlockListScreen({super.key});

  @override
  ConsumerState<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends ConsumerState<BlockListScreen> {
  @override
  Widget build(BuildContext context) {
    final interestModelState = ref.watch(interestModelProvider);
    final interestState = ref.watch(interestProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Blocked Profiles',
          style: AppTextStyles.headingTextstyle,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.headingTextColor,
            )),
      ),
      body: interestModelState.blockLists.isEmpty
          ? Center(
              child: Text(
                'No Blocked Profiles!',
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.5), fontSize: 20),
              ),
            )
          : EnhancedLoadingWrapper(
              isLoading:
                  interestModelState.isLoading || interestState.isLoading,
              child: ListView.builder(
                  itemCount: interestModelState.blockLists.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final blockUser = interestModelState.blockLists[index];
                    final imageProvider = blockUser.images!.isEmpty
                        ? const AssetImage('assets/image/emptyProfile.png')
                            as ImageProvider<Object>
                        : MemoryImage(
                            base64Decode(
                              blockUser.images!.first
                                  .toString()
                                  .replaceAll('\n', '')
                                  .replaceAll('\r', ''),
                            ),
                          );
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // Background color
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            offset: Offset(1, 2),
                            blurRadius: 11.1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              height: MediaQuery.of(context).size.height / 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Stack(children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                height: MediaQuery.of(context).size.height / 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        const CustomSvg(
                                          name: 'blue_verify',
                                          height: 10,
                                        ),
                                        Text(
                                          'Id Verified',
                                          style: AppTextStyles.spanTextStyle
                                              .copyWith(
                                                  fontSize: 10,
                                                  color:
                                                      const Color(0XFF1576F0)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '#${blockUser.uniqueId}',
                                      style: AppTextStyles.spanTextStyle
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                      blockUser.name.toString(),
                                      style: AppTextStyles.headingTextstyle
                                          .copyWith(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${blockUser.age} Yrs',
                                      style: AppTextStyles.spanTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      blockUser.height ?? '',
                                      style: AppTextStyles.spanTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      blockUser.education ?? '',
                                      style: AppTextStyles.spanTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      blockUser.city != null
                                          ? '${blockUser.city}${blockUser.state != null ? ', ${blockUser.state}' : ''}'
                                          : blockUser.state != null
                                              ? '${blockUser.state}'
                                              : '',
                                      style: AppTextStyles.spanTextStyle
                                          .copyWith(
                                              fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () async {
                                      final result = await ref
                                          .read(interestProvider.notifier)
                                          .unblockProfile(blockUser.userId!);
                                      if (result) {
                                        ref
                                            .read(
                                                interestModelProvider.notifier)
                                            .removeBlockList(blockUser.userId!);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: AppColors.headingTextColor),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Row(
                                        children: [
                                          const CustomSvg(
                                            name: 'block_list',
                                            color: AppColors
                                                .primaryButtonTextColor,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "Unblock",
                                            style: AppTextStyles.spanTextStyle
                                                .copyWith(
                                                    color: AppColors
                                                        .primaryButtonTextColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ]),
                          )
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
