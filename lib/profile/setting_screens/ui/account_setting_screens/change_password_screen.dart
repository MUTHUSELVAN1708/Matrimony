import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/profile/setting_screens/riverpod/change_pass_state.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  final String phoneNumber;

  const ChangePasswordScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  bool newPasswordVisible = true;
  bool confirmPasswordVisible = true;
  bool oldPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    final value = widget.phoneNumber.substring(widget.phoneNumber.length - 10);
    newPassword.text = value;
    confirmPassword.text = value;
  }

  bool validatePassword(String password) {
    final regex = RegExp(
        r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{15,20}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    final changePassState = ref.watch(changePassProvider);
    return EnhancedLoadingWrapper(
      isLoading: changePassState.isLoading,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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
              )),
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
                const Text(
                  'If you want to change a Password',
                  style: AppTextStyles.spanTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.45,
                  width: MediaQuery.of(context).size.width * 0.45,
                  // color: Colors.red,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/resetpasswordimage.png'))),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: oldPasswordVisible,
                        obscuringCharacter: '*',
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
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
                          hintText: 'Old Password',
                          hintStyle: AppTextStyles.spanTextStyle,
                          suffixIcon: IconButton(
                            icon: Icon(oldPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                oldPasswordVisible = !oldPasswordVisible;
                              });
                            },
                          ),
                        ),
                        controller: oldPassword,
                      ),
                      const SizedBox(height: 20),
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
                        controller: newPassword,
                        // readOnly: newPassWord.text.length == 10,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: confirmPasswordVisible,
                        obscuringCharacter: '*',
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20),
                          TextInputFormatter.withFunction((oldValue, newValue) {
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
                                confirmPasswordVisible =
                                    !confirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        controller: confirmPassword,
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password must be 15-20 characters long, include at least one special character, one capital letter, and one number.",
                          style: AppTextStyles.spanTextStyle
                              .copyWith(fontSize: 13),
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
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: AppTextStyles.primaryButtonstyle,
                      onPressed: () async {
                        if (changePassState.isLoading) {
                          return;
                        }
                        if (!validatePassword(newPassword.text) ||
                            !validatePassword(confirmPassword.text)) {
                          CustomSnackBar.show(
                            context: context,
                            message:
                                'Password does not meet the required criteria.',
                            isError: true,
                          );
                          return;
                        }
                        if (newPassword.text != confirmPassword.text) {
                          CustomSnackBar.show(
                            context: context,
                            message: 'Confirm Password is different',
                            isError: true,
                          );
                          return;
                        }
                        if (oldPassword.text == confirmPassword.text) {
                          CustomSnackBar.show(
                            context: context,
                            message: 'Old and New Password is Same.',
                            isError: true,
                          );
                          return;
                        }
                        final result = await ref
                            .read(changePassProvider.notifier)
                            .changePassword(oldPassword.text, newPassword.text);
                        if (result == 'Success') {
                          CustomSnackBar.show(
                            context: context,
                            message: 'Password Changed Successfully.',
                            isError: false,
                          );
                          Navigator.of(context).pop();
                        } else {
                          CustomSnackBar.show(
                            context: context,
                            message: result,
                            isError: true,
                          );
                        }
                      },
                      child: changePassState.isLoading
                          ? const LoadingIndicator()
                          : const Text(
                              'Submit',
                              style: AppTextStyles.primarybuttonText,
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
