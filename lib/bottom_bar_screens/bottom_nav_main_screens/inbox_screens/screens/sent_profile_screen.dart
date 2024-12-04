import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/riverpod/interest_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class SentProfileScreen extends ConsumerStatefulWidget {
  const SentProfileScreen({super.key});

  @override
  ConsumerState<SentProfileScreen> createState() => _SentProfileScreenState();
}

class _SentProfileScreenState extends ConsumerState<SentProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final interestModelState = ref.watch(interestModelProvider);
    final userManagementState = ref.watch(userManagementProvider);
    return EnhancedLoadingWrapper(
      isLoading: userManagementState.isLoadingForPartner,
      child: interestModelState.sentInterests.isEmpty
          ? const Center(
              child: Text(
                'You haven’t sent any interests yet.',
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
                itemCount: interestModelState.sentInterests.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final filteredInterests =
                      interestModelState.sentInterests.toList();
                  filteredInterests.sort((a, b) {
                    const statusOrder = {
                      'Accepted': 0,
                      'Pending': 1,
                      'Rejected': 2
                    };
                    final aOrder = statusOrder[a.status] ?? 3;
                    final bOrder = statusOrder[b.status] ?? 3;
                    return aOrder.compareTo(bOrder);
                  });
                  final interest = filteredInterests[index];
                  final imageProvider = interest.images!.isEmpty
                      ? const AssetImage('assets/image/emptyProfile.png')
                          as ImageProvider<Object>
                      : MemoryImage(
                          base64Decode(
                            interest.images!.first
                                .toString()
                                .replaceAll('\n', '')
                                .replaceAll('\r', ''),
                          ),
                        );
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 135,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            interest.name ?? 'N/A',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Color(0xFFD6151A),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            '#${interest.uniqueId ?? 'N/A'}',
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            interest.age != null
                                                ? '${interest.age} Yrs'
                                                : 'N/A',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            interest.height ?? 'N/A',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            interest.education ?? 'N/A',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          Text(
                                            interest.city != null
                                                ? '${interest.city}${interest.state != null ? ', ${interest.state}' : ''}'
                                                : interest.state != null
                                                    ? '${interest.state}'
                                                    : '',
                                            style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 14,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 15),
                                    height: 145,
                                    child: const Column(
                                      children: [
                                        SizedBox(height: 10),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            CustomSvg(name: 'medal'),
                                            CustomSvg(
                                              name: 'blue_verify',
                                              color: Colors.blue,
                                            ),
                                            Text(
                                              'Id verified',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.blue),
                                            )
                                          ],
                                        )),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 5, right: 6),
                                  // height: 40,
                                  child: interestModelState.blockLists.any(
                                              (model) =>
                                                  model.userId ==
                                                  interest.userId) ||
                                          interestModelState.ignoredLists.any(
                                              (model) =>
                                                  model.userId ==
                                                  interest.userId)
                                      ? GestureDetector(
                                          onTap: () async {
                                            if (interestModelState.blockLists
                                                .any((model) =>
                                                    model.userId ==
                                                    interest.userId)) {
                                              await ref
                                                  .read(
                                                      interestProvider.notifier)
                                                  .unblockProfile(
                                                      interest.userId!);
                                              await ref
                                                  .read(interestModelProvider
                                                      .notifier)
                                                  .getBlockedUsers();
                                            } else {
                                              await ref
                                                  .read(
                                                      interestProvider.notifier)
                                                  .showAgain(interest.userId!);
                                              await ref
                                                  .read(interestModelProvider
                                                      .notifier)
                                                  .getDoNotShowUsers();
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
                                            height: 25,
                                            // width: 100,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.red.withOpacity(0.9),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    interestModelState
                                                            .blockLists
                                                            .any((model) =>
                                                                model.userId ==
                                                                interest.userId)
                                                        ? 'Unblock'
                                                        : 'Show Again',
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  Icon(
                                                    interestModelState
                                                            .blockLists
                                                            .any((model) =>
                                                                model.userId ==
                                                                interest.userId)
                                                        ? Icons
                                                            .lock_open_outlined
                                                        : Icons.undo_outlined,
                                                    color: Colors.white,
                                                    size: 14,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : interest.status == 'Accepted'
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {},
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    height: 25,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Send Message',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {},
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 5),
                                                    height: 25,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.red.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Call Now',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : interest.status == 'Pending'
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  height: 25,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: const Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Requested',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .access_time_filled_outlined,
                                                          color: Colors.white,
                                                          size: 14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 5),
                                                  height: 25,
                                                  // width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.red
                                                        .withOpacity(0.7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: const Center(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Rejected',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Icon(
                                                          Icons.block_rounded,
                                                          color: Colors.white,
                                                          size: 14,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
