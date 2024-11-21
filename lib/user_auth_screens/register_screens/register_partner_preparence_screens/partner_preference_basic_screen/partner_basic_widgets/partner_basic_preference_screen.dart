import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/prefarence_height_comment_box.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/preference_age_dialogBox.dart';
import 'package:matrimony/common/widget/preference_any_dialogBox.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/common/widget/show_toastdialog.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/common_custom_optional_dropDown.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preparence_religion_screen/partner_religous_preference_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_partner_preference_notiffier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/preference_input_notifier.dart';

class RegisterPartnerBasicPreferenceScreen extends ConsumerStatefulWidget {
  const RegisterPartnerBasicPreferenceScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterPartnerBasicPreferenceScreen> createState() =>
      _RegisterPartnerBasicPreferenceScreenState();
}

class _RegisterPartnerBasicPreferenceScreenState
    extends ConsumerState<RegisterPartnerBasicPreferenceScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    userId = await SharedPrefHelper.getUserId();
    print(userId);
  }

  List<String> selectFromAge = [];
  String selectToAge = '';
  String selectFromHeight = '';
  String selectToHeight = '';
  List<String> selectedAge = [];
  List<String> selectedHeight = [];
  List<String> selectedMaritalStatus = [];
  List<String> selectedMotherTongue = [];
  List<String> selectedPhysicalStatus = [];
  List<String> selectedEatingHabits = [];
  List<String> selectedDrinkingHabits = [];
  List<String> selectedSmokingHabits = [];

  bool motherTongueOther = false;
  final motherTongueCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final inputStates = ref.read(preferenceInputProvider.notifier);
    final userRegisterState = ref.watch(partnerPreferenceProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: true,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    'Basic Preferences :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AgeCustomDialogBox(
                    value: selectFromAge,
                    hint: 'Age',
                    hint2: 'From Age',
                    hint3: 'To Age',
                    items: PartnerPreferenceConstData.toAgeList,
                    onChanged: (value) {
                      setState(() {
                        selectedAge = value;
                        selectFromAge = selectedAge;
                        // selectToAge = selectedAge[1];
                      });
                    },
                    ageheight: true,
                  ),
                  const SizedBox(height: 10),
                  HeightDropdownField(
                    value: selectedHeight,
                    hint: 'Height',
                    hint2: 'From Height',
                    hint3: 'To Height',
                    items: PartnerPreferenceConstData.myHeightOptions.values
                        .toList(),
                    ageheight: true,
                    onChanged: (value) {
                      setState(() {
                        selectedHeight = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  AnyCustomPreferenceDropdown(
                    value: selectedMaritalStatus,
                    hint: 'Marital Status',
                    items: PartnerPreferenceConstData.maritalStatusOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedMaritalStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  motherTongueOther
                      ? TextFormField(
                          onChanged: (value) {
                            setState(() {
                              selectedMotherTongue.clear();
                              selectedMotherTongue.add(motherTongueCtrl.text);
                            });
                          },
                          controller: motherTongueCtrl,
                          decoration: InputDecoration(
                              hintText: 'Mother Tongue',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      motherTongueOther = false;
                                    });
                                  },
                                  icon: const Icon(Icons.close)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        )
                      : AnyCustomPreferenceDropdown(
                          other: true,
                          value: selectedMotherTongue,
                          hint: 'Mother Tongue',
                          items: PartnerPreferenceConstData.motherTongueOptions,
                          onChanged: (value) {
                            setState(() {
                              selectedMotherTongue = value;
                              if (value[0] == 'Other') {
                                motherTongueOther = true;
                              }
                            });
                          },
                        ),
                  const SizedBox(height: 10),
                  PreferenceOptionalCustomDropdown(
                    value: selectedPhysicalStatus,
                    hint: 'Physical Status',
                    items: PartnerPreferenceConstData.physicalStatusOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedPhysicalStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  PreferenceOptionalCustomDropdown(
                    value: selectedEatingHabits,
                    hint: 'Eating Habits(Optional)',
                    items: PartnerPreferenceConstData.eatingHabitsOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedEatingHabits = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  PreferenceOptionalCustomDropdown(
                    value: selectedDrinkingHabits,
                    hint: 'Drinking Habits(Optional)',
                    items: PartnerPreferenceConstData.drinkingHabitsOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedDrinkingHabits = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  PreferenceOptionalCustomDropdown(
                    value: selectedSmokingHabits,
                    hint: 'Smoking Habits(Optional)',
                    items: PartnerPreferenceConstData.smokingHabitsOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedSmokingHabits = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final age = selectedAge.firstOrNull
                            ?.replaceAll('[', '')
                            .replaceAll(']', '')
                            .split(' ');
                        final height = selectedHeight.firstOrNull
                            ?.replaceAll('[', '')
                            .replaceAll(']', '')
                            .split('-');
                        inputStates.updatePreferenceInput(
                            userId: userId,
                            fromAge: age != null ? int.tryParse(age[0]) : null,
                            toAge: age != null ? int.tryParse(age[1]) : null,
                            fromHeight: height != null ? height[0] : null,
                            toHeight: height != null ? height[1] : null,
                            motherTongue: selectedMotherTongue.firstOrNull,
                            maritalStatus: selectedMaritalStatus.firstOrNull,
                            physicalStatus: selectedPhysicalStatus.firstOrNull,
                            drinkingHabits: selectedDrinkingHabits.firstOrNull,
                            eatingHabits: selectedEatingHabits.firstOrNull,
                            smokingHabits: selectedSmokingHabits.firstOrNull);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PartnerReligiousPreferenceScreen(),
                          ),
                        );
                        //                           ToastDialog.showToast(
                        // context,
                        // message: 'Your operation was completed successfully!',
                        // isSuccess: true,
                        //   );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
          ),
        ),
      ),
    );
  }
}
