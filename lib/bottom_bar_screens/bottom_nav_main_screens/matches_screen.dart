import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/all_matches_details_screen.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
  @override
  Widget build(BuildContext context) {
    final allMatchProvider = ref.watch(allMatchesProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${allMatchProvider.allMatchList!.length} Matches',
          textAlign: TextAlign.center,
          style: AppTextStyles.headingTextstyle,
        ),
        Text(
          'Based on your Partner preferences',
          textAlign: TextAlign.center,
          style: AppTextStyles.spanTextStyle.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              itemCount: allMatchProvider.allMatchList!.length,
              itemBuilder: (context, index) {
                final matchingData = allMatchProvider.allMatchList![index];
                return MatchCard(match: matchingData);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  final Matches match;

  const MatchCard({
    Key? key,
    required this.match,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(4), // Adjust radius for the card
            child: match.photos![0].isNotEmpty
                ? Image.memory(
                   base64Decode(match.photos![0]),
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
              borderRadius: BorderRadius.circular(4),
            ),
          ),
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
                  match.id.toString(),
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: AppColors.primaryButtonTextColor, fontSize: 14),
                ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AllMatchesDetailsScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
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
                  _buildInfoChip('Not Working'),
                  const SizedBox(width: 8),
                  _buildInfoChip('${match.age} Years'),
                  const SizedBox(width: 8),
                  _buildInfoChip("match.caste"),
                  const SizedBox(width: 8),
                  _buildInfoChip("match.location"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildInfoChip(String label) {
  return Container(
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
  );
}

}
