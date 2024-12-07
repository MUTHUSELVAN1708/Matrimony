import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/profile/setting_screens/riverpod/delete_account_state.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThanksScreen extends ConsumerStatefulWidget {
  const ThanksScreen({super.key});

  @override
  SuccessStoryScreenState createState() => SuccessStoryScreenState();
}

class SuccessStoryScreenState extends ConsumerState<ThanksScreen> {
  @override
  void initState() {
    super.initState();
    navigateAfterDelay();
  }

  Future<void> navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) {
      ref.read(deleteAccountProvider.notifier).clearState();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Thank you for sharing your Story with us!',
                style: TextStyle(
                    color: AppColors.primaryButtonColor, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/image/giftbox.png',
                height: 300,
              ),
              const SizedBox(height: 20),
              Text(
                '${ref.read(userManagementProvider).userDetails.name} & ${ref.read(deleteAccountProvider).name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryButtonColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
