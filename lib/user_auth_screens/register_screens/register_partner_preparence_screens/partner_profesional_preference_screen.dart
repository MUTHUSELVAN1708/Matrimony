import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/preference_any_dialogBox.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/partner_location_preference_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class PartnerProfessionalScreen extends ConsumerStatefulWidget {
  const PartnerProfessionalScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnerProfessionalScreen> createState() =>
      _PartnerProfessionalScreenState();
}

class _PartnerProfessionalScreenState
    extends ConsumerState<PartnerProfessionalScreen> {
  List<String> selectedEdication = [];
  List<String> selectedEmployed = [];
  List<String> selectedOccupation = [];
  List<String> selectedIncome = [];

  List<String> educationList = [
    'High School',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'PhD',
    'Associate Degree',
    'Diploma',
    'Certificate',
    'Postdoctoral',
    'Vocational Training',
    'Online Courses',
    'Technical Certification',
    'Secondary School',
    'Undergraduate',
    'Graduate',
    'Postgraduate',
  ];

  List<String> employedInList = [
    'Government',
    'Private',
    'Business',
    'Self-employed',
    'Freelancer',
    'Non-profit Organization',
    'NGO',
    'Start-up',
    'Multinational Corporation',
    'Startup',
    'Public Sector',
    'Healthcare',
    'Educational Institution',
    'Research Organization',
    'Consultancy',
  ];

  final List<String> occupationList = [
    'Engineer',
    'Doctor',
    'Teacher',
    'Business Analyst',
    'Software Developer',
    'Nurse',
    'Architect',
    'Scientist',
    'Accountant',
    'Lawyer',
    'Teacher',
    'Marketing Manager',
    'Data Analyst',
    'HR Manager',
    'Project Manager',
  ];

  final List<String> incomeList = [
    'Less than 50k',
    '50k - 1L',
    '1L - 5L',
    '5L - 10L',
    'More than 10L',
    '10L - 20L',
    '20L - 50L',
    '50L - 1 Cr',
    '1 Cr - 2 Cr',
    '2 Cr - 5 Cr',
    '5 Cr - 10 Cr',
    '10 Cr - 20 Cr',
    '20 Cr - 50 Cr',
    '50 Cr - 100 Cr',
    'More than 100 Cr',
  ];

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
          icon: const Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Partner Preferences',
            style: AppTextStyles.headingTextstyle),
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
                textAlign: TextAlign.center,
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
                          'criteria and at times might\ngo slightly beyond your preferences',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Professional Preferences:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            AnyCustomPreferenceDropdown(
              value: selectedEdication,
              hint: "Education",
              items: educationList,
              onChanged: (value) {
                setState(() {
                  selectedEdication = value;
                });
              },
            ),
            const SizedBox(height: 10),

            AnyCustomPreferenceDropdown(
              value: selectedEmployed,
              hint: "Employed In",
              items: employedInList,
              onChanged: (value) {
                setState(() {
                  selectedEmployed = value;
                });
              },
            ),
            const SizedBox(height: 10),

            // Occupation Dropdown
            AnyCustomPreferenceDropdown(
              value: selectedIncome,
              hint: "Occupation",
              items: occupationList,
              onChanged: (value) {
                setState(() {
                  selectedIncome = value;
                });
              },
            ),
            const SizedBox(height: 10),

            AnyCustomPreferenceDropdown(
              value: selectedOccupation,
              hint: "Annual Income",
              items: incomeList,
              onChanged: (value) {
                setState(() {
                  selectedOccupation = value;
                });
              },
            ),
            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ref
                      .read(preferenceInputProvider.notifier)
                      .updatePreferenceInput(
                          education: selectedEdication.toString(),
                          employedIn: selectedEmployed.toString(),
                          annualIncome: selectedIncome.toString(),
                          profession: selectedOccupation.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PartnerLocationScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: userRegisterState.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
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

  Widget _buildProfessionalField(ProfessionalField field) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          field.title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        trailing: SvgPicture.asset(
          'assets/editIcon.svg',
          height: 24,
          width: 24,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

class ProfessionalField {
  final String title;

  ProfessionalField({
    required this.title,
  });
}
