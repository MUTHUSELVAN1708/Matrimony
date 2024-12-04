import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/model/search_model.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/filter_screens/riverpod/search_filter_state.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class SearchProfileScreen extends ConsumerStatefulWidget {
  const SearchProfileScreen({super.key});

  @override
  ConsumerState<SearchProfileScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<SearchProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final searchFilterInputState = ref.watch(searchFilterProvider);
    return EnhancedLoadingWrapper(
      isLoading: ref.read(userManagementProvider).isLoadingForPartner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${searchFilterInputState.searchModels.length} Search Results',
            style: const TextStyle(color: AppColors.primaryButtonColor),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.red,
              )),
        ),
        body: searchFilterInputState.searchModels.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context)
                          .copyWith(scrollbars: false),
                      child: ListView.builder(
                        itemCount: searchFilterInputState.searchModels.length,
                        itemBuilder: (context, index) {
                          final searchModel =
                              searchFilterInputState.searchModels[index];
                          return MatchCard(searchModel: searchModel);
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'No Search Results Available!',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
      ),
    );
  }
}

class MatchCard extends ConsumerWidget {
  final SearchModel searchModel;

  const MatchCard({
    super.key,
    required this.searchModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(4), // Adjust radius for the card
            child: searchModel.images![0].isNotEmpty
                ? Image.memory(
                    base64Decode(searchModel.images![0]),
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
                  searchModel.name.toString(),
                  style: AppTextStyles.headingTextstyle.copyWith(
                      color: AppColors.primaryButtonTextColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  '#${searchModel.uniqueId ?? ''}',
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
                      .getPartnerDetails(searchModel.id ?? 0);
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
                  if (searchModel.occupation != null &&
                      searchModel.occupation != '') ...[
                    _buildInfoChip(searchModel.occupation!),
                    const SizedBox(width: 8),
                  ],
                  if (searchModel.age != null) ...[
                    _buildInfoChip('${searchModel.age} Yrs'),
                    const SizedBox(width: 8),
                  ],
                  if (searchModel.caste != null && searchModel.caste != '') ...[
                    _buildInfoChip(searchModel.caste!),
                    const SizedBox(width: 8),
                  ],
                  if (searchModel.state != null &&
                      searchModel.state != '' &&
                      searchModel.city != null &&
                      searchModel.city != '') ...[
                    _buildInfoChip('${searchModel.city},${searchModel.state!}'),
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
