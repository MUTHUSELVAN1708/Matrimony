import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/interest_accept_reject/state/interest_state.dart';
import 'package:matrimony/interest_block_dontshow_report_profile/riverpod/interest_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    final allMatchProvider = ref.watch(allMatchesProvider);
    return EnhancedLoadingWrapper(
      isLoading: ref.watch(userManagementProvider).isLoadingForPartner,
      child: Scaffold(
        body: SafeArea(
          child: allMatchProvider.allMatchList != null &&
                  allMatchProvider.allMatchList!.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${allMatchProvider.allMatchList!.length} Matches',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headingTextstyle,
                    ),
                    Text(
                      'Based on your Partner preferences',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.spanTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.builder(
                          itemCount: allMatchProvider.allMatchList!.length,
                          itemBuilder: (context, index) {
                            final matchingData =
                                allMatchProvider.allMatchList![index];
                            return MatchCard(match: matchingData);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    'No Matches Available.',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
        ),
      ),
    );
  }
}

class MatchCard extends ConsumerWidget {
  final Matches match;

  const MatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interestState = ref.watch(interestModelProvider);
    final isBlocked = interestState.blockedMeList.contains(match.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: match.images![0].isNotEmpty
                ? Image.memory(
                    base64Decode(match.images![0]),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    color: Colors.pink.withOpacity(0.3),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(isBlocked ? 0.6 : 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          if (isBlocked)
            const Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Blocked You",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 1),
                          blurRadius: 4,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Icon(
                    Icons.block_rounded,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          if (!isBlocked)
            Positioned(
              bottom: 50,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    match.name.toString(),
                    style: AppTextStyles.headingTextstyle.copyWith(
                        color: AppColors.primaryButtonTextColor,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '#${match.uniqueId ?? ''}',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.primaryButtonTextColor, fontSize: 14),
                  ),
                ],
              ),
            ),
          if (!isBlocked)
            Positioned(
              right: 10,
              top: 10,
              child: SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () async {
                    final getImageApiProviderState =
                        ref.watch(getImageApiProvider);
                    final partnerDetails = await ref
                        .read(userManagementProvider.notifier)
                        .getPartnerDetails(match.id ?? 0);
                    if (getImageApiProviderState.data != null &&
                        getImageApiProviderState.data!.paymentStatus) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllMatchesDetailsScreen(
                                    userPartnerData:
                                        partnerDetails ?? UserPartnerData(),
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PlanUpgradeScreen()));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    'View Details',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          if (!isBlocked)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    if (match.occupation != null && match.occupation != '') ...[
                      _buildInfoChip(match.occupation!),
                      const SizedBox(width: 8),
                    ],
                    if (match.age != null) ...[
                      _buildInfoChip('${match.age} Yrs'),
                      const SizedBox(width: 8),
                    ],
                    if (match.caste != null && match.caste != '') ...[
                      _buildInfoChip(match.caste!),
                      const SizedBox(width: 8),
                    ],
                    if (match.state != null &&
                        match.state != '' &&
                        match.city != null &&
                        match.city != '') ...[
                      _buildInfoChip('${match.city},${match.state!}'),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
          overflow: TextOverflow.ellipsis, // Ellipsis for long text
          maxLines: 1, // Limit to one line
        ),
      ),
    );
  }
}
