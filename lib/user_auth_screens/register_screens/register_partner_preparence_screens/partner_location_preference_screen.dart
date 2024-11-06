import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/user_auth_screens/register_star_details/user_star_details.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class PartnerLocationScreen extends ConsumerStatefulWidget {
  const PartnerLocationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerLocationScreen> createState() =>
      _PartnerLocationScreenState();
}

class _PartnerLocationScreenState extends ConsumerState<PartnerLocationScreen> {
  List<String> selectedCountry = [];
  List<String> selectedState = [];
  List<String> selectedCity = [];

  final List<String> countries = ['India', 'Pakistan', 'USA', 'UK'];
  final Map<String, List<String>> states = {
    'India': ['Maharashtra', 'Karnataka', 'Delhi'],
    'Pakistan': ['Punjab', 'Sindh', 'Khyber Pakhtunkhwa'],
    'USA': ['California', 'New York', 'Texas'],
    'UK': ['England', 'Scotland', 'Wales'],
  };
  final Map<String, List<String>> cities = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Karnataka': ['Bangalore', 'Mysore', 'Mangalore'],
    'Delhi': ['New Delhi', 'Dwarka', 'Connaught Place'],
    'Punjab': ['Lahore', 'Faisalabad', 'Multan'],
    'California': ['Los Angeles', 'San Francisco', 'San Diego'],
    // Add more states and cities as necessary
  };

  @override
  Widget build(BuildContext context) {
    final userRegisterState = ref.watch(partnerPreferenceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Partner Preferences',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'Matches recommended by us are based on\n',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    TextSpan(
                      text: 'Acceptable matches ',
                      style: TextStyle(color: Colors.grey.shade800),
                    ),
                    TextSpan(
                      text:
                          'criteria and at times might go slightly beyond your preferences',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Location Preferences :',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            // Country Dropdown
            CustomPreferenceDropdownField(
              value: selectedCountry,
              hint: "Country",
              items: countries,
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedState = []; // Reset state when country changes
                  selectedCity = []; // Reset city when country changes
                });
              },
            ),
            const SizedBox(height: 10),

            // State Dropdown
            CustomPreferenceDropdownField(
              value: selectedState,
              hint: "State",
              items:
                  selectedCountry != null ? states[selectedCountry!] ?? [] : [],
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                  selectedCity = []; // Reset city when state changes
                });
              },
            ),
            const SizedBox(height: 10),

            // City Dropdown
            CustomPreferenceDropdownField(
              value: selectedCity,
              hint: "City",
              items: selectedState != null ? cities[selectedState!] ?? [] : [],
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),
            const SizedBox(height: 25),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(preferenceInputProvider.notifier)
                      .updatePreferenceInput(
                          country: selectedCountry.toString(),
                          states: selectedState.toString(),
                          city: selectedCity.toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddStarDetailScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: userRegisterState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
