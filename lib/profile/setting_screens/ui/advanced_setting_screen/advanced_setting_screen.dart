import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/ui/advanced_setting_screen/block_list_view_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/advanced_setting_screen/ignore_lists_screen.dart';

class AdvancedSettingScreen extends StatefulWidget {
  @override
  _AdvancedSettingScreenState createState() => _AdvancedSettingScreenState();
}

class _AdvancedSettingScreenState extends State<AdvancedSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.headingTextColor,
            )),
        centerTitle: true,
        title: const Text(
          'Advanced Settings',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: const BlockListScreen(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Row(
                  children: [
                    CustomSvg(name: 'block_list'),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Blocked Profiles',
                      style: AppTextStyles.spanTextStyle,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: const IgnoreListScreen(),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: const Row(
                  children: [
                    CustomSvg(name: 'block_list'),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Profiles you didn\'t want to see again',
                      style: AppTextStyles.spanTextStyle,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
