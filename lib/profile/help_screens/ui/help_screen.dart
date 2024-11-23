import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/help_screens/ui/contact_update_help_screen.dart';
import 'package:matrimony/profile/help_screens/ui/horoscope_update_help_screen.dart';
import 'package:matrimony/profile/help_screens/ui/manage_photos_update_help_screen.dart';
import 'package:matrimony/profile/help_screens/ui/photo_update_help_screen.dart';
import 'package:matrimony/profile/help_screens/ui/profile_update_help_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
          'Help centre',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: ProfileUpdateHelpScreen(),
                );
              },
              leading: Text(
                'I want to edit my profile',
                style: AppTextStyles.spanTextStyle
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: ContactUpdateHelpScreen(),
                );
              },
              leading: Text(
                'I want to update my contact details',
                style: AppTextStyles.spanTextStyle
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: PhotoUpdateHelpScreen(),
                );
              },
              leading: Text(
                'I want to add my photos',
                style: AppTextStyles.spanTextStyle
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: ManagePhotosUpdateScreen(),
                );
              },
              leading: Text(
                'Uploaded photos are not visible in my profile',
                style: AppTextStyles.spanTextStyle
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: HoroScopeUpdateHelpScreen(),
                );
              },
              leading: Text(
                'I want to add my Horoscope',
                style: AppTextStyles.spanTextStyle
                    .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
