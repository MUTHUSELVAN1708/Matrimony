import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/interest_accept_reject/screens/all_recieved_profile_list_screen.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/riverpod/interest_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class ProfileCardStack extends ConsumerStatefulWidget {
  const ProfileCardStack({super.key});

  @override
  ConsumerState<ProfileCardStack> createState() => _ProfileCardStackState();
}

class _ProfileCardStackState extends ConsumerState<ProfileCardStack> {
  int currentIndex = 0;

  void nextProfile() {
    if (ref.read(interestModelProvider).receivedInterests.isNotEmpty) {
      if (currentIndex <
          ref.read(interestModelProvider).receivedInterests.length - 1) {
        setState(() {
          currentIndex++;
        });
      }
    }
  }

  void previousProfile() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final interestModelState = ref.watch(interestModelProvider);
    final interestState = ref.watch(interestProvider);
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Waiting For Your Response',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  if (getImageApiProviderState.data != null &&
                      getImageApiProviderState.data!.paymentStatus)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RequestProfilesScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryButtonColor,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Text(
                          'View All',
                          style: AppTextStyles.primarybuttonText
                              .copyWith(fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              interestModelState.isLoading || interestState.isLoading
                  ? Container(
                      height: 155,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3))),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: Colors.pink,
                      )),
                    )
                  : getImageApiProviderState.data != null &&
                          !getImageApiProviderState.data!.paymentStatus
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PlanUpgradeScreen()));
                          },
                          child: Container(
                            height: 155,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.3))),
                            child: Center(
                                child: Container(
                              height: 30,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal:
                                      MediaQuery.of(context).size.width / 4),
                              decoration: BoxDecoration(
                                color: AppColors.primaryButtonColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  'Upgrade Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )),
                          ),
                        )
                      : interestModelState.receivedInterests
                              .where((status) => status.status == 'Pending')
                              .isEmpty
                          ? Container(
                              height: 155,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.3))),
                              child: const Center(
                                child: Text(
                                  'No requests received yet.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: interestModelState.receivedInterests
                                  .where((status) => status.status == 'Pending')
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final filteredInterests = interestModelState
                                    .receivedInterests
                                    .where((interest) =>
                                        interest.status == 'Pending' &&
                                        !interestModelState.blockedMeList
                                            .contains(interest.userId))
                                    .toList();
                                final interest = filteredInterests[index];
                                final imageProvider = interest.images!.isEmpty
                                    ? const AssetImage(
                                            'assets/image/emptyProfile.png')
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () async {
                                            if (getImageApiProviderState.data !=
                                                    null &&
                                                getImageApiProviderState
                                                    .data!.paymentStatus) {
                                              final partnerDetails = await ref
                                                  .read(userManagementProvider
                                                      .notifier)
                                                  .getPartnerDetails(
                                                      interest.userId ?? 0);
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
                                            height: 155,
                                            margin:
                                                const EdgeInsets.only(right: 8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
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
                                        child: SizedBox(
                                          height: 155,
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await ref
                                                        .read(interestProvider
                                                            .notifier)
                                                        .acceptProfile(
                                                            'Accepted',
                                                            interest
                                                                .interestId!);
                                                    await ref
                                                        .read(
                                                            interestModelProvider
                                                                .notifier)
                                                        .getReceivedInterests();
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black54,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Accept',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 155,
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black38),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          '"${ref.watch(userManagementProvider).userDetails.gender == 'Male' ? 'She' : 'He'} has sent an\ninterest to you"',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          interest.interestCreatedAt !=
                                                                  null
                                                              ? DateFormat(
                                                                      'dd MMM yyyy')
                                                                  .format(DateTime
                                                                      .parse(interest
                                                                          .interestCreatedAt!))
                                                              : 'N/A',
                                                          style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            color: Colors
                                                                .grey[500],
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 4),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await ref
                                                        .read(interestProvider
                                                            .notifier)
                                                        .rejectProfile(
                                                            'Rejected',
                                                            interest
                                                                .interestId!);
                                                    await ref
                                                        .read(
                                                            interestModelProvider
                                                                .notifier)
                                                        .getReceivedInterests();
                                                  },
                                                  child: Container(
                                                    height: 20,
                                                    width: 98,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.red.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Decline',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
            ],
          ),
        ),

        // Navigation Arrows
        Positioned(
          left: 10,
          top: 25,
          bottom: 0,
          child: Center(
            child: GestureDetector(
                onTap: currentIndex > 0 ? previousProfile : null,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: const CustomSvg(
                    name: 'arrowleft',
                    height: 30,
                    width: 30,
                  ),
                )),
          ),
        ),
        Positioned(
          right: 10,
          top: 25,
          bottom: 0,
          child: Center(
            child: GestureDetector(
                onTap: currentIndex <
                        interestModelState.receivedInterests.length - 1
                    ? nextProfile
                    : null,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: const CustomSvg(
                    name: 'arrowright',
                    height: 30,
                    width: 30,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
