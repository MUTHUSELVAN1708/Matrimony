import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/help_screens/ui/related_questions_screen.dart';
import 'package:matrimony/user_auth_screens/register_star_details/heroscope_add_details_screen.dart';

class HoroscopeUpdateHelpScreen extends StatelessWidget {
  const HoroscopeUpdateHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'My Horoscope Details',
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
                    'To Edit/ Update Horoscope',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please tap on the button below to add your Horoscope.',
                    style: AppTextStyles.spanTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      NavigationHelper.slideNavigateTo(
                        context: context,
                        screen: HoroscopeAddDetailScreen(onPop: (value) {}),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryButtonColor,
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      'Add horoscope',
                      style: AppTextStyles.primarybuttonText,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // Text(
                  //   'note : it take upto 1 hour for your horoscope to get validated',
                  //   style: AppTextStyles.spanTextStyle.copyWith(
                  //       color: AppColors.black,
                  //       fontSize: 15,
                  //       fontWeight: FontWeight.w500),
                  // ),
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
