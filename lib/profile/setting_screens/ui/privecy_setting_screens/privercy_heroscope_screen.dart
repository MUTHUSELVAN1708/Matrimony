import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/user_auth_screens/register_star_details/heroscope_add_details_screen.dart';

class PrivacyHeroScopeScreen extends StatefulWidget {
  const PrivacyHeroScopeScreen({super.key});

  @override
  _PrivacyHeroScopeScreenState createState() => _PrivacyHeroScopeScreenState();
}

class _PrivacyHeroScopeScreenState extends State<PrivacyHeroScopeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.headingTextColor,
            )),
        title: const Text(
          'Privacy Settings',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Horoscope',
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: AppColors.headingTextColor, fontSize: 20),
                )),
            const SizedBox(height: 8.0),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(height: 20),
            const Text('Find Profiles Matching Your Horoscope',
                style: AppTextStyles.spanTextStyle),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                    context: context,
                    screen: HoroscopeAddDetailScreen(onPop: (value) {}));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: AppColors.primaryButtonColor,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Add Horoscope',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
