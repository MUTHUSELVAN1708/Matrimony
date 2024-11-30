import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/show_toastdialog.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forgot_password_state.dart';
import 'package:matrimony/user_auth_screens/register_star_details/new_password_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_personal_details_screen.dart';

class OtpScreenForgotPassword extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String email;

  const OtpScreenForgotPassword(
      {super.key, required this.phoneNumber, required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreenForgotPassword> {
  final List<String> _otpDigits = List.filled(4, '');
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  int _secondsRemaining = 60;
  bool _isResendEnabled = false;
  bool _isResending = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  void _startResendCountdown() {
    _secondsRemaining = 60;
    _isResendEnabled = false;
    _isResending = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsRemaining--;
        if (_secondsRemaining <= 0) {
          _timer?.cancel();
          _isResendEnabled = true;
        }
      });
    });
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResendEnabled = false;
      _isResending = true;
    });
    final result = await ref
        .read(forgotPasswordProvider.notifier)
        .sendPasswordReset(widget.email);

    if (result.contains('+')) {
      CustomSnackBar.show(
        context: context,
        message: 'OTP resent successfully to your email!',
        isError: false,
      );
      _startResendCountdown();
    } else {
      setState(() {
        _isResendEnabled = true;
        _isResending = false;
      });
      CustomSnackBar.show(
        context: context,
        message: 'Failed to resend OTP. Please try again.',
        isError: true,
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordProviderState = ref.watch(forgotPasswordProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.red,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    image: const DecorationImage(
                        image: AssetImage('assets/otpicon.png')),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Verification Code',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headingTextstyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'We have sent the code verification to\nyour Email',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 20),
                // OTP Input Fields
                Container(
                  margin: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 50,
                        height: 50,
                        child: TextField(
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.pink[100],
                            counterText: '',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.red, width: 2),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              _otpDigits[index] = value;
                              if (index < 3) {
                                _focusNodes[index].unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              }
                            }
                            if (value.isEmpty && index > 0) {
                              _focusNodes[index].unfocus();
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index - 1]);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       widget.phoneNumber,
                //       textAlign: TextAlign.center,
                //       style: const TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //     const SizedBox(width: 8),
                //     SvgPicture.asset(
                //       'assets/phone_calling.svg',
                //       width: 24,
                //       height: 24,
                //     ),
                //   ],
                // ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: AppTextStyles.secondaryButtonstyle,
                    onPressed: _isResendEnabled
                        ? () {
                            _resendOtp();
                          }
                        : null,
                    child: Text(
                      _isResendEnabled
                          ? 'Resend OTP'
                          : _isResending
                              ? 'Resending OTP...'
                              : 'Resend in $_secondsRemaining seconds',
                      style: AppTextStyles.secondaryButton,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (forgotPasswordProviderState.isLoading) {
                      } else {
                        String otp = _otpDigits.join();
                        String success = await ref
                            .read(forgotPasswordProvider.notifier)
                            .otpVerification(widget.phoneNumber, otp);
                        if (success == 'Success') {
                          CustomSnackBar.show(
                            context: context,
                            message: 'OTP Verified Successfully.',
                            isError: false,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPasswordScreen(
                                        phoneNumber: widget.phoneNumber,
                                      )));
                        } else {
                          CustomSnackBar.show(
                            context: context,
                            message: success,
                            isError: true,
                          );
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: forgotPasswordProviderState.isLoading
                        ? const Center(
                            child: LoadingIndicator(),
                          )
                        : const Text(
                            'Verify',
                            style: AppTextStyles.primarybuttonText,
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
