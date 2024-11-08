import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/common_mobile_picker.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:matrimony/user_auth_screens/otp_screen.dart';

class RegisterUserDetailsScreen extends ConsumerStatefulWidget {
  final String? registerFor;

  const RegisterUserDetailsScreen({Key? key, this.registerFor})
      : super(key: key);

  @override
  ConsumerState<RegisterUserDetailsScreen> createState() =>
      _RegisterUserDetailsScreenState();
}

class _RegisterUserDetailsScreenState
    extends ConsumerState<RegisterUserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  String mobileKey = '+91';
  bool allowedmobileNumber = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: ProgressIndicatorWidget(value: 0.2),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text('Account Details',
                    style: AppTextStyles.headingTextstyle),
                const SizedBox(height: 8),
                const Center(
                  child: Text('The Perfect Match For Your Personal Preferences',
                      style: AppTextStyles.spanTextStyle),
                ),
                const SizedBox(height: 30),

                // Full Name TextField
                TextFormField(
                  controller: _nameController,
                  decoration: _buildInputDecoration('Full Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _buildInputDecoration('Email'),
                  // Use inputFormatters to restrict spaces
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'\s')), // Disallow spaces
                  ],
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) {
                      return 'Please enter a valid email';
                    }
                    return null; // Valid email
                  },
                ),
                const SizedBox(height: 16),

                // Phone Number Row
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => MobilePicker(
                              onSelect: (Country country) {
                                setState(() {
                                  mobileKey = country.code;
                                });
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14),
                            ),
                          ),
                          child: Text(
                            mobileKey,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            suffixIcon: Icon(Icons.check_circle,
                                color: allowedmobileNumber
                                    ? Colors.green
                                    : Colors.grey.shade300),
                          ),
                          onChanged: (value) {
                            _passwordController.text = _phoneController.text;
                            setState(() {
                              if (_phoneController.text.length == 10) {
                                allowedmobileNumber = !allowedmobileNumber;
                              } else {
                                allowedmobileNumber = false;
                              }
                            });
                          },
                          // validator: (value) {
                          //   if (value?.isEmpty ?? true) {
                          //     return 'Please enter your phone number';
                          //   }
                          //   if (value!.length != 10) {
                          //     return 'Please enter a valid 10-digit phone number';
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'OTP will be sent to this number',
                    style: AppTextStyles.spanTextStyle.copyWith(fontSize: 13),
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextFormField(
                  readOnly: allowedmobileNumber ? false : true,
                  controller: _passwordController,
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
                  decoration: _buildInputDecoration('Create Password'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a password';
                    }
                    if (value!.length < 15) {
                      return 'Password must be at least 15 characters';
                    }

                    // Regular expression to check for at least one uppercase letter, one lowercase letter, and one special character
                    final bool hasUpperCase = value.contains(RegExp(r'[A-Z]'));
                    final bool hasLowerCase = value.contains(RegExp(r'[a-z]'));
                    final bool hasSpecialCharacter = value.contains(RegExp(
                        r'[!@#$%^&*(),.?":{}|<>]')); // You can modify this to include/exclude characters as needed

                    if (!hasUpperCase) {
                      return 'Password must include at least one uppercase letter';
                    }
                    if (!hasLowerCase) {
                      return 'Password must include at least one lowercase letter';
                    }
                    if (!hasSpecialCharacter) {
                      return 'Password must include at least one special character';
                    }

                    return null; // Return null if all validations are passed
                  },
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password must be 15-20 characters long, include at least one special character, and one alphabet.",
                    style: AppTextStyles.spanTextStyle.copyWith(fontSize: 13),
                  ),
                ),

                const SizedBox(height: 50),

                // Get OTP Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final registerNotifier =
                            ref.read(registerProvider.notifier);
                        registerNotifier.email = _emailController.text;
                        registerNotifier.name = _nameController.text;
                        registerNotifier.password = _passwordController.text;
                        registerNotifier.phoneNumber = _phoneController.text;
                        registerNotifier.profileFor = widget.registerFor;

                        bool success = await registerNotifier.register();
                        print(success);
                        if (success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpScreen(
                                phoneNumber: _phoneController.text,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: registerState.isLoading
                        ? const LoadingIndicator()
                        : const Text(
                            'Get OTP',
                            style: AppTextStyles.primarybuttonText,
                          ),
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: AppTextStyles.spanTextStyle),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Log In',
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: AppColors.headingTextColor),
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

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey.shade600),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
