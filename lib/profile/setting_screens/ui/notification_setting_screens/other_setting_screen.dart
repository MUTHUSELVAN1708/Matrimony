import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class OtherSettingScreen extends StatefulWidget {
  @override
  State<OtherSettingScreen> createState() => _OtherSettingScreenState();
}

class _OtherSettingScreenState extends State<OtherSettingScreen> {
  bool enableOffer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.headingTextColor,
            )),
        title: const Text(
          'Other Setting',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Premium',
              style: AppTextStyles.headingTextstyle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If you turn these off,you might miss out on offers& promotions',
              style: AppTextStyles.spanTextStyle,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Membership Offers',
              style: AppTextStyles.headingTextstyle
                  .copyWith(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'packages,discounts,etc',
                  style: AppTextStyles.spanTextStyle,
                ),
                Transform.scale(
                  scale:
                      0.5, // You can adjust this value to make the switch smaller or larger
                  child: Switch(
                    value: enableOffer,
                    onChanged: (value) {
                      setState(() {
                        enableOffer = value;
                      });
                    },
                    activeColor: Colors.red, // Color when the switch is on
                    inactiveThumbColor:
                        Colors.grey, // Optional: Set the color when it's off
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
