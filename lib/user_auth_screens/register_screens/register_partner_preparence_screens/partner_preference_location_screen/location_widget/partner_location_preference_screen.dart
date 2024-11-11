import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/location_widget/common_location_dropdown.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
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
  List<String>? selectedCountry = [];
  List<String>? selectedState = [];
  List<String>? selectedCity = [];

  @override
  initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    await Future.delayed(Duration.zero);
    ref.read(locationProvider.notifier).getallCountryData();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterState = ref.watch(partnerPreferenceProvider);
    final countryState = ref.watch(locationProvider);
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
            PreferenceLocationDropdown(
                showSearch: true,
                value: selectedCountry != null ? selectedCountry! : [],
                hint: "Country",
                // items: countries,
                items: countryState.countryList.map((e) => e.countrys).toList(),
                onChanged: (value) async {
                  // Update the selected country first
                  setState(() {
                    selectedCountry = value;
                    selectedState!.clear();
                    selectedCity!.clear();
                  });

                  int? stateId;
                  for (var e in countryState.countryList) {
                    if (e.countrys == selectedCountry![0]) {
                      stateId = e.id;
                      break;
                    }
                  }

                  print("Selected State ID: $stateId");

                  // Ensure stateId is not null before calling getStateData
                  if (stateId != null) {
                    await ref
                        .read(locationProvider.notifier)
                        .getStateData(stateId);
                  } else {
                    print("No state ID found for the selected country.");
                  }
                }),
            selectedCountry!.isEmpty ||
                    countryState.stateList.isEmpty ||
                    selectedCountry?[0] == 'Any'
                ? SizedBox()
                : const SizedBox(height: 10),

            // State Dropdown
            selectedCountry!.isEmpty ||
                    countryState.stateList.isEmpty ||
                    selectedCountry?[0] == 'Any'
                ? SizedBox()
                : PreferenceLocationDropdown(
                    showSearch: true,
                    value: selectedState != null ? selectedState! : [],
                    hint: "State",
                    items: countryState.stateList.map((e) => e.states).toList(),
                    onChanged: (value) async {
                      setState(() {
                        selectedState = value;
                        print(selectedState);
                        selectedCity!.clear();
                      });
                      int? stateId;
                      for (var e in countryState.stateList) {
                        if (e.states == selectedState![0]) {
                          stateId = e.id;
                          break;
                        }
                      }

                      print("Selected State ID: $stateId");
                      if (stateId != null) {
                        await ref
                            .read(locationProvider.notifier)
                            .getCityData(stateId);
                      } else {
                        print("No state ID found for the selected country.");
                      }
                    },
                  ),
            selectedState!.isEmpty || countryState.cityList.isEmpty
                ? SizedBox()
                : SizedBox(height: 10),

            selectedState!.isEmpty || countryState.cityList.isEmpty
                ? SizedBox()
                : PreferenceLocationDropdown(
                    showSearch: true,
                    value: selectedCity != null ? selectedCity! : [],
                    hint: "City",
                    items: countryState.cityList.map((e) => e.citys).toList(),
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
                  if (selectedCountry != null && selectedCountry!.isNotEmpty) {
                    ref
                        .read(preferenceInputProvider.notifier)
                        .updatePreferenceInput(
                          country: selectedCountry!.isNotEmpty
                              ? selectedCountry![0]
                              : '',
                          states: selectedState!.isNotEmpty
                              ? selectedState![0]
                              : '',
                          city:
                              selectedCity!.isNotEmpty ? selectedCity![0] : '',
                        );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddStarDetailScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select country, state, and city'),
                      ),
                    );
                  }
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
