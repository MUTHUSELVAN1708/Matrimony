import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/widget/preference_any_dialogBox.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/common/widget/show_toastdialog.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/location_widget/common_location_dropdown.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preparence_religion_screen/riverpod/religious_api_notifier.dart';
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
  List<String> selectedReligion = [];
  List<String> selectedCaste = [];
  List<String> selectedSubCaste = [];
  List<String> selectedStar = [];
  List<String> selectedDosham = [];
  List<String> selectedRassi = [];

  final List<String> starList = [
    'Ashwini (அஸ்வினி)',
    'Bharani (பரணி)',
    'Krittika (கிருத்திகை)',
    'Rohini (ரோகிணி)',
    'Mrigashira (மிருகசீரிடம்)',
    'Ardra (திருவாதிரை)',
    'Punarvasu (புனர்பூசம்)',
    'Pushya (பூசம்)',
    'Ashlesha (ஆயில்யம்)',
    'Magha (மகம்)',
    'Purva Phalguni (பூரம்)',
    'Uttara Phalguni (உத்திரம்)',
    'Hasta (அஸ்தம்)',
    'Chitra (சித்திரை)',
    'Swati (ஸ்வாதி)',
  ];

  final List<String> doshamList = [
    'Yes',
    'No',
    'Don\'t Know',
    'Not Applicable',
    'Unclear',
    'Inconclusive',
    'May be',
    'Not Specified',
    'Confirmed',
    'Pending',
    'Under Consideration',
    'Suggested',
    'Review Pending',
    'Referred',
    'Rejected',
  ];

  final List<String> rassiList = [
    "Aries",
    "Taurus",
    "Gemini",
    "Cancer",
    "Leo",
    "Virgo",
    "Libra",
    "Scorpio",
    "Sagittarius",
    "Capricorn",
    "Aquarius",
    "Pisces"
  ];

  @override
  void initState() {
    super.initState();
    getReligious();
  }

  Future<void> getReligious() async {
    await Future.delayed(Duration.zero);
    ref.read(religiousProvider.notifier).getReligiousData();
  }

  @override
  Widget build(BuildContext context) {
    final inputState = ref.read(preferenceInputProvider.notifier);
    final partnerRegisterState = ref.watch(partnerPreferenceProvider);
    final religionState = ref.watch(religiousProvider);
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
                  'Religious Preferences:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),

                PreferenceLocationDropdown(
                  showSearch: true,
                  value: selectedReligion,
                  hint: "Religion",
                  items: religionState.data
                      .map((religiousModel) => religiousModel.religion)
                      .toList(),
                  onChanged: (value) async {
                    setState(() {
                      selectedReligion = value;
                    });

                    int? stateId;
                    for (var e in religionState.data) {
                      if (e.religion == selectedReligion[0]) {
                        stateId = e.id;
                        break;
                      }
                    }

                    print("Selected State ID: $stateId");
                    if (stateId != null) {
                      await ref
                          .read(religiousProvider.notifier)
                          .getCasteData('$stateId');
                    } else {
                      print("No state ID found for the selected country.");
                    }
                  },
                ),

                selectedReligion.isEmpty || religionState.casteList.isEmpty
                    ? SizedBox()
                    : const SizedBox(height: 10),

                selectedReligion.isEmpty || religionState.casteList.isEmpty
                    ? SizedBox()
                    : PreferenceLocationDropdown(
                        showSearch: true,
                        value: selectedCaste,
                        hint: "Caste",
                        items: religionState.casteList
                            .map((religiousModel) => religiousModel.caste)
                            .toList(),
                        onChanged: (value) async {
                          setState(() {
                            selectedCaste = value;
                          });

                          int? stateId;
                          for (var e in religionState.casteList) {
                            if (e.caste == selectedCaste[0]) {
                              stateId = e.id;
                              break;
                            }
                          }

                          print("Selected State ID: $stateId");
                          if (stateId != null) {
                            await ref
                                .read(religiousProvider.notifier)
                                .getSubCasteData("$stateId");
                          } else {
                            print(
                                "No state ID found for the selected country.");
                          }
                        },
                      ),
                selectedCaste.isEmpty || religionState.subCasteList.isEmpty
                    ? SizedBox()
                    : const SizedBox(height: 10),
                selectedCaste.isEmpty || religionState.subCasteList.isEmpty
                    ? SizedBox()
                    : PreferenceLocationDropdown(
                        showSearch: true,
                        value: selectedSubCaste,
                        hint: "SubCaste",
                        items: religionState.subCasteList
                            .map((subCasteModel) => subCasteModel.subCaste)
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedSubCaste = value;
                          });
                        },
                      ),
                const SizedBox(height: 10),

                AnyCustomPreferenceDropdown(
                  value: selectedStar,
                  hint: "Star(Optional)",
                  items: starList,
                  onChanged: (value) {
                    setState(() {
                      selectedStar = value;
                    });
                  },
                ),
                const SizedBox(height: 10),
                AnyCustomPreferenceDropdown(
                  value: selectedRassi,
                  hint: "Rassi(Optional)",
                  items: rassiList,
                  onChanged: (value) {
                    setState(() {
                      selectedRassi = value;
                    });
                  },
                ),
                // const SizedBox(height: 10),
                // // Dosham Dropdown
                // AnyCustomPreferenceDropdown(
                //   value: selectedDosham,
                //   hint: "Dosham(Optional)",
                //   items: doshamList,
                //   onChanged: (value) {
                //     setState(() {
                //       selectedDosham = value;
                //     });
                //   },
                // ),
                const SizedBox(height: 16),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ref
                          .read(preferenceInputProvider.notifier)
                          .updatePreferenceInput(
                              religion: selectedReligion.toString(),
                              caste: selectedCaste.toString(),
                              subcaste: selectedSubCaste.toString(),
                              star: selectedStar.toString(),
                              rassi: selectedRassi.toString(),
                              dosham: selectedDosham.toString());

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PartnerProfessionalScreen(),
                        ),
                      );
                      //                       ToastDialog.showToast(
                      //   context,
                      //   message: 'Something went wrong. Please try again.',
                      //   isSuccess: false,
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: partnerRegisterState.isLoading
                        ? const Center(
                            child: SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                )),
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
        ),
      ),
    );
  }
}
