import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart'; // The existing NotificationScreen can be used as it is

class Notification2Screen extends StatelessWidget {
  const Notification2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationTile(notification: notifications[index]);
          },
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final NotificationItem notification;

  const NotificationTile({
    Key? key,
    required this.notification,
  }) : super(key: key);

  // Method to get a darker shade of the background color for the left border
  Color getDarkerShade(Color color) {
    return HSLColor.fromColor(color)
        .withLightness(
            (HSLColor.fromColor(color).lightness - 0.3).clamp(0.0, 1.0))
        .toColor();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: notification.backgroundColor,
        borderRadius: BorderRadius.circular(15), // Add border radius
        border: Border(
          left: BorderSide(
            color: getDarkerShade(notification
                .backgroundColor), // Left border color based on background
            width: 5, // Set the thickness for the left border
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // Add a slight shadow for a raised effect
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(notification.profileImage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.name,
                  style: AppTextStyles.headingTextstyle.copyWith(
                      fontSize: 18,
                      color: getDarkerShade(notification.backgroundColor)),
                ),
                Text(
                  notification.message,
                  style: AppTextStyles.spanTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItem {
  final String name;
  final String message;
  final String profileImage;
  final Color backgroundColor;

  NotificationItem({
    required this.name,
    required this.message,
    required this.profileImage,
    required this.backgroundColor,
  });
}

// Sample notification data
final List<NotificationItem> notifications = [
  NotificationItem(
    name: 'Rose',
    message: 'She Viewed Your Profile.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.lightBlue.shade50,
  ),
  NotificationItem(
    name: 'Rose',
    message: 'She Read Your Interest.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.pink.shade50,
  ),
  NotificationItem(
    name: 'Rose',
    message: 'She Accepted Your Interest.Take The Next Step,Contact Directly.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.orange.shade50,
  ),
  NotificationItem(
    name: 'Rose',
    message: 'She Read Your Interest.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.pink.shade50,
  ),
  NotificationItem(
    name: 'Rose',
    message: 'She Read Your Interest.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.lightGreen.shade50,
  ),
  NotificationItem(
    name: 'Rose',
    message: 'She Accepted Your Interest.Take The Next Step,Contact Directly.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.lightBlue.shade50,
  ),
  NotificationItem(
    name: 'Rose',
    message: 'She Read Your Interest.',
    profileImage: 'assets/image/image3.png',
    backgroundColor: Colors.blue.shade50,
  ),
];
