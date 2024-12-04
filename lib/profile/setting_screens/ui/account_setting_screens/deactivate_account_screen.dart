import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class DeactivateAccountScreen extends StatefulWidget {
  const DeactivateAccountScreen({super.key});

  @override
  _DeactivateAccountScreenState createState() =>
      _DeactivateAccountScreenState();
}

class _DeactivateAccountScreenState extends State<DeactivateAccountScreen> {
  int _selectedDuration = 15;

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
          'Deactivate',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You can hide your profile by deactivating it, during which neither you nor your matches can contact each other',
              style: AppTextStyles.spanTextStyle
                  .copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 16.0),
            Text(
              'How long would you like to keep your profile deactivated?',
              style: AppTextStyles.spanTextStyle
                  .copyWith(color: Colors.black, fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      activeColor: AppColors.headingTextColor,
                      value: 15,
                      groupValue: _selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          _selectedDuration = value as int;
                        });
                      },
                    ),
                    Text(
                      '15 Days',
                      style: AppTextStyles.spanTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Radio(
                      activeColor: AppColors.headingTextColor,
                      value: 30,
                      groupValue: _selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          _selectedDuration = value as int;
                        });
                      },
                    ),
                    Text(
                      '1 Month',
                      style: AppTextStyles.spanTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Spacing between options
                Row(
                  children: [
                    Radio(
                      activeColor: AppColors.headingTextColor,
                      value: 60,
                      groupValue: _selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          _selectedDuration = value as int;
                        });
                      },
                    ),
                    Text(
                      '2 Months',
                      style: AppTextStyles.spanTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 10), // Spacing between options
                Row(
                  children: [
                    Radio(
                      activeColor: AppColors.headingTextColor,
                      value: 90,
                      groupValue: _selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          _selectedDuration = value as int;
                        });
                      },
                    ),
                    Text(
                      '3 Months',
                      style: AppTextStyles.spanTextStyle
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: AppTextStyles.primaryButtonstyle,
                child: const Text(
                  'Deactivate',
                  style: AppTextStyles.primarybuttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
