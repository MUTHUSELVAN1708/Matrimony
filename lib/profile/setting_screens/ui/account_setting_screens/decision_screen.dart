import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DecisionScreen extends ConsumerStatefulWidget {
  const DecisionScreen({super.key});

  @override
  ConsumerState<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends ConsumerState<DecisionScreen> {
  final otherReasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deleteAccountState = ref.watch(deleteAccountProvider);

    void updateDecision(String reason) {
      ref.read(deleteAccountProvider.notifier).updateDecision(reason);
      if (reason != 'Any other reason') {
        otherReasonController.text = '';
      }
    }

    void updateOtherDecision(String reason) {
      ref.read(deleteAccountProvider.notifier).updateOtherDecision(reason);
    }

    return EnhancedLoadingWrapper(
      isLoading: deleteAccountState.isLoading,
      child: Scaffold(
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please Choose A Reason For Deletion',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16.0),
                ...[
                  'Too many calls',
                  'Prefer to search later',
                  'Not getting enough matches',
                  'Any other reason'
                ].map(
                  (reason) => RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.headingTextColor,
                    title: Text(reason, style: AppTextStyles.spanTextStyle),
                    value: reason,
                    groupValue: deleteAccountState.decision,
                    onChanged: (value) {
                      updateDecision(value!);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                if (deleteAccountState.decision == 'Any other reason') ...[
                  TextField(
                    controller: otherReasonController,
                    onChanged: (value) {
                      updateOtherDecision(value);
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter Other Reason',
                      hintStyle: const TextStyle(color: Color(0xFF898989)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (deleteAccountState.isLoading) {
                      } else {
                        if (deleteAccountState.decision == 'Any other reason' &&
                            otherReasonController.text.isEmpty) {
                          CustomSnackBar.show(
                              context: context,
                              message: 'Please Enter Other Reason!',
                              isError: true);
                          return;
                        }
                        if (deleteAccountState.decision.isEmpty) {
                          CustomSnackBar.show(
                              context: context,
                              message: 'Please Select Reason!',
                              isError: true);
                        } else {
                          final result = await ref
                              .read(deleteAccountProvider.notifier)
                              .deleteAccount();
                          if (result) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            if (mounted) {
                              CustomSnackBar.show(
                                  context: context,
                                  message: 'Account Deleted Successfully',
                                  isError: false);
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                                (route) => false,
                              );
                            }
                          } else {
                            CustomSnackBar.show(
                                context: context,
                                message:
                                    'Unable To Delete Account. Please Try Again!',
                                isError: true);
                          }
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: Text(
                      'Delete Account',
                      style: AppTextStyles.primarybuttonText
                          .copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
