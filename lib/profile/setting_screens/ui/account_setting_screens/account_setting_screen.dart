import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/change_password_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/deactivate_account_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/delete_profile_screen.dart';

class AccountSettingScreen extends StatefulWidget {
  @override
  _AccountSettingScreenState createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
          'Account Settings',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: const ChangePasswordScreen(),
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
                      const CustomSvg(name: 'delete_account'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "change password",
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
                _showLogOutConfirmationDialog(context);
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
                      const CustomSvg(name: 'log_out_account'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Logout",
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
                  screen: DeactivateAccountScreen(),
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
                      const CustomSvg(name: 'deactivate_account'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Deactivate/Hide Account",
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
                  screen: DeleteProfileScreen(),
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
                      const CustomSvg(name: 'delete_account'),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Delete Account",
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: Colors.black),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogOutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSvg(
                name: 'successcircle',
                height: 85,
                width: 85,
              ),
              const SizedBox(width: 15),
              Text(
                'Do You Want To Log Out?',
                style: AppTextStyles.headingTextstyle
                    .copyWith(color: Colors.black),
              ),
            ],
          ),
          content: const Text(
            'Are You Sure You Want To Log Out From My App?',
            style: AppTextStyles.spanTextStyle,
          ),
          actions: <Widget>[
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: AppTextStyles.primaryButtonstyle,
                      child: const Text(
                        'Yes',
                        style: AppTextStyles.primarybuttonText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: const Text('No',
                        style: AppTextStyles.primarybuttonText),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
