import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/payment_plans/plan_upgrade_screen.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/edit_partner_preferences/screens/edit_partner_preferences_main_screen.dart';
import 'package:matrimony/profile/faq_screen/faq_screen.dart';
import 'package:matrimony/profile/help_screens/ui/help_screen.dart';
import 'package:matrimony/profile/profile.dart';
import 'package:matrimony/profile/setting_screens/ui/setting_screen.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_proof_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

import '../helper/nav_helper.dart';
import 'model/menu_item_profile.dart';

class ProfileMainScreen extends ConsumerStatefulWidget {
  const ProfileMainScreen({super.key});

  @override
  ConsumerState<ProfileMainScreen> createState() => _ProfileMainScreenState();
}

class _ProfileMainScreenState extends ConsumerState<ProfileMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _buildProfileHeader(),
          _buildUpgradeCard(),
          Expanded(
            child: ListView(
              children: _buildMenuItems(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: getImageApiProviderState.error != null ||
                    getImageApiProviderState.data == null ||
                    getImageApiProviderState.data!.images.isEmpty
                ? const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/image/emptyProfile.png'),
                  )
                : CircleAvatar(
                    backgroundImage: MemoryImage(
                      base64Decode(
                        getImageApiProviderState.data!.images[0]
                            .toString()
                            .replaceAll('\n', '')
                            .replaceAll('\r', ''),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getImageApiProviderState.data?.name ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                getImageApiProviderState.data?.uniqueId ?? '',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpgradeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get An Exclusive ₹1500 Off On 3 Month Gold',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PlanUpgradeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Upgrade Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final menuItems = [
      MenuItem(
        icon: 'assets/editprofile.svg',
        title: 'Edit Profile',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: const EditProfileScreen(),
          );
        },
      ),
      MenuItem(
        icon: 'assets/editpreference.svg',
        title: 'Edit Preference',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: const EditPartnerPreferencesMainScreen(),
          );
        },
      ),
      MenuItem(
        icon: 'assets/verifyprofile.svg',
        title: 'Verify Your Profile',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: RegisterUserGovernmentProof(
              title: 'update',
            ),
          );
        },
      ),
      MenuItem(
        icon: 'assets/dailyrecommend.svg',
        title: 'Daily Recommendations',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/yourchats.svg',
        title: 'Your Chats',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/yourcalls.svg',
        title: 'Your Calls',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/settings.svg',
        title: 'Settings',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: const SettingScreen(),
          );
        },
      ),
      MenuItem(
        icon: 'assets/help.svg',
        title: 'Help',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: HelpScreen(),
          );
        },
      ),
      MenuItem(
        icon: 'assets/feedback.svg',
        title: 'Feedback',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/successstories.svg',
        title: 'Success Stories',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/more.svg',
        title: 'More',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: FAQScreen(),
          );
        },
      ),
      MenuItem(
        icon: 'assets/logout.svg',
        title: 'Logout',
        onTap: () async {
          await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: AppColors.black, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.grey)),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final navigator = Navigator.of(context);
                            await SharedPrefHelper.removeUser();
                            if (!context.mounted) return;
                            CustomSnackBar.show(
                              context: context,
                              message: 'Logged Out Successfully.',
                              isError: false,
                            );
                            navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.primaryButtonColor,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.grey)),
                            child: const Center(
                              child: Text(
                                'Logout',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    ];

    return menuItems.map((item) => _buildMenuItem(item)).toList();
  }

  Widget _buildMenuItem(MenuItem item) => InkWell(
        onTap: item.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Row(
            children: [
              SvgPicture.asset(
                item.icon,
                width: 24,
                height: 24,
                color: AppColors.primaryButtonColor,
              ),
              const SizedBox(width: 16),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      );
}
