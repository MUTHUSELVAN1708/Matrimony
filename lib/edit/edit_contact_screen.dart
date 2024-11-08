import 'package:flutter/material.dart';

import '../common/colors.dart';

class EditContactScreen extends StatelessWidget {
  final VoidCallback onPop;

  const EditContactScreen({
    super.key,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context) {
    final heightQuery = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Back button on background image
          Positioned(
            top: 40,
            left: 16,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    onPop();
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: heightQuery * 0.15,
                ),
                const Text(
                  'Edit Contact Info',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // White container with form
          Positioned(
            top: heightQuery * 0.28,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: const Text(
                          'Personal Information',
                          style: TextStyle(
                            color: AppColors.primaryButtonColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: const Text(
                          'Current Email',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _buildTextField(
                          'Current Email', 'dummyxxx@gmail.com', false),
                      _buildTextField('Enter your new Email address', '', true),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: const Text(
                          'Current Contact Number',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _buildTextField(
                          'Current contact number', '1234567890', false),
                      _buildTextField(
                          'Enter your new contact number', '', true),
                      const SizedBox(height: 16),
                      const Text(
                        'Contact Preference',
                        style: TextStyle(
                          color: AppColors.primaryButtonColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildListTile('Whom to contact', 'Not Specified'),
                      _buildListTile('Contact person\'s name', 'Not Specified'),
                      _buildListTile('Available time to call', 'Not Specified'),
                      _buildListTile('Comments', 'Not Specified'),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryButtonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hintText, String initialValue, bool isEnabled) {
    Icon? _getPrefixIcon() {
      if (hintText.toLowerCase().contains('email')) {
        return const Icon(Icons.email, color: Colors.grey);
      } else if (hintText.toLowerCase().contains('contact') ||
          hintText.toLowerCase().contains('phone')) {
        return const Icon(Icons.phone, color: Colors.grey);
      }
      return null;
    }

    return Padding(
      padding: isEnabled
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : EdgeInsets.zero,
      child: TextField(
        controller: TextEditingController(text: initialValue),
        enabled: isEnabled,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: _getPrefixIcon(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
