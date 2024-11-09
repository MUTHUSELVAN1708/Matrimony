import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/profile/profile.dart';

import '../helper/nav_helper.dart';
import 'model/menu_item_profile.dart';

class ProfileMainScreen extends StatelessWidget {
  const ProfileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 10,),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl:
                  "https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?q=80&w=1687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.person),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Priyanka',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'M11063971',
                style: TextStyle(
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
                onPressed: () {},
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
        icon: 'assets/add_icon.svg',
        title: 'Edit Profile',
        onTap: () {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: const EditProfileScreen(),
          );
        },
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Edit Preference',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Verify Your Profile',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Daily Recommendations',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Your Chats',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Your Calls',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Settings',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Help',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Feedback',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Success Stories',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'More',
        onTap: () {},
      ),
      MenuItem(
        icon: 'assets/add_icon.svg',
        title: 'Logout',
        onTap: () {},
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
