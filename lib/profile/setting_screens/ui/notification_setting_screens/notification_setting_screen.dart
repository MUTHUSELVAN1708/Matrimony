import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/ui/notification_setting_screens/more_alart_screen.dart';

import 'other_setting_screen.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  // Switch states
  bool phoneNumberViews = false;
  bool requests = true;
  bool shortlists = false;
  bool chats = true;
  bool newMatches = true;
  bool dailyRecommendations = true;
  bool basedOnActivity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.headingTextColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Matches',
                style: AppTextStyles.spanTextStyle
                    .copyWith(fontSize: 18, color: AppColors.headingTextColor),
              ),
              const Text(
                'If you turn these off, you might miss out on our recommendations based on your preferences',
                style: AppTextStyles.spanTextStyle,
              ),
              const SizedBox(height: 20),
              _buildSettingTile(
                'Phone Number Views',
                'when members view your number',
                phoneNumberViews,
                (value) => setState(() => phoneNumberViews = value),
              ),
              _buildSettingTile(
                'Requests',
                'when members request for your information',
                requests,
                (value) => setState(() => requests = value),
              ),
              _buildSettingTile(
                'Shortlists',
                'when members shortlist you',
                shortlists,
                (value) => setState(() => shortlists = value),
              ),
              _buildSettingTile(
                'Chats',
                'when members are online or initiate chat',
                chats,
                (value) => setState(() => chats = value),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: const MoreAlertsScreen(),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0XFFFFE6D1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'More Settings',
                      style: AppTextStyles.primarybuttonText.copyWith(
                        color: const Color(0XFFEF9C56),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Matches',
                style: AppTextStyles.spanTextStyle
                    .copyWith(color: AppColors.headingTextColor, fontSize: 18),
              ),
              const Text(
                'If you turn these off, you might miss out on our recommendations based on your preferences',
                style: AppTextStyles.spanTextStyle,
              ),
              const SizedBox(height: 20),
              _buildSettingTile(
                'New Matches',
                'Everyday',
                newMatches,
                (value) => setState(() => newMatches = value),
              ),
              _buildSettingTile(
                'Daily Recommendations',
                'Everyday',
                dailyRecommendations,
                (value) => setState(() => dailyRecommendations = value),
              ),
              _buildSettingTile(
                'Based On Activity',
                'Get notified about profile similar to the ones you like',
                basedOnActivity,
                (value) => setState(() => basedOnActivity = value),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: OtherSettingScreen(),
                    );
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0XFFFFE6D1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Other Settings',
                      style: AppTextStyles.primarybuttonText.copyWith(
                        color: const Color(0XFFEF9C56),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTextStyles.spanTextStyle
            .copyWith(color: Colors.black, fontSize: 18),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.spanTextStyle,
      ),
      trailing: Transform.scale(
        scale: 0.5,
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.headingTextColor,
        ),
      ),
    );
  }
}
