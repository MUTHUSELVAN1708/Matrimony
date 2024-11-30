import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/daily_recommented_notifier.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class DailyRecommendationListScreen extends ConsumerStatefulWidget {
  const DailyRecommendationListScreen({super.key});

  @override
  ConsumerState<DailyRecommendationListScreen> createState() =>
      _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<DailyRecommendationListScreen> {
  @override
  Widget build(BuildContext context) {
    final dailyRecommendState = ref.watch(dailyRecommendProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Recommendations ${dailyRecommendState.dailyRecommendList.isNotEmpty ? '(${dailyRecommendState.dailyRecommendList.length})' : ''}',
          style: const TextStyle(color: AppColors.primaryButtonColor),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryButtonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: dailyRecommendState.dailyRecommendList.isNotEmpty
          ? Container(
              color: Colors.white.withOpacity(0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Based on your Partner preferences',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.spanTextStyle
                        .copyWith(color: Colors.black, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.builder(
                        itemCount:
                            dailyRecommendState.dailyRecommendList.length,
                        itemBuilder: (context, index) {
                          final dailyRecommend =
                              dailyRecommendState.dailyRecommendList[index];
                          return MatchCard(dailyRecommend: dailyRecommend);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                'No Daily Recommendations Available.',
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}

class MatchCard extends ConsumerWidget {
  final DailyRecommend dailyRecommend;

  const MatchCard({
    super.key,
    required this.dailyRecommend,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(8), // Adjust radius for the card
            child: dailyRecommend.images.isNotEmpty
                ? Image.memory(
                    base64Decode(dailyRecommend.images.first),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dailyRecommend.name.toString(),
                  style: AppTextStyles.headingTextstyle.copyWith(
                      color: AppColors.primaryButtonTextColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  '#${dailyRecommend.uniqueId ?? ''}',
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: AppColors.primaryButtonTextColor, fontSize: 14),
                ),
              ],
            ),
          ),
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
                      .getPartnerDetails(dailyRecommend.userId ?? 0);
                  if (getImageApiProviderState.data != null &&
                      getImageApiProviderState.data!.paymentStatus) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllMatchesDetailsScreen(
                                  userPartnerData:
                                      partnerDetails ?? UserPartnerData(),
                                  isDailyRecommend: true,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (dailyRecommend.occupation != null &&
                      dailyRecommend.occupation != '') ...[
                    _buildInfoChip(dailyRecommend.occupation!),
                    const SizedBox(width: 8),
                  ],
                  if (dailyRecommend.age != null) ...[
                    _buildInfoChip('${dailyRecommend.age} Yrs'),
                    const SizedBox(width: 8),
                  ],
                  if (dailyRecommend.caste != null &&
                      dailyRecommend.caste != '') ...[
                    _buildInfoChip(dailyRecommend.caste!),
                    const SizedBox(width: 8),
                  ],
                  if (dailyRecommend.state != null &&
                      dailyRecommend.state != '' &&
                      dailyRecommend.city != null &&
                      dailyRecommend.city != '') ...[
                    _buildInfoChip(
                        '${dailyRecommend.city},${dailyRecommend.state!}'),
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
