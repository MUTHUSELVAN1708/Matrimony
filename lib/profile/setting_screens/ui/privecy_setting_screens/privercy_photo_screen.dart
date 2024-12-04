import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_upload_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class PrivacyPhotoScreen extends ConsumerStatefulWidget {
  const PrivacyPhotoScreen({super.key});

  @override
  _PrivacyPhotoScreenState createState() => _PrivacyPhotoScreenState();
}

class _PrivacyPhotoScreenState extends ConsumerState<PrivacyPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final getImageApiProviderState = ref.watch(getImageApiProvider);
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Photo',
                  style: AppTextStyles.spanTextStyle.copyWith(
                      color: AppColors.headingTextColor, fontSize: 20),
                )),
            const SizedBox(height: 8.0),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(height: 20),
            Text('Photos Are The First Thing Matches Look For In A Profile',
                style: AppTextStyles.spanTextStyle.copyWith(fontSize: 16)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: RegisterUserPhotoUploadScreen(
                      isEditPhoto: true,
                      images: getImageApiProviderState.data?.images,
                      onPop: (value) {}),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: AppColors.primaryButtonColor,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Add Photo',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
