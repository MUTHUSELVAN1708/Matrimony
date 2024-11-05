import 'package:flutter/material.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/user_auth_screens/instrest_screens/select_instrest_screen.dart';

class HoroscopeStudyDetailScreen extends StatefulWidget {
  const HoroscopeStudyDetailScreen({Key? key}) : super(key: key);

  @override
  State<HoroscopeStudyDetailScreen> createState() => _HoroscopeStudyDetailScreenState();
}

class _HoroscopeStudyDetailScreenState extends State<HoroscopeStudyDetailScreen> {
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _organizationController = TextEditingController();

  @override
  void dispose() {
    _collegeController.dispose();
    _organizationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Horoscope Details',
          style: AppTextStyles.headingTextstyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
            },
            child: Text(
              'Skip',
              style:AppTextStyles.headingTextstyle.copyWith(
                color: Colors.black
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text(
              textAlign: TextAlign.center,
              'Add College / Institution And\nOrganization Details',
              style:AppTextStyles.headingTextstyle.copyWith(
                color: Colors.black
              ),
            ),
            const SizedBox(height: 24),
            
            // College TextField
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  textAlign: TextAlign.center,
                  'College Where You Studies IE',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _collegeController,
                  decoration: InputDecoration(
                    hintText: 'Enter Institution Name',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Organization TextField
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                     textAlign: TextAlign.center,
                  'Organization where you works',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _organizationController,
                  decoration: InputDecoration(
                    hintText: 'Software Professional',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
            
            const Spacer(),
            
            // Next Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle next action
                  if (_collegeController.text.isNotEmpty && 
                      _organizationController.text.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>InterestPageView()));
                    print('College: ${_collegeController.text}');
                    print('Organization: ${_organizationController.text}');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}