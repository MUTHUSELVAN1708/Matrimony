import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PrivacyPhotoScreen extends StatefulWidget {
  @override
  _PrivacyPhotoScreenState createState() => _PrivacyPhotoScreenState();
}

class _PrivacyPhotoScreenState extends State<PrivacyPhotoScreen> {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Photo',
                  style: AppTextStyles.spanTextStyle
                      .copyWith(color: AppColors.headingTextColor),
                )),
            const SizedBox(height: 8.0),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(height: 20),
            const Text(
                'photos are the first thing matches look for in a profile',
                style: AppTextStyles.spanTextStyle),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: ElevatedButton(
                  style: AppTextStyles.primaryButtonstyle,
                  onPressed: () {},
                  child: const Text(
                    'Add Photo',
                    style: AppTextStyles.primarybuttonText,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
