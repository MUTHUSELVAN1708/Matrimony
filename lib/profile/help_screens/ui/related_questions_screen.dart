import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/edit/profile/edit_contact_screen.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/help_screens/ui/edit_conatct_screen.dart';
import 'package:matrimony/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class RelatedQuestionsScreen extends StatelessWidget {
  const RelatedQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20),
          ),
          const SizedBox(height: 16),
          _buildListTile('I Want To Edit My Profile', true, context),
          _buildListTile('I Want To Update My Contact Details', false, context),
          const SizedBox(height: 16),
          Text(
            "Still Can't Find What You're Looking For? Don't Worry We're Here To Help",
            style: AppTextStyles.spanTextStyle
                .copyWith(fontWeight: FontWeight.w500, color: AppColors.black),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _makePhoneCall('+918754712376');
                  },
                  icon: const Icon(Icons.phone,
                      color: AppColors.primaryButtonColor),
                  label: const Text(
                    'Call Us',
                    style: TextStyle(
                        color: AppColors.primaryButtonColor, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryButtonColor),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    _sendEmail('info@ahathirumanam.com');
                  },
                  icon: const Icon(Icons.email_outlined,
                      color: AppColors.primaryButtonColor),
                  label: const Text(
                    'Email Us',
                    style: TextStyle(
                        color: AppColors.primaryButtonColor, fontSize: 16),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryButtonColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, bool isProfile, BuildContext context) {
    return ListTile(
      title: Text(title, style: AppTextStyles.spanTextStyle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        if (isProfile) {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: const EditProfileScreen(),
          );
        } else {
          NavigationHelper.slideNavigateTo(
            context: context,
            screen: const EditConatctScreen(),
          );
        }
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneUri';
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
