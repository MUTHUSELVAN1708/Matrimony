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
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_personal_details_screen.dart';

import 'login_screens/reverpod/login_password_notifier.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final bool isUserLogin;
  final String? mobile;

  const OtpScreen(
      {super.key,
      required this.phoneNumber,
      required this.isUserLogin,
      this.mobile});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
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
    final result = widget.isUserLogin
        ? await ref
            .read(logApiProvider.notifier)
            .otpWithLogin(widget.phoneNumber, widget.mobile ?? '')
        : await ref.read(registerProvider.notifier).register();

    if (result == 'Success') {
      CustomSnackBar.show(
        context: context,
        message: 'OTP Resent Successfully',
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
    final registerProviderState = ref.watch(registerProvider);
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
                  'We have sent the code verification to\nyour mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
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
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.phoneNumber,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/phone_calling.svg',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
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
                const SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (registerProviderState.isLoading) {
                      } else {
                        final registerState =
                            ref.read(registerProvider.notifier);
                        String otp = _otpDigits.join();
                        print('Verifying OTP: $otp');
                        registerState.otp = otp;
                        registerState.phoneNo = widget.phoneNumber;
                        if (widget.isUserLogin) {
                          bool success = await ref
                              .read(registerProvider.notifier)
                              .otpLoginVerification(widget.phoneNumber);
                          if (success) {
                            CustomSnackBar.show(
                              context: context,
                              message: 'Logged In Successfully',
                              isError: false,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavBarScreen(
                                        isFetch: true,
                                      )),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              message: 'Invalid OTP. Please try again.',
                              isError: true,
                            );
                          }
                        } else {
                          bool success = await ref
                              .read(registerProvider.notifier)
                              .otpRegisterVerification();
                          if (success) {
                            CustomSnackBar.show(
                              context: context,
                              message: 'OTP Verified Successfully.',
                              isError: false,
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterUserPersonalDetailsScreen()),
                              (route) => false,
                            );
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              message: 'Invalid OTP. Please try again.',
                              isError: true,
                            );
                          }
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: registerProviderState.isLoading
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
