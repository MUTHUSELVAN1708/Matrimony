import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/show_toastdialog.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_personal_details_screen.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final bool isUserLogin;
  const OtpScreen(
      {super.key, required this.phoneNumber, required this.isUserLogin});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final List<String> _otpDigits = List.filled(4, '');
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
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
              })),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
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
                            if (value.length == 1) {
                              _otpDigits[index] = value;
                              if (index < 3) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              }
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
                      widget.phoneNumber, // Display the phone number
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                        width: 8), // Add some space between the text and icon
                    SvgPicture.asset(
                      'assets/edit_icon.svg', // Correctly use SvgPicture to display SVG
                      width: 24, // Set the desired width
                      height: 24, // Set the desired height
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Resend Option
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: AppTextStyles.secondaryButtonstyle,
                    onPressed: () {},
                    child: const Text(
                      'Resend Again',
                      style: AppTextStyles.secondaryButton,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      String otp = _otpDigits.join();
                      print('Verifying OTP: $otp');
                      final registerState = ref.read(registerProvider.notifier);
                      registerState.otp = otp;
                      registerState.phoneNo = widget.phoneNumber;
                      bool success = await ref
                          .read(registerProvider.notifier)
                          .otpVerification();
                      if (success) {
                        if (widget.isUserLogin) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavBarScreen()),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterUserPersonalDetailsScreen()));
                        }
                      } else {
                        CustomSnackBar.show(
                          context: context,
                          message: 'Invalid OTP. Please try again.',
                          isError: true,
                        );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Invalid OTP. Please try again.'),
                        //     backgroundColor: Colors.red, // Use red color for error indication
                        //     behavior: SnackBarBehavior.floating, // Optional: makes it float above content
                        //     duration: Duration(seconds: 2),
                        //   ),
                        // );
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: const Text(
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

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}
