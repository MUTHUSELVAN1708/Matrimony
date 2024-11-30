import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forgot_password_state.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const NewPasswordScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<NewPasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final newPassWord = TextEditingController();
  final confirmPassWord = TextEditingController();
  bool newPasswordVisible = true;
  bool confirmPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    final value = widget.phoneNumber.substring(widget.phoneNumber.length - 10);
    newPassWord.text = value;
    confirmPassWord.text = value;
  }

  bool validatePassword(String password) {
    final regex = RegExp(
        r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{15,20}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.headingTextColor,
          ),
        ),
        title: const Text(
          'Change Password',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'If you want to change a password',
                style: AppTextStyles.spanTextStyle.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.width * 0.45,
                width: MediaQuery.of(context).size.width * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/resetpasswordimage.png'),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: newPasswordVisible,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          if (newValue.text.length < 10) {
                            return oldValue;
                          }
                          return newValue;
                        }),
                      ],
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        hintText: 'New Password',
                        hintStyle: AppTextStyles.spanTextStyle,
                        suffixIcon: IconButton(
                          icon: Icon(newPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              newPasswordVisible = !newPasswordVisible;
                            });
                          },
                        ),
                      ),
                      controller: newPassWord,
                      // readOnly: newPassWord.text.length == 10,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: confirmPasswordVisible,
                      obscuringCharacter: '*',
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          // Prevents the password from being less than 10 characters
                          if (newValue.text.length < 10) {
                            return oldValue;
                          }
                          return newValue;
                        }),
                      ],
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: AppTextStyles.spanTextStyle,
                        suffixIcon: IconButton(
                          icon: Icon(confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              confirmPasswordVisible = !confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      controller: confirmPassWord,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password must be 15-20 characters long, include at least one special character, one capital letter, and one number.",
                        style:
                            AppTextStyles.spanTextStyle.copyWith(fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Note: ',
                            style: AppTextStyles.spanTextStyle
                                .copyWith(fontSize: 13),
                          ),
                          Expanded(
                            child: Text(
                              'Password First 10 Characters Your Mobile Number. That Was Not Editable*',
                              style: AppTextStyles.spanTextStyle.copyWith(
                                  fontSize: 12,
                                  color: AppColors.primaryButtonColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: AppTextStyles.primaryButtonstyle,
                  onPressed: () async {
                    if (forgotPasswordState.isLoading) {
                      return;
                    }
                    if (!validatePassword(newPassWord.text) ||
                        !validatePassword(confirmPassWord.text)) {
                      CustomSnackBar.show(
                        context: context,
                        message:
                            'Password does not meet the required criteria.',
                        isError: true,
                      );
                      return;
                    }
                    if (newPassWord.text != confirmPassWord.text) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Confirm Password is different',
                        isError: true,
                      );
                      return;
                    }
                    final result = await ref
                        .read(forgotPasswordProvider.notifier)
                        .newPassword(confirmPassWord.text, widget.phoneNumber);
                    if (result == 'Success') {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Password Changed Successfully.',
                        isError: false,
                      );
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Something Went Wrong. Please Try Again!',
                        isError: true,
                      );
                    }
                  },
                  child: forgotPasswordState.isLoading
                      ? const LoadingIndicator()
                      : const Text(
                          'Submit',
                          style: AppTextStyles.primarybuttonText,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
