import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/help_screens/ui/related_questions_screen.dart';
import 'package:matrimony/profile/profile.dart';

class ProfileUpdateHelpScreen extends StatelessWidget {
  const ProfileUpdateHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: AppTextStyles.headingTextstyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.headingTextColor,
          ),
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To Edit/ Update Profile',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please Tap On The Button Below To Edit/Update Your Profile',
                    style: AppTextStyles.spanTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      NavigationHelper.slideNavigateTo(
                        context: context,
                        screen: const EditProfileScreen(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryButtonColor,
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const RelatedQuestionsScreen(),
        ],
      ),
    );
  }
}
