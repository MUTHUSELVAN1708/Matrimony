import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/decision_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/delete_profile_already_married_screen.dart';

class DeleteProfileScreen extends ConsumerWidget {
  const DeleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAccountState = ref.watch(deleteAccountProvider);

    void updateReason(String reason) {
      ref.read(deleteAccountProvider.notifier).updateReason(reason);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
        ),
        title: const Text('Delete Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryButtonColor)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please Choose A Reason For Profile Deletion',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16.0),
            ...['Already Married', 'Getting Married Soon', 'Other Reason'].map(
              (reason) => RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.headingTextColor,
                title: Text(reason, style: AppTextStyles.spanTextStyle),
                value: reason,
                groupValue: deleteAccountState.reason,
                onChanged: (value) {
                  updateReason(value!);
                },
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (deleteAccountState.reason.isEmpty) {
                    CustomSnackBar.show(
                        context: context,
                        message: 'Please Select Reason!',
                        isError: true);
                  } else if (deleteAccountState.reason == 'Already Married' ||
                      deleteAccountState.reason == 'Getting Married Soon') {
                    ref.read(deleteAccountProvider.notifier).clearReason();
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: const DeleteProfileAlreadyMarriedScreen(),
                    );
                  } else {
                    ref.read(deleteAccountProvider.notifier).clearReason();
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: const DecisionScreen(),
                    );
                  }
                },
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
