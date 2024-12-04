import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class PrivacyVideoChatScreen extends StatefulWidget {
  const PrivacyVideoChatScreen({super.key});

  @override
  _PrivacyVideoChatScreenState createState() => _PrivacyVideoChatScreenState();
}

class _PrivacyVideoChatScreenState extends State<PrivacyVideoChatScreen> {
  String _videoChatVisibility = 'All Premium Numbers';

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
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.headingTextColor),
        ),
        title: const Text('Privacy Settings',
            style: AppTextStyles.headingTextstyle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Video Chat',
                style: AppTextStyles.spanTextStyle
                    .copyWith(color: AppColors.headingTextColor, fontSize: 18)),
            const SizedBox(height: 8.0),
            Column(
              children: [
                _customRadioOption(
                  title: 'All Premium Numbers',
                  value: 'All Premium Numbers',
                  recommended: true,
                ),
                _customRadioOption(
                  title:
                      'Premium Members I Have Contacted/ Responded/ Shortlisted',
                  value:
                      'Premium Members I Have Contacted/ Responded/ Shortlisted',
                  recommended: false,
                ),
                _customRadioOption(
                  title: 'No One (You Won\'t Be Receiving Video Calls)',
                  value: 'No One (You Won\'t Be Receiving Video Calls)',
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
            _videoChatVisibility = value;
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
              groupValue: _videoChatVisibility,
              onChanged: (value) {
                setState(() {
                  _videoChatVisibility = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
