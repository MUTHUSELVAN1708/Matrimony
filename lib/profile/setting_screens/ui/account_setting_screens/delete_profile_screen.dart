import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class DeleteProfileScreen extends StatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  _DeleteProfileScreenState createState() => _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends State<DeleteProfileScreen> {
  String _selectedReason = '';

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
          'Delete Profile',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please Choose A Reason For Profile Deletion',
              style: AppTextStyles.spanTextStyle
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              activeColor: AppColors.headingTextColor,
              title: const Text('Already Married',
                  style: AppTextStyles.spanTextStyle),
              value: 'Already Married',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value.toString();
                });
              },
            ),
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              activeColor: AppColors.headingTextColor,
              title: const Text('Getting Married Soon',
                  style: AppTextStyles.spanTextStyle),
              value: 'Getting Married Soon',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value.toString();
                });
              },
            ),
            RadioListTile(
              contentPadding: const EdgeInsets.all(0),
              activeColor: AppColors.headingTextColor,
              title: const Text('Other Reason',
                  style: AppTextStyles.spanTextStyle),
              value: 'Other Reason',
              groupValue: _selectedReason,
              onChanged: (value) {
                setState(() {
                  _selectedReason = value.toString();
                });
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: AppTextStyles.primaryButtonstyle,
                child: Text(
                  'Next',
                  style: AppTextStyles.primarybuttonText.copyWith(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
