import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PhotoUpdateHelpScreen extends StatelessWidget {
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
                        color: AppColors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please tap on the button below to add your photos',
                    style: AppTextStyles.spanTextStyle,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add edit profile functionality
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      minimumSize: const Size(120, 40),
                    ),
                    child: const Text('Add Photo'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    '*Please note that it might take a maximum of 1 hour for your photos to be visible to your matches',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '*Please make sure that in your primary photo you wear no sunglasses and do not upload a group photo. Please make sure you upload a clear and bright picture.',
                    style: AppTextStyles.spanTextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
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
                        label: Text(
                          'Call Us',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Add chat functionality
                        },
                        icon: Icon(Icons.chat, color: Colors.red),
                        label: Text(
                          'Chat Now',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red),
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
}
