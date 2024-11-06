import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_profesional_preference_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class PartnerReligiousPreferenceScreen extends ConsumerStatefulWidget {
  const PartnerReligiousPreferenceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerReligiousPreferenceScreen> createState() =>
      _PartnerReligiousPreferenceScreenState();
}

class _PartnerReligiousPreferenceScreenState
    extends ConsumerState<PartnerReligiousPreferenceScreen> {
  List<String> selectedReligion  =[];
  List<String> selectedCaste =[];
  List<String> selectedSubCaste= [];
  List<String> selectedStar =[];
  List<String> selectedDosham = [];
  List<String> selectedRassi= [];

  final List<String> religionList = ['Hindu', 'Muslim', 'Christian', 'Sikh'];
  final List<String> casteList = ['Brahmin', 'Kshatriya', 'Vaishya', 'Shudra'];
  final List<String> subCasteList = ['Iyengar', 'Iyer', 'Gounder', 'Nair'];
  final List<String> starList = ['Ashwini', 'Bharani', 'Krittika'];
  final List<String> doshamList = ['Yes', 'No', 'Don\'t Know'];
    final List<String> rassiList= ['Yes', 'No', 'Don\'t Know'];

  @override
  Widget build(BuildContext context) {
    final inputState = ref.read(preferenceInputProvider.notifier);
    final partnerRegisterState = ref.watch(partnerPreferenceProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Partner Preferences',
          style: AppTextStyles.headingTextstyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    'Acceptable matches (Your preferences will be shown\naccording to your preferences)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Religious Preferences:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Religion Dropdown
                CustomPreferenceDropdownField(
                  value: selectedReligion, // Set value as null initially
                  hint: "Religion",  // Add hint text
                  items: religionList,
                  onChanged: (value) {
                    setState(() {
                      selectedReligion = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                
                // Caste Dropdown
                CustomPreferenceDropdownField(
                  value: selectedCaste,  // Set value as null initially
                  hint: "Caste",  // Add hint text
                  items: casteList,
                  onChanged: (value) {
                    setState(() {
                      selectedCaste = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                
                // Sub Caste Dropdown
                CustomPreferenceDropdownField(
                  value: selectedSubCaste,  
                  hint: "SubCaste", 
                  items: subCasteList,
                  onChanged: (value) {
                    setState(() {
                      selectedSubCaste = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                
                // Star Dropdown
                CustomPreferenceDropdownField(
                  value: selectedStar , 
                  hint: "Star(Optional)", 
                  items: starList,
                  onChanged: (value) {
                    setState(() {
                      selectedStar = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                                CustomPreferenceDropdownField(
                  value: selectedRassi,
                  hint: "Rassi(Optional)", 
                  items: rassiList,
                  onChanged: (value) {
                    setState(() {
                      selectedRassi = value;
                    });
                  },
                ),
                    const SizedBox(height: 10),
                // Dosham Dropdown
                CustomPreferenceDropdownField(
                  value: selectedDosham,
                  hint: "Dosham(Optional)", 
                  items: doshamList,
                  onChanged: (value) {
                    setState(() {
                      selectedDosham = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                
                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {

                    ref.read(preferenceInputProvider.notifier).updatePreferenceInput(
                       religion: selectedReligion.toString(),
                       caste: selectedCaste.toString(),
                       subcaste: selectedSubCaste.toString(),
                       star: selectedStar.toString(),
                       rassi: selectedRassi.toString(),
                       dosham: selectedDosham.toString()
                    );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PartnerProfessionalScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:partnerRegisterState.isLoading?  const Center(child: CircularProgressIndicator(),): const Text(
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
        ),
      ),
    );
  }
}
