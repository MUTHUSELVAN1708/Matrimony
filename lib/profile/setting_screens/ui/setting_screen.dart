import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/account_setting_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/advanced_setting_screen/advanced_setting_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/privecy_setting_screens/privecy_setting_screen.dart';

import 'notification_setting_screens/notification_setting_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                color: Colors.red,
              )),
          title: const Text(
            'Settings',
            style: AppTextStyles.headingTextstyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  NavigationHelper.slideNavigateTo(
                    context: context,
                    screen: const NotificationSettingScreen(),
                  );
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          offset: Offset(1, 2),
                          blurRadius: 11.1,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CustomSvg(name: 'setting_bell'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Notifications",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: Colors.black),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  NavigationHelper.slideNavigateTo(
                    context: context,
                    screen: PrivacySettingScreen(),
                  );
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          offset: Offset(1, 2),
                          blurRadius: 11.1,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CustomSvg(name: 'setting_lock'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Privacy Settings",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: Colors.black),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  NavigationHelper.slideNavigateTo(
                    context: context,
                    screen: AccountSettingScreen(),
                  );
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x08000000),
                          offset: Offset(1, 2),
                          blurRadius: 11.1,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CustomSvg(name: 'setting_user'),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Account",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: Colors.black),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  NavigationHelper.slideNavigateTo(
                    context: context,
                    screen: AdvancedSettingScreen(),
                  );
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x08000000),
                        offset: Offset(1, 2),
                        blurRadius: 11.1,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CustomSvg(name: 'Setting_line'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Advanced Settings",
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
