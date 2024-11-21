import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/preference_any_dialogBox.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/location_widget/partner_location_preference_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preparence_religion_screen/riverpod/religious_api_notifier.dart';
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

  final List<String> educationList = [
    '10th',
    '12th',
    'Secondary School',
    'Bachelor\'s Degree',
    'BCA',
    'B.Sc. IT/Computer Science',
    'B.Tech',
    'B.E',
    'B.Arch',
    'Aeronautical Engineering',
    'B.Plan',
    'B.Sc.',
    'B.S.W',
    'B.Phil.',
    'B.M.M.',
    'BFA',
    'BFT',
    'BLIS',
    'B.H.M.',
    'BHA / BHM (Hospital Administration)',
    'Other Bachelor Degree in Engineering / Computers',
    'Other Bachelor Degree in Arts / Science / Commerce',
    'Other Bachelor Degree in Management',
    'Other Bachelor Degree in Legal',
    'Other Bachelor Degree in Medicine',
    'Master\'s Degree',
    'MCA',
    'M.Tech',
    'M.Sc. IT/Computer Science',
    'M.S.(Engg.)',
    'M.Arch.',
    'MFA',
    'M.Ed.',
    'MSc',
    'M.Phil.',
    'M.Com',
    'MSW',
    'MHA / MHM (Hospital Administration)',
    'MFM (Financial Management)',
    'MHM  (Hotel Management)',
    'MHRM (Human Resource Management)',
    'PGDM',
    'Other Master Degree in Engineering / Computers',
    'Other Master Degree in Arts / Science / Commerce',
    'Other Master Degree in Management',
    'Other Master Degree in Medicine',
    'Other Master Degree in Legal',
    'Ph.D.',
    'DM',
    'Postdoctoral fellow',
    'Fellow of National Board (FNB)',
    'Vocational Training',
    'Technical Certification',
    'Online Courses',
    'Diploma',
    'Polytechnic',
    'Trade School',
    'Others in Diploma',
    'Other Degree in Finance',
    'CA',
    'CFA (Chartered Financial Analyst)',
    'CS',
    'ICWA',
    'IAS',
    'IES',
    'IFS',
    'IRS',
    'IPS',
    'Other Degree in Service',
    'B.A.M.S.',
    'BDS',
    'BHMS',
    'BSMS',
    'BUMS',
    'BVSc',
    'MBBS',
    'MDS',
    'MD / MS (Medical)',
    'MVSc',
    'MCh',
    'DNB',
    'BPharm',
    'BPT',
    'B.Sc. Nursing',
    'M.Pharm',
    'MPT',
    'Other'
  ];

  List<String> employedInList = [
    'Private',
    'Government',
    'Business',
    'Self Employed',
    'Freelancer',
    'Retired',
    'Student',
    'Housewife',
    'Not Working',
    'Other',
  ];

  final List<String> occupationList = [
    'Software Professional',
    'Engineer',
    'Doctor',
    'Teacher',
    'Business Owner',
    'Accountant',
    'Lawyer',
    'Architect',
    'Consultant',
    'Artist',
    'Writer',
    'Sales Professional',
    'Marketing Professional',
    'Healthcare Worker',
    'Other',
  ];

  final List<String> incomeList = [
    '₹ 1 lakh & below',
    '₹ 1 lakh - ₹ 2 lakh',
    '₹ 2 lakh - ₹ 3 lakh',
    '₹ 3 lakh - ₹ 5 lakh',
    '₹ 5 lakh - ₹ 7 lakh',
    '₹ 7 lakh - ₹ 10 lakh',
    '₹ 10 lakh - ₹ 15 lakh',
    '₹ 15 lakh - ₹ 20 lakh',
    '₹ 20 lakh - ₹ 30 lakh',
    '₹ 30 lakh - ₹ 40 lakh',
    '₹ 40 lakh - ₹ 50 lakh',
    '₹ 50 lakh & above',
  ];
  bool selectedEdicationOther = false;
  bool selectedEmployedOther = false;
  bool selectedOccupationOther = false;
  bool selectedInComeOther = false;
  final educationCtrl = TextEditingController();
  final employedCtrl = TextEditingController();
  final occupationCtrl = TextEditingController();
  final inComeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userRegisterState = ref.watch(partnerPreferenceProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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

            selectedEdicationOther
                ? TextFormField(
                    controller: educationCtrl,
                    decoration: InputDecoration(
                        hintText: 'Education',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedEdicationOther = false;
                                selectedEdication.clear();
                                selectedEdication.add(educationCtrl.text);
                                print(selectedEdication);
                              });
                            },
                            icon: const Icon(Icons.close))),
                  )
                : AnyCustomPreferenceDropdown(
                    other: true,
                    value: selectedEdication,
                    hint: "Education",
                    items: educationList,
                    onChanged: (value) {
                      setState(() {
                        selectedEdication = value;
                        if (value[0] == 'Other') {
                          selectedEdicationOther = true;
                        }
                      });
                    },
                  ),
            const SizedBox(height: 10),

            selectedEmployedOther
                ? TextFormField(
                    controller: employedCtrl,
                    decoration: InputDecoration(
                        hintText: 'Employed In',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedEmployedOther = false;
                                selectedEmployed.clear();
                                selectedEmployed.add(employedCtrl.text);
                                print(selectedEmployed);
                              });
                            },
                            icon: const Icon(Icons.close))),
                  )
                : AnyCustomPreferenceDropdown(
                    other: true,
                    value: selectedEmployed,
                    hint: "Employed In",
                    items: employedInList,
                    onChanged: (value) {
                      setState(() {
                        selectedEmployed = value;
                        if (value[0] == 'Other') {
                          selectedEmployedOther = true;
                        }
                      });
                    },
                  ),
            const SizedBox(height: 10),

            // Occupation Dropdown
            selectedOccupationOther
                ? TextFormField(
                    controller: occupationCtrl,
                    decoration: InputDecoration(
                        hintText: 'Occupation',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedOccupationOther = false;
                                selectedOccupation.clear();
                                selectedOccupation.add(occupationCtrl.text);
                                print(selectedOccupation);
                              });
                            },
                            icon: const Icon(Icons.close))),
                  )
                : AnyCustomPreferenceDropdown(
                    other: true,
                    value: selectedOccupation,
                    hint: "Occupation",
                    items: occupationList,
                    onChanged: (value) {
                      setState(() {
                        selectedOccupation = value;
                        if (value[0] == 'Other') {
                          selectedOccupationOther = true;
                        }
                      });
                    },
                  ),
            const SizedBox(height: 10),

            selectedInComeOther
                ? TextFormField(
                    controller: inComeCtrl,
                    decoration: InputDecoration(
                        hintText: 'Annual Income',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                selectedInComeOther = false;
                                selectedIncome.clear();
                                selectedIncome.add(inComeCtrl.text);
                                print(selectedIncome);
                              });
                            },
                            icon: const Icon(Icons.close))),
                  )
                : AnyCustomPreferenceDropdown(
                    other: true,
                    value: selectedIncome,
                    hint: "Annual Income",
                    items: incomeList,
                    onChanged: (value) {
                      setState(() {
                        selectedIncome = value;
                        if (value[0] == 'Other') {
                          selectedInComeOther = true;
                        }
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
                          education: selectedEdication.firstOrNull,
                          employedIn: selectedEmployed.firstOrNull,
                          annualIncome: selectedIncome.firstOrNull,
                          profession: selectedOccupation.firstOrNull);
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
