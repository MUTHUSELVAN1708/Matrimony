import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PrivacySettingScreen extends StatefulWidget {
  @override
  _PrivacySettingScreenState createState() => _PrivacySettingScreenState();
}

class _PrivacySettingScreenState extends State<PrivacySettingScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSettingTile('Mobile Number', onTap: _handleMobileNumberTap),
            _buildSettingTile('Photo', onTap: _handlePhotoTap),
            _buildSettingTile('Video Profile', onTap: _handleVideoProfileTap),
            _buildSettingTile('Horoscope', onTap: _handleHoroscopeTap),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(
    String title, {
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: AppTextStyles.spanTextStyle
            .copyWith(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }

  void _handleMobileNumberTap() {
    // Handle mobile number setting
  }

  void _handlePhotoTap() {
    // Handle photo setting
  }

  void _handleVideoProfileTap() {
    // Handle video profile setting
  }

  void _handleHoroscopeTap() {
    // Handle horoscope setting
  }
}
