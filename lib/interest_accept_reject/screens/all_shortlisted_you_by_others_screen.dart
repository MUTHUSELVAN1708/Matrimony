import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/inbox_screens/chat_screen.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/riverpod/interest_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class AllShortlistedYouByOthersScreen extends ConsumerStatefulWidget {
  const AllShortlistedYouByOthersScreen({super.key});

  @override
  ConsumerState<AllShortlistedYouByOthersScreen> createState() =>
      _SentProfileScreenState();
}

class _SentProfileScreenState
    extends ConsumerState<AllShortlistedYouByOthersScreen> {
  final Map<String, ImageProvider> _imageCache = {};

  ImageProvider getImageProvider(String? base64Image) {
    if (base64Image == null || base64Image.isEmpty) {
      return const AssetImage('assets/image/emptyProfile.png');
    }
    if (!_imageCache.containsKey(base64Image)) {
      _imageCache[base64Image] = MemoryImage(
        base64Decode(base64Image.replaceAll('\n', '').replaceAll('\r', '')),
      );
    }

    return _imageCache[base64Image]!;
  }

  @override
  Widget build(BuildContext context) {
    final interestModelState = ref.watch(interestModelProvider);
    final userManagementState = ref.watch(userManagementProvider);
    final interestState = ref.watch(interestProvider);

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'All Shortlisted You (${interestModelState.shortListToMe.length})',
            style: const TextStyle(
              color: AppColors.primaryButtonColor,
            ),
          )),
      body: EnhancedLoadingWrapper(
        isLoading: userManagementState.isLoadingForPartner ||
            interestState.isLoading ||
            interestModelState.isLoading,
        child: interestModelState.shortListToMe.isEmpty
            ? const Center(
                child: Text(
                  'You haven’t shortlisted by anyone yet.',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: interestModelState.shortListToMe.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final filteredInterests =
                        interestModelState.shortListToMe.toList();
                    final interest = filteredInterests[index];
                    final isBlocked = interestModelState.blockedMeList
                        .contains(interest.userId);
                    final isShortListed = interest.userId != null &&
                        interestModelState.shortList
                            .any((id) => id.userId == interest.userId);
                    final imageProvider =
                        getImageProvider(interest.images?.first);
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                if (!isBlocked) {
                                  final getImageApiProviderState =
                                      ref.watch(getImageApiProvider);
                                  final partnerDetails = await ref
                                      .read(userManagementProvider.notifier)
                                      .getPartnerDetails(interest.userId ?? 0);
                                  if (getImageApiProviderState.data != null &&
                                      getImageApiProviderState
                                          .data!.paymentStatus) {
                                    if (mounted) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllMatchesDetailsScreen(
                                                    userPartnerData:
                                                        partnerDetails ??
                                                            UserPartnerData(),
                                                  )));
                                    }
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PlanUpgradeScreen()));
                                  }
                                }
                              },
                              child: Container(
                                height: 170,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  isBlocked
                                      ? const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Blocked You',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Icon(
                                              Icons.block_rounded,
                                              color: Colors.red,
                                            )
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 135,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          interest.name ??
                                                              'N/A',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            color: Color(
                                                                0xFFD6151A),
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          '#${interest.uniqueId ?? 'N/A'}',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[800],
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          interest.age != null
                                                              ? '${interest.age} Yrs'
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          interest.height ??
                                                              'N/A',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          interest.education ??
                                                              'N/A',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          interest.city != null
                                                              ? '${interest.city}${interest.state != null ? ', ${interest.state}' : ''}'
                                                              : interest.state !=
                                                                      null
                                                                  ? '${interest.state}'
                                                                  : '',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 15),
                                                  height: 145,
                                                  child: const Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .medal,
                                                            color: Color(
                                                                0xFFE9A01A),
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          CustomSvg(
                                                            name: 'blue_verify',
                                                            color: Colors.blue,
                                                          ),
                                                          Text(
                                                            'Id verified',
                                                            style: TextStyle(
                                                                fontSize: 8,
                                                                color: Colors
                                                                    .blue),
                                                          )
                                                        ],
                                                      )),
                                                      SizedBox(height: 30),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                  GestureDetector(
                                    onTap: () async {
                                      final userId = interest.userId;
                                      if (userId != null) {
                                        if (isShortListed) {
                                          await ref
                                              .read(interestProvider.notifier)
                                              .unShortListUser(userId);
                                        } else {
                                          await ref
                                              .read(interestProvider.notifier)
                                              .shortListUser(userId);
                                        }
                                        await ref
                                            .read(
                                                interestModelProvider.notifier)
                                            .getShortList();
                                      }
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 5, right: 6),
                                        // height: 40,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          height: 25,
                                          // width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  isShortListed
                                                      ? 'Un Shortlist'
                                                      : 'Shortlist',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Icon(
                                                  isShortListed
                                                      ? Icons.star
                                                      : Icons
                                                          .star_border_outlined,
                                                  color: isShortListed
                                                      ? Colors.amber
                                                      : Colors.white,
                                                  size: 14,
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                  )
                                ],
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
