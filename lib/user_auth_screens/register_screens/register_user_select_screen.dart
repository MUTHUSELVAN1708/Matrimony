import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_register_screen.dart';

class RegisterSetupUserScreen extends StatefulWidget {
  const RegisterSetupUserScreen({Key? key}) : super(key: key);

  @override
  _RegisterSetupUserScreenState createState() =>
      _RegisterSetupUserScreenState();
}

class _RegisterSetupUserScreenState extends State<RegisterSetupUserScreen> {
  // List of profile options
  final List<String> _profileOptions = [
    'Myself',
    'Daughter',
    'Son',
    'Brother',
    'Sister',
    'Friend',
    'Relative',
    'Others'
  ];

  // To store selected option
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: ProgressIndicatorWidget(value: 0.07),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
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
                          width: MediaQuery.of(context).size.width * 0.60,
                          color: Colors.black,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Create Account',
                    style: AppTextStyles.headingTextstyle,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 40.0),
                    child: Text(
                      'We have sent the OTP code. Please verify to create your account',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.spanTextStyle,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'I am creating this profile for',
                  style: AppTextStyles.secondrySpanTextStyle.copyWith(
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 20),

                // Dynamic Profile Options Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: _profileOptions.length,
                      itemBuilder: (context, index) {
                        return _buildProfileOption(_profileOptions[index]);
                      },
                    );
                  },
                ),

                const SizedBox(height: 80),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _selectedOption != null
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterUserDetailsScreen(
                                  registerFor: _selectedOption!, // Pass the selected option here
                                ),
                              ),
                            );
                          }
                        : null, // Disable if no option selected
                    style: _selectedOption != null
                        ? AppTextStyles.primaryButtonstyle
                        : ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.grey.shade400),
                          ),
                    child: const Text(
                      'Next',
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

  Widget _buildProfileOption(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = text; 
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedOption == text
                ? Colors.transparent
                : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(25),
          color: _selectedOption == text
              ? AppColors.primaryButtonColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.spanTextStyle.copyWith(
              color: _selectedOption == text
                  ? AppColors.boldTextColor
                  : AppColors.secondaryButtonColor,
            ),
          ),
        ),
      ),
    );
  }

  int _getCrossAxisCount() {
    int count = 3;
    for (String option in _profileOptions) {
      if (option.length > 10) {
        count = 2;
        break;
      }
    }
    return count;
  }
}
