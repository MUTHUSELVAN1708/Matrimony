import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class ProfileCardStack extends StatefulWidget {
  const ProfileCardStack({super.key});

  @override
  State<ProfileCardStack> createState() => _ProfileCardStackState();
}

class _ProfileCardStackState extends State<ProfileCardStack> {
  int currentIndex = 0;

  final List<Map<String, String>> profiles = [
    {
      'name': 'Ragavan',
      'id': '#id45473547',
      'age': '32 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Mechanical',
      'location': 'Chennai, Tamilnadu',
    },
    {
      'name': 'Muthu',
      'id': '#id45473548',
      'age': '23 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Mechanical',
      'location': 'Chennai, Tamilnadu',
    },
    {
      'name': 'Abinaya',
      'id': '#id45473549',
      'age': '19 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Computer science',
      'location': 'Chennai, Tamilnadu',
    },
    {
      'name': 'Akshaya',
      'id': '#id45473550',
      'age': '19 Years',
      'height': 'Ft: 7 in',
      'education': 'BE, Computer science',
      'location': 'Chennai, Tamilnadu',
    },
  ];

  void nextProfile() {
    if (currentIndex < profiles.length - 1) {
      setState(() {
        currentIndex++;
      });
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
    final currentProfile = profiles[currentIndex];

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
                  GestureDetector(
                    onTap: () {},
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
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 155,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage('assets/image/successimage.png'),
                            // Correct image asset
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: 155,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            currentProfile['name']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            // Apply ellipsis
                            maxLines: 1, // Limit to one line
                          ),
                          Text(
                            currentProfile['id']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['age']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['height']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['education']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            currentProfile['location']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          const SizedBox(height: 5),
                          Container(
                            height: 20,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              'Accept',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: SizedBox(
                      height: 155,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '"He has sent an\ninterest to you"',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '15 Oct 2024',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[500],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 20,
                            width: 98,
                            decoration: BoxDecoration(
                                color: Colors.red.shade700,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              'Decline',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
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
                onTap: currentIndex < profiles.length - 1 ? nextProfile : null,
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
