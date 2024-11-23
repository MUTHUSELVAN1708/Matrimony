import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class ManagePhotosUpdateScreen extends StatelessWidget {
  const ManagePhotosUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'My Profile And Photos',
          style: AppTextStyles.headingTextstyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.headingTextColor,
          ),
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Uploaded Photos Are Not Visible In My Profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'If uploaded photos are not visible in your profile, it could be due to any one of the following reasons',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Validation Section
                  const Text(
                    'Validation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'All photos involve manual screening which usually takes a maximum of 1 hour to get validated before it is visible.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Failed During Screening Section
                  const Text(
                    'Failed During Screening',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your photos may not have been approved due to any one of the following reasons',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Bullet Points
                  ..._buildBulletPoints([
                    'Poor Image Quality',
                    'Bad Lighting',
                    'Photo With Multiple People',
                    'Face Not Visible Due To Sunglasses, Mask.',
                  ]),

                  const SizedBox(height: 16),
                  const Text(
                    'You will receive a mail on your registered mail ID with the exact reason.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Manage Photos Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: AppTextStyles.primaryButtonstyle,
                      child: const Text(
                        'Manage Photos',
                        style: AppTextStyles.primarybuttonText,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Related Questions Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Color(0XffF2F2F2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Related Questions',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16),
                  _buildListTile('I Want To Edit My Profile'),
                  _buildListTile('I Want To Update My Contact Details'),
                  SizedBox(height: 16),
                  Text(
                    "Still Can't Find What You're Looking For? Don't Worry We're Here To Help",
                    style: AppTextStyles.spanTextStyle.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.black),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Add call functionality
                          },
                          icon: Icon(Icons.phone, color: Colors.red),
                          label: const Text(
                            'Call Us',
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Add chat functionality
                          },
                          icon: const Icon(Icons.chat, color: Colors.red),
                          label: const Text(
                            'Chat Now',
                            style: TextStyle(color: Colors.red),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title) {
    return ListTile(
      title: Text(title, style: AppTextStyles.spanTextStyle
          //     .copyWith(
          //     color: AppColors.black
          // ),
          ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        // Add navigation functionality
      },
    );
  }

  List<Widget> _buildBulletPoints(List<String> points) {
    return points.map((point) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                point,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
