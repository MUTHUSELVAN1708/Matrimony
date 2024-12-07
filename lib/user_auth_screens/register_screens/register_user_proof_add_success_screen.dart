import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/partner_basic_preference_screen.dart';

class RegisterUserGovernmentProofSuccessScreen extends StatelessWidget {
  const RegisterUserGovernmentProofSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Align(
              //   alignment: Alignment.topRight,
              //   child: IconButton(
              //     icon: const Icon(Icons.close, color: Colors.grey),
              //     onPressed: () => Navigator.of(context).pop(),
              //   ),
              // ),

              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                height: MediaQuery.of(context).size.width * 0.50,
                child: SvgPicture.asset(
                  'assets/successcircle.svg',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Upload Success.',
                style: AppTextStyles.headingTextstyle
                    .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your profile has gotten created! Your search for a long-term relationship starts now!',
                textAlign: TextAlign.center,
                style: AppTextStyles.spanTextStyle,
              ),
              const SizedBox(height: 100),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RegisterPartnerBasicPreferenceScreen()),
                      (route) => false,
                    );
                  },
                  style: AppTextStyles.primaryButtonstyle,
                  child: const Text(
                    'Continue',
                    style: AppTextStyles.primarybuttonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
