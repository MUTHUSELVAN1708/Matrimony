import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/help_screens/ui/related_questions_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_upload_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class PhotoUpdateHelpScreen extends ConsumerWidget {
  const PhotoUpdateHelpScreen({super.key});

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To Add Photos',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please Tap On The Button Below To Add Your Photos',
                    style: AppTextStyles.spanTextStyle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      NavigationHelper.slideNavigateTo(
                        context: context,
                        screen: RegisterUserPhotoUploadScreen(
                            isEditPhoto: true,
                            images: getImageApiProviderState.data?.images,
                            onPop: (value) {}),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primaryButtonColor,
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text(
                      'Add Photo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    '* Please note that it might take a maximum of 1 hour for your photos to be visible to your matches',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    '* Please make sure that in your primary photo you wear no sunglasses and do not upload a group photo. Please make sure you upload a clear and bright picture.',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
          const RelatedQuestionsScreen(),
        ],
      ),
    );
  }
}
