import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/help_screens/ui/related_questions_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_upload_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class ManagePhotosUpdateScreen extends ConsumerWidget {
  const ManagePhotosUpdateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getImageApiProviderState = ref.watch(getImageApiProvider);
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'If uploaded photos are not visible in your profile, it could be due to any one of the following reasons',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Validation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'All photos involve manual screening which usually takes a maximum of 1 hour to get validated before it is visible.',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Failed During Screening',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Your photos may not have been approved due to any one of the following reasons',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
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
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        NavigationHelper.slideNavigateTo(
                          context: context,
                          screen: RegisterUserPhotoUploadScreen(
                              isEditPhoto: true,
                              images: getImageApiProviderState.data?.images,
                              onPop: (value) {}),
                        );
                      },
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
            const RelatedQuestionsScreen(),
          ],
        ),
      ),
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
