import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.headingTextColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Frequently asked questions',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyles.spanTextStyle
                        .copyWith(color: AppColors.black),
                    children: [
                      const TextSpan(
                        text: 'Find Answers To Common Questions\nAbout ',
                      ),
                      TextSpan(
                          text: 'ahatirumanam',
                          style: AppTextStyles.spanTextStyle
                              .copyWith(color: AppColors.headingTextColor)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              _buildFAQItem(
                'How do i login if i forget my email, mobile number?',
                [
                  'If you forgot your registered email ID, and mobile number, please reach out to our support team at helpdesk@ahatirumanam.com.',
                  'They will assist you in the retrieval process and help you regain access to your account. Having at least one of these details is essential for the login process.',
                ],
                isExpanded: true,
              ),
              SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                  'How do i log in if i forget my password?',
                  [
                    'If you forgot your login password or want to change it, follow these steps:',
                    'Access the Forgot Password link.',
                    'Enter your mobile number or email ID associated with your account.',
                    'You will receive a SMS & email ID with a link to reset your password.',
                    'Follow the link to reset your password securely.',
                  ],
                  heading: true),
              SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                  'Can i change the mobile number, email address associated with my matrimony account?',
                  [
                    'Yes, you can change your mobile number or email address.',
                    'If you are using your account via app,',
                    'Go to the "Edit contact" section.',
                    'Select "Edit contact info" tab.',
                    'Follow the steps provided to edit your email ID, mobile number, or both.',
                    'If you are using via Web Go to the "Profile settings" -> Privacy -> Mobile Privacy section to change your mobile number.',
                    'Go to the "Profile settings" -> Edit email address section to change your email address.',
                    'Please ensure that these details are accurate as they are essential for login and communication.'
                  ],
                  heading: true),
              SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                'I didn\'t receive the otp for login. what should i do?',
                [
                  'If you haven\'t received the OTP for login,please ensure your mobile number is entered correctly.',
                  'Also check if your mobile device has a stable network connection, your mobile number is active and capable of receiving SMS.',
                  'If the issue persists, reach out to our support team at helpdesk@bharatmatrimony.com for further assistance.'
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                'I didn\'t receive the password reset email, what should i do?',
                [
                  'If you haven\'t received the password reset email, please ensure that your email address is correct.',
                  'Also, check your spam or junk folders for the email. You can also try requesting another password reset email.',
                  'If the issue persists, reach out to our support team at helpdesk@bharatmatrimony.com for further assistance.'
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                'Can i log into my profile from multiple devices simultaneously?',
                [
                  'Yes, you can log into your profile from multiple devices simultaneously.'
                ],
              ),
              SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                'Why is the message invalid e-mail id/mobile number or incorrect password being displayed when i try to login?',
                [
                  'This message is displayed if the Email ID, mobile number, or password entered during login is incorrect.',
                  'Please recheck your credentials and ensure that the details are accurate.'
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _buildFAQItem(
                'Can i log into my profile from multiple devices simultaneously?',
                [
                  'This message is displayed if the Email ID, mobile number, or password entered during login is incorrect.',
                  'Please recheck your credentials and ensure that the details are accurate.'
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, List<String> answers,
      {bool isExpanded = false, bool heading = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000), // Shadow color (with opacity)
            offset:
                Offset(1, 2), // Horizontal and vertical offsets of the shadow
            blurRadius: 11.1, // Blur radius for the shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          title: Text(
            question,
            style: AppTextStyles.spanTextStyle,
          ),
          iconColor: Colors.red,
          collapsedIconColor: Colors.grey,
          children: answers.map((answer) {
            bool isFirstAnswer = answers.indexOf(answer) == 0;

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    if (heading && isFirstAnswer)
                      Text(
                        answer,
                        style: AppTextStyles.spanTextStyle.copyWith(
                          color: const Color(0XFF171717),
                        ),
                      ),
                    if (!isFirstAnswer)
                      Text(
                        '*  $answer',
                        style: AppTextStyles.spanTextStyle.copyWith(
                          color: const Color(0XFF171717),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// FAQ Data Model (Optional - for better organization)
class FAQItem {
  final String question;
  final List<String> answers;
  final bool isExpanded;

  FAQItem({
    required this.question,
    required this.answers,
    this.isExpanded = false,
  });

  static List<FAQItem> getFAQs() {
    return [
      FAQItem(
        question: 'How do i login if i forget my email, mobile number?',
        answers: [
          'If you forgot your registered email ID, and mobile number, please reach out to our support team at helpdesk@ahatirumanam.com.',
          'They will assist you in the retrieval process and help you regain access to your account. Having at least one of these details is essential for the login process.',
        ],
        isExpanded: true,
      ),
      FAQItem(
        question: 'How do i log in if i forget my password?',
        answers: [],
      ),
      // Add more FAQs here
    ];
  }
}
