import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/show_toastdialog.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:matrimony/user_auth_screens/login_screens/loginscreen_phoneNo_field.dart';
import 'package:matrimony/user_auth_screens/login_screens/reverpod/login_password_notifier.dart';
import 'package:matrimony/user_auth_screens/otp_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_select_screen.dart';

class LoginScreenWithOtp extends ConsumerStatefulWidget {
  const LoginScreenWithOtp({super.key});

  @override
  ConsumerState<LoginScreenWithOtp> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreenWithOtp> {
  FocusNode phoneNo = FocusNode();

  FocusNode loginButton = FocusNode();
  TextEditingController phoneNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(logApiProvider.notifier).clearPhoneNo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(logApiProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 40),
                const Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Hello welcome back to account',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      'assets/loginimage.png',
                      height: MediaQuery.of(context).size.width * 0.60,
                      width: MediaQuery.of(context).size.width * 0.60,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: -2,
                      child: Container(
                        // width: 200,
                        width: MediaQuery.of(context).size.width * 0.60,
                        color: Colors.black,
                        height: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                PhoneNumberField(phoneNoController: phoneNoController),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    focusNode: loginButton,
                    onPressed: () async {
                      if (loginState.isLoading) {
                      } else {
                        final mobileNo = ref.read(logApiProvider).mobileNo;
                        if (phoneNoController.text.isNotEmpty &&
                            mobileNo != null) {
                          final success = await ref
                              .read(logApiProvider.notifier)
                              .otpWithLogin(mobileNo, phoneNoController.text);
                          if (success == 'Success') {
                            CustomSnackBar.show(
                                context: context,
                                message: 'OTP sent Sucessfully.',
                                isError: false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          phoneNumber: mobileNo,
                                          isUserLogin: true,
                                          mobile: phoneNoController.text,
                                        )));
                          } else {
                            CustomSnackBar.show(
                                context: context,
                                message: success,
                                isError: true);
                          }
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: loginState.isLoading
                        ? const Center(
                            child: SizedBox(
                              height: 24,
                              width: 24,
                              child: LoadingIndicator(),
                            ),
                          )
                        : const Text(
                            'Log In',
                            style: AppTextStyles.primarybuttonText,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login With Password',
                    style: TextStyle(
                      color: AppColors.primaryButtonColor,
                      fontSize: 16,
                    ),
                  ),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.5), fontSize: 16)),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterSetupUserScreen()),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
