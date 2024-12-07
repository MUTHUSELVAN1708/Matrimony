import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/bride_details_screen.dart';
import 'package:matrimony/profile/setting_screens/ui/account_setting_screens/site_name_screen.dart';

class DeleteProfileAlreadyMarriedScreen extends ConsumerWidget {
  const DeleteProfileAlreadyMarriedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAccountState = ref.watch(deleteAccountProvider);

    void updateReason(String reason) {
      ref.read(deleteAccountProvider.notifier).updateAlreadyMarried(reason);
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
              'Congratulations!',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryButtonColor),
            ),
            const Text(
              'We are happy to know that you\'ve met your life partner.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16.0),
            ...[
              'Aha Thirumanam',
              'Other Matrimonal Site',
              'Offline/Other Source'
            ].map(
              (reason) => RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.headingTextColor,
                title: Text(reason, style: AppTextStyles.spanTextStyle),
                value: reason,
                groupValue: deleteAccountState.alreadyMarried,
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
                  if (deleteAccountState.alreadyMarried.isEmpty) {
                    CustomSnackBar.show(
                        context: context,
                        message: 'Please Select Site or Source!',
                        isError: true);
                    return;
                  }
                  if (deleteAccountState.alreadyMarried != 'Aha Thirumanam') {
                    ref
                        .read(deleteAccountProvider.notifier)
                        .clearAhathirumanam();
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: SiteNameScreen(
                        isSite: deleteAccountState.alreadyMarried ==
                                'Other Matrimonal Site'
                            ? true
                            : null,
                      ),
                    );
                  } else {
                    ref
                        .read(deleteAccountProvider.notifier)
                        .clearAhathirumanam();
                    NavigationHelper.slideNavigateTo(
                      context: context,
                      screen: const BrideDetailsScreen(),
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
