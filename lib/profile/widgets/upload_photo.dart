import 'package:flutter/material.dart';

class UploadPhotoWidget extends StatelessWidget {
  const UploadPhotoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
           Text(
            'Put a face to your profile',
            style: TextStyle(
              color: Colors.black54, // Red color matching design
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          // Upload Photo Button
          Container(
            height: 32, // Fixed height for the button
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE52938), // Red color matching design
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