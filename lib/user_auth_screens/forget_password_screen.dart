import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forgot_password_state.dart';
import 'package:matrimony/user_auth_screens/register_star_details/otp_screen_forgot_passowrd.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProviderState = ref.watch(forgotPasswordProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: AppColors.primaryButtonColor),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Enter your registered Email and we will send an OTP for resetting your password',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 80),
                Center(
                  child: Image.asset(
                    'assets/resetpasswordimage.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 50),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email ID',
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (forgotPasswordProviderState.isLoading) {
                      } else {
                        if (_emailController.text.isNotEmpty) {
                          final result = await ref
                              .read(forgotPasswordProvider.notifier)
                              .sendPasswordReset(_emailController.text);
                          if (result == 'Email is Invalid!.') {
                            CustomSnackBar.show(
                                context: context,
                                message: 'Email is Not Exist!.',
                                isError: true);
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpScreenForgotPassword(
                                  email: _emailController.text,
                                  phoneNumber: result,
                                ),
                              ),
                            );
                            CustomSnackBar.show(
                                context: context,
                                message: 'OTP sent successfully to your email!',
                                isError: false);
                          }
                        } else {
                          CustomSnackBar.show(
                              context: context,
                              message: 'Email is Empty!',
                              isError: true);
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: forgotPasswordProviderState.isLoading
                        ? const LoadingIndicator()
                        : const Text(
                            'Get OTP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Login With Password',
                      style: TextStyle(
                        color: AppColors.primaryButtonColor,
                        fontSize: 16,
                      ),
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
