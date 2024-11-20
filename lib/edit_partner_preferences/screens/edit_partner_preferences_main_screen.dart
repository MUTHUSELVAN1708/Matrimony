import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/edit_partner_preferences/screens/edit_preferences_basic_details.dart';
import 'package:matrimony/helper/nav_helper.dart';

class EditPartnerPreferencesMainScreen extends StatefulWidget {
  const EditPartnerPreferencesMainScreen({super.key});

  @override
  State<EditPartnerPreferencesMainScreen> createState() =>
      _EditPartnerPreferencesMainScreenState();
}

class _EditPartnerPreferencesMainScreenState
    extends State<EditPartnerPreferencesMainScreen> {
  bool _showProfileElements = true;

  void _updateProfileElementsVisibility(bool show) {
    setState(() {
      _showProfileElements = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Partner Preferences',
          style: TextStyle(
              color: AppColors.primaryButtonColor,
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text:
                    'Matches Are Recommended To You Based On Your Preferences And Profile Information. To See Matches Exactly Based On Your Preferences, Turn On ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                children: [
                  TextSpan(
                    text: '\'Compulsory\'',
                    style: TextStyle(
                      color: AppColors.primaryButtonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _buildMenuItems(MediaQuery.of(context).size.width),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(double widthQuery) {
    final menuItems = [
      {'title': 'Basic Details', 'color': Colors.blue, 'icon': 'File Text'},
      {
        'title': 'Religious Information',
        'color': Colors.brown,
        'icon': 'Notebook Minimalistic'
      },
      {
        'title': 'Professional Information',
        'color': Colors.orange,
        'icon': 'Square Academic Cap'
      },
      {'title': 'Location', 'color': Colors.blue, 'icon': 'Map Point'},
      {
        'title': 'Hobbies & Interests',
        'color': Colors.green,
        'icon': 'Headphones Round Sound'
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
            offset: const Offset(0, 2), // Shadow direction
          ),
        ],
      ),
      child: ListTile(
        leading: CustomSvg(
          name: icon,
          color: color,
          height: 24,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: const CustomSvg(
          name: 'editIcon',
          color: Colors.black54,
          height: 20,
        ),
        onTap: () {
          if (title == 'Basic Details') {
            _updateProfileElementsVisibility(false);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const EditPartnerPreferenceBasicDetailScreen(
                            // onPop: (value) {
                            //   if (value == 'true') {
                            //     _updateProfileElementsVisibility(true);
                            //   }
                            // },
                            )));
            // NavigationHelper.slideNavigateTo(
            //   context: context,
            //   screen: PartnerPreferenceBasicDetailScreen(
            //     onPop: (value) {
            //       if (value == 'true') {
            //         _updateProfileElementsVisibility(true);
            //       }
            //     },
            //   ),
            // );
          } else if (title == 'Religious Information') {
            // _updateProfileElementsVisibility(false);
            // NavigationHelper.slideNavigateTo(
            //   context: context,
            //   screen: ReligiousDetailsScreen(onPop: (value) {
            //     if (value == 'true') {
            //       _updateProfileElementsVisibility(true);
            //     }
            //   }),
            // );
          } else if (title == 'Professional Information') {
            // _updateProfileElementsVisibility(false);
            // NavigationHelper.slideNavigateTo(
            //   context: context,
            //   screen: ProfessionalInformationDetailsScreen(onPop: (value) {
            //     if (value == 'true') {
            //       _updateProfileElementsVisibility(true);
            //     }
            //   }),
            // );
          } else if (title == 'Location') {
          } else {}
        },
      ),
    );
  }
}
