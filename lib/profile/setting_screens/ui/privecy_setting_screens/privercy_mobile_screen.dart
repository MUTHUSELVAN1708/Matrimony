import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PrivacyMobileScreen extends StatefulWidget {
  const PrivacyMobileScreen({super.key});

  @override
  _PrivacyMobileScreenState createState() => _PrivacyMobileScreenState();
}

class _PrivacyMobileScreenState extends State<PrivacyMobileScreen> {
  String _mobileNumberVisibility = 'all paid numbers';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mobile number',
                style: AppTextStyles.spanTextStyle
                    .copyWith(color: AppColors.headingTextColor, fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Show Mobile Number Only to :',
              style:
                  AppTextStyles.headingTextstyle.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            Column(
              children: [
                _customRadioOption(
                  title: 'All Paid Numbers',
                  value: 'all paid numbers',
                  recommended: true,
                ),
                _customRadioOption(
                  title: 'Paid Members Whom I Contacted/Responded To',
                  value: 'paid members whom i contacted/responded to',
                  recommended: false,
                ),
                _customRadioOption(
                  title: 'Don’t Show Phone Number(Hide Contact Details)',
                  value: 'don’t show phone number(hide contact details)',
                  recommended: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customRadioOption(
      {required String title,
      required String value,
      bool recommended = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _mobileNumberVisibility = value;
          });
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.spanTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  if (recommended) ...[
                    const SizedBox(width: 50),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        border: Border.all(color: AppColors.headingTextColor),
                      ),
                      child: Text(
                        'RECOMMENDED',
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Radio<String>(
              activeColor: AppColors.headingTextColor,
              value: value,
              groupValue: _mobileNumberVisibility,
              onChanged: (value) {
                setState(() {
                  _mobileNumberVisibility = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
