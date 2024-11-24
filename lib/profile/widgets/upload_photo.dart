import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_upload_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';

class UploadPhotoWidget extends ConsumerWidget {
  const UploadPhotoWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getImageApiProviderState = ref.watch(getImageApiProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEEBEE), // Very light red background
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // Face Icon
          const Icon(
            Icons.face,
            color: Color(0xFFE52938), // Red color matching design
            size: 20,
          ),
          const SizedBox(width: 8),
          // Text
          const Text(
            'Put a face to your profile',
            style: TextStyle(
              color: Colors.black54, // Red color matching design
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          // Upload Photo Button
          SizedBox(
            height: 32,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterUserPhotoUploadScreen(
                              isEditPhoto: true,
                              images: getImageApiProviderState.data?.images,
                            )));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFE52938), // Red color matching design
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Upload Photo',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
