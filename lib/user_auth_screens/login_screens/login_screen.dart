import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/user_auth_screens/forget_password_screen.dart';
import 'package:matrimony/user_auth_screens/login_screens/loginscreen_with_otp.dart';
import 'package:matrimony/user_auth_screens/login_screens/reverpod/login_password_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_select_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  FocusNode phoneNo = FocusNode();

  FocusNode Password = FocusNode();

  FocusNode loginButton = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
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
                TextField(
                  controller: emailController,
                  focusNode: phoneNo,
                  onSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(Password),
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  focusNode: Password,
                  onSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(loginButton),
                  obscureText: _obscureText,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    hintText: 'Enter Your Password',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)),
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    focusNode: loginButton,
                    onPressed: () async {
                      if (loginState.isLoading) {
                      } else {
                        final logUserModel = await ref
                            .read(logApiProvider.notifier)
                            .passwordWithLogin(
                                passwordController.text, emailController.text);

                        if (logUserModel.token != '') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavBarScreen(
                                        isFetch: true,
                                      )));
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
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreenWithOtp()),
                        );
                      },
                      child: const Text(
                        'Login With OTP',
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height:
                          20, // You can adjust the height as per your design
                      child: VerticalDivider(
                        thickness: 2, // Adjust thickness if needed
                        color: Color.fromARGB(255, 12, 11, 11),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Sign Up option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
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
