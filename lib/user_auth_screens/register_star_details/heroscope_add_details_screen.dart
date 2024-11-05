import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/user_auth_screens/instrest_screens/select_instrest_screen.dart';
import 'package:matrimony/user_auth_screens/register_star_details/hero_scope_study_details_screen.dart';
import 'package:intl/intl.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart'; // For date formatting

class HoroscopeAddDetailScreen extends ConsumerStatefulWidget {
  const HoroscopeAddDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HoroscopeAddDetailScreen> createState() => _HoroscopeAddDetailScreenState();
}

class _HoroscopeAddDetailScreenState extends ConsumerState<HoroscopeAddDetailScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(); // Date controller for date picker

  // Sample data lists for dropdowns
  final List<String> _birthTimes = ['Morning', 'Afternoon', 'Evening', 'Night'];
  final List<String> _countries = ['USA', 'India', 'UK', 'Canada'];
  final List<String> _states = ['California', 'Maharashtra', 'London', 'Ontario'];
  final List<String> _cities = ['Los Angeles', 'Mumbai', 'London', 'Toronto'];

  String? selectedBirthTime;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Method to open date picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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
          'Add Details',
          style: AppTextStyles.headingTextstyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/starimage.png'),
                  ),
                  border: Border.all(color: Colors.red.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 24),

              // Date of Birth field with DatePicker
              TextField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Select Date of Birth',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Time of Birth dropdown
              CustomDropdownField(
                value: selectedBirthTime ?? '',
                hint: 'Select time of birth',
                items: _birthTimes,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBirthTime = newValue!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Country dropdown
              CustomDropdownField(
                value: selectedCountry ?? '',
                hint: 'Select your country',
                items: _countries,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // State dropdown
              CustomDropdownField(
                value: selectedState ?? '',
                hint: 'Select your state',
                items: _states,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedState = newValue!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // City dropdown
              CustomDropdownField(
                value: selectedCity ?? '',
                hint: 'Select your city of birth',
                items: _cities,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Next button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
                       
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InterestPageView(),
                      ),
                    );
                  },
                  style: AppTextStyles.primaryButtonstyle,
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
    );
  }
}


