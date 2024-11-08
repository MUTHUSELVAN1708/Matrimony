import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/profile/widgets/upload_photo.dart';

import '../common/colors.dart';
import '../edit/profile/basic_details.dart';
import '../edit/profile/edit_contact_screen.dart';
import '../helper/nav_helper.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _showProfileElements = true;

  void _updateProfileElementsVisibility(bool show) {
    setState(() {
      _showProfileElements = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final heightQuery = MediaQuery.of(context).size.height;
    final widthQuery = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with fade effect
          Container(
            height: double.infinity,
            margin: EdgeInsets.only(bottom: heightQuery * 0.2),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/initialimage.png'),
                // Use your image path here
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          if (_showProfileElements)
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                // Profile Card
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: heightQuery * 0.28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        if (_showProfileElements)
                          // Profile Image and Title
                          Positioned(
                            top: -(widthQuery * 0.17),
                            left: 0,
                            right: 0,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  // Action to update profile image
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: widthQuery * 0.13,
                                          left: widthQuery * 0.02),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.person, size: 30),
                                          SizedBox(width: 8),
                                          Text(
                                            'Bio-Data',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: (widthQuery / 4) -
                                          (widthQuery * 0.15),
                                    ),
                                    Container(
                                      width: widthQuery * 0.32,
                                      height: widthQuery * 0.32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: AppColors.primaryButtonColor,
                                          width: 2.0,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: SvgPicture.asset(
                                          'assets/profileIcon.svg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        // Content
                        Padding(
                          padding: EdgeInsets.only(top: heightQuery * 0.15),
                          child: Column(
                            children: [
                              // Persistent action buttons
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildActionButton(
                                        'Edit Contact', () {}, context),
                                    _buildActionButton(
                                        'Add Photos', () {}, context),
                                    _buildActionButton(
                                        'Add Horoscope', () {}, context),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: UploadPhotoWidget(),
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          'Personal Information',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ..._buildMenuItems(widthQuery),
                                      _buildPreferencesSection(widthQuery),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String text, VoidCallback onTap, BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // if (text == 'Edit Contact') {
        //   _updateProfileElementsVisibility(false);
        //   NavigationHelper.slideNavigateTo(
        //     context: context,
        //     screen: EditContactScreen(onPop: (value) {
        //       if (value as bool) {
        //         _updateProfileElementsVisibility(true);
        //       }
        //     }),
        //   );
        // } else {
        //   onTap();
        // }
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade200),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black45,
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(double widthQuery) {
    final menuItems = [
      {
        'title': 'A Few Words About You',
        'color': Colors.orange,
        'icon': 'assets/pen.svg'
      },
      {
        'title': 'Basic Details',
        'color': Colors.blue,
        'icon': 'assets/File Text.svg'
      },
      {
        'title': 'Religious Information',
        'color': Colors.brown,
        'icon': 'assets/Notebook Minimalistic.svg'
      },
      {
        'title': 'Professional Information',
        'color': Colors.orange,
        'icon': 'assets/Square Academic Cap.svg'
      },
      {
        'title': 'Location',
        'color': Colors.blue,
        'icon': 'assets/Map Point.svg'
      },
      {
        'title': 'Family Details',
        'color': Colors.pink,
        'icon': 'assets/Users Group Two Rounded.svg'
      },
      // {'title': 'About Our Family', 'color': Colors.purple,'icon': Colors.orange},
      {
        'title': 'Hobbies & Interests',
        'color': Colors.green,
        'icon': 'assets/Headphones Round Sound.svg'
      },
    ];

    return menuItems.map((item) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildMenuItem(
          icon: item['icon'] as String,
          title: item['title'] as String,
          color: item['color'] as Color,
        ),
      );
    }).toList();
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade100),
        // Gray border
        borderRadius: BorderRadius.circular(8),
        // Rounded corners for the border
        boxShadow: [
          BoxShadow(
            color: Colors.white70.withOpacity(0.3),
            // Light gray shadow for elevation
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // Shadow direction
          ),
        ],
      ),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          height: 24,
          color: color,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: SvgPicture.asset(
          'assets/editIcon.svg',
          height: 20,
          color: Colors.black54,
        ),
        onTap: () {
          if (title == 'Basic Details') {
            _updateProfileElementsVisibility(false);
            NavigationHelper.slideNavigateTo(
              context: context,
              screen: EditBasicDetailScreen(onPop: (value) {
                if (value as bool) {
                  _updateProfileElementsVisibility(true);
                }
              }),
            );
          }
        },
      ),
    );
  }

  Widget _buildPreferencesSection(double widthQuery) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100),
          // Gray border
          borderRadius: BorderRadius.circular(8),
          // Rounded corners for the border
          boxShadow: [
            BoxShadow(
              color: Colors.white70.withOpacity(0.3),
              // Light gray shadow for elevation
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 2), // Shadow direction
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Edit Your Partner Preferences To Get Relevant Matches',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  width: widthQuery * 0.5,
                  height: 32, // Fixed height for the button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE52938),
                      // Red color matching design
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text('Edit Preferences'),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
