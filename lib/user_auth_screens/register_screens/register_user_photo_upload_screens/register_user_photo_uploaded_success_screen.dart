import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_upload_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_proof_screen.dart';

class RegisterUserPhotoUploadedSuccessScreen extends StatelessWidget {
  const RegisterUserPhotoUploadedSuccessScreen({super.key});

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
                'Upload Success',
                style: AppTextStyles.headingTextstyle
                    .copyWith(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              const Text(
                'your photos are getting validated as we speak. it may take up to 1 hour.we will notify you once it’s done.',
                textAlign: TextAlign.center,
                style: AppTextStyles.spanTextStyle,
              ),
              const SizedBox(height: 100),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => RegisterUserGovernmentProof(),
                    ));
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
