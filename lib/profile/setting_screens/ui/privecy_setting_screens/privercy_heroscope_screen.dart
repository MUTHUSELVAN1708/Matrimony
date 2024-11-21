import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PrivacyHeroScopeScreen extends StatefulWidget {
  @override
  _PrivacyHeroScopeScreenState createState() => _PrivacyHeroScopeScreenState();
}

class _PrivacyHeroScopeScreenState extends State<PrivacyHeroScopeScreen> {
  String _mobileNumberVisibility = 'All Paid Numbers';
  bool _showPhoneNumber = false;

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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Horoscope',
                  style: AppTextStyles.spanTextStyle
                      .copyWith(color: AppColors.headingTextColor),
                )),
            const SizedBox(height: 8.0),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            const SizedBox(height: 20),
            const Text('find profiles matching your horoscope',
                style: AppTextStyles.spanTextStyle),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: ElevatedButton(
                  style: AppTextStyles.primaryButtonstyle,
                  onPressed: () {},
                  child: const Text(
                    'Add Horoscope',
                    style: AppTextStyles.primarybuttonText,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
