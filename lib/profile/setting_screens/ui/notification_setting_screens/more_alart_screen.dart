import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';

class MoreAlertsScreen extends StatefulWidget {
  const MoreAlertsScreen({Key? key}) : super(key: key);

  @override
  State<MoreAlertsScreen> createState() => _MoreAlertsScreenState();
}

class _MoreAlertsScreenState extends State<MoreAlertsScreen> {
  // State variables for radio button selections
  String expressInterestNotification = 'instant';
  String personalizedMessagesNotification = 'instant';
  String profileViewsNotification = 'daily';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'More Alerts',
          style: AppTextStyles.headingTextstyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose how often you receive notifications about any member\'s activity on your profile',
                style: AppTextStyles.spanTextStyle,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Express Interest'),
              _buildSubtitle('When members send an interest'),
              _buildNotificationOptions(
                value: expressInterestNotification,
                onChanged: (value) {
                  setState(() {
                    expressInterestNotification = value!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Personalized Messages Section
              _buildSectionTitle('Personalised Messages'),
              _buildSubtitle('When Premium Members Send Messages'),
              _buildNotificationOptions(
                value: personalizedMessagesNotification,
                onChanged: (value) {
                  setState(() {
                    personalizedMessagesNotification = value!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Profile Views Section
              _buildSectionTitle('Profile Views'),
              _buildSubtitle('When Members View Your Profile'),
              _buildNotificationOptions(
                value: profileViewsNotification,
                onChanged: (value) {
                  setState(() {
                    profileViewsNotification = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.spanTextStyle
          .copyWith(color: Colors.black, fontSize: 18),
    );
  }

  Widget _buildSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Text(
        text,
        style: AppTextStyles.spanTextStyle,
      ),
    );
  }

  Widget _buildNotificationOptions({
    required String value,
    required void Function(String?) onChanged,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Get Notified Instantly'),
          trailing: Radio<String>(
            value: 'instant',
            groupValue: value,
            onChanged: onChanged,
            activeColor: Colors.red,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Get One Notification Daily For All',
            maxLines: 2,
          ),
          trailing: Radio<String>(
            value: 'daily',
            groupValue: value,
            onChanged: onChanged,
            activeColor: Colors.red,
          ),
        ),
      ],
    );
  }
}
