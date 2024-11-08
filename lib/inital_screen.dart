import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_select_screen.dart';

class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.pink,
            image: DecorationImage(
              image: AssetImage('assets/initialScreen.png'),
              fit: BoxFit.cover,
            ),
          ),
          width: double.infinity,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Discover Love where your story begins.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headingTextstyle.copyWith(
                      fontSize: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Join us to discover your ideal partner and ignite the sparks of romance in your journey.',
                  style: AppTextStyles.spanTextStyle.copyWith(
                    color: AppColors.primaryButtonTextColor,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterSetupUserScreen()));
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: const Text(
                      'Create account',
                      style: AppTextStyles.primarybuttonText,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account?',
                      style: AppTextStyles.spanTextStyle
                          .copyWith(color: AppColors.primaryButtonTextColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        ' log in',
                        style: AppTextStyles.spanTextStyle
                            .copyWith(color: AppColors.primaryButtonColor),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          right: 10,
          child: InkWell(
            onTap: () {
              showLanguageDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
                border: Border.all(color: Colors.black),
              ),
              child: const Row(
                children: [Text('அ'), Text("/"), Text('A')],
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String? selectedLanguage;

  final List<Map<String, String>> languages = [
    {
      'code': 'அ',
      'name': 'தமிழ்',
      'letter': 'அ',
    },
    {
      'code': 'en',
      'name': 'English',
      'letter': 'A',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with close button
            Stack(
              children: [
                const Center(
                  child: Text(
                    'Select display language',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Language options grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
              ),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected = selectedLanguage == language['code'];

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedLanguage = language['code'];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: isSelected ? Colors.red.shade50 : Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60, // increased size for clearer circle
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isSelected ? Colors.red : Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2), // subtle shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              language['letter'] ?? '',
                              style: TextStyle(
                                fontSize: 24, // slightly larger text
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          language['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Apply button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement language change logic here
                  print('Selected language: $selectedLanguage');
                  Navigator.of(context).pop(selectedLanguage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Apply'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const LanguageSelector(),
  );
}
