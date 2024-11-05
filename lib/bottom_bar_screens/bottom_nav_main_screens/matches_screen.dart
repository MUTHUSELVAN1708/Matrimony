import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

import 'inbox_screens/screens/allMatchesViewScreen.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '3 Matches',
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
              itemCount: matchesList.length,
              itemBuilder: (context, index) {
                return MatchCard(match: matchesList[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class MatchCard extends StatelessWidget {
  final Match match;

  const MatchCard({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          // Background image
          ClipRRect(
            borderRadius:
                BorderRadius.circular(4), // Adjust radius for the card
            child: match.imageUrl.isNotEmpty
                ? Image.asset(
                    match.imageUrl,
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
              color: Colors.black.withOpacity(0.3), // Black transparent overlay
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          // Content of the card
          Positioned(
            bottom: 50,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  match.name,
                  style: AppTextStyles.headingTextstyle.copyWith(
                      color: AppColors.primaryButtonTextColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  match.id,
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
                    builder: (context) => const AllMatchesScreen(),
                  ),
                );
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
                  _buildInfoChip(match.caste),
                  const SizedBox(width: 8),
                  _buildInfoChip(match.location),
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
      ),
    );
  }
}

class Match {
  final String name;
  final String id;
  final String imageUrl;
  final int age;
  final String caste;
  final String location;

  Match({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.age,
    required this.caste,
    required this.location,
  });
}

final List<Match> matchesList = [
  Match(
    name: 'Divya Sree',
    id: '#d23543245',
    imageUrl: 'assets/image/image1.png',
    age: 20,
    caste: 'Caste',
    location: 'Tirunelveli',
  ),
  Match(
    name: 'Ragavarshini',
    id: '#d23543245',
    imageUrl: 'assets/image/image2.png',
    age: 20,
    caste: 'Caste',
    location: 'Tirunelveli',
  ),
  Match(
    name: 'Ragavarshini',
    id: '#d23543245',
    imageUrl: 'assets/image/image3.png',
    age: 20,
    caste: 'Caste',
    location: 'Tirunelveli',
  ),
];
