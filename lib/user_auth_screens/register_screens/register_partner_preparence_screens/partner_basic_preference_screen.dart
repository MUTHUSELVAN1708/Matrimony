import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/age_height_comment_box.dart';
import 'package:matrimony/common/widget/preference_commen_dialog_box.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_religous_preference_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    final inputStates = ref.read(preferenceInputProvider.notifier);
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
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'You will be notified by us based on\nacceptable matches (your preferences will be considered)',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
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
                  CustomPreferenceDropdownField(
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

                        print("+++$selectedHeight");
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPreferenceDropdownField(
                    value: PartnerPreferenceConstData.maritalStatusOptions,
                    hint: 'Marital Status',
                    items: PartnerPreferenceConstData.maritalStatusOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedMaritalStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPreferenceDropdownField(
                    value: selectedMotherTongue,
                    hint: 'Mother Tongue',
                    items: PartnerPreferenceConstData.motherTongueOptions,
                    onChanged: (value) {
                      setState(() {
                        selectedMotherTongue = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomPreferenceDropdownField(
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
                  CustomPreferenceDropdownField(
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
                  CustomPreferenceDropdownField(
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
                  CustomPreferenceDropdownField(
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
                        List<List<int>> originalList = [
                          [19],
                          [21]
                        ];

                        List<int> firstList =
                            originalList.map((e) => e[0]).toList();
                        List<int> secondList = originalList[1];

                        // Assign values to inputState
                        inputStates.updatePreferenceInput(
                            userId: userId,
                            fromAge: firstList[0],
                            toAge: secondList[0],
                            height: selectedHeight.toString(),
                            motherTongue: selectedMotherTongue.toString(),
                            maritalStatus: selectedMaritalStatus.toString(),
                            drinkingHabits: selectedDrinkingHabits.toString(),
                            eatingHabits: selectedEatingHabits.toString(),
                            smokingHabits: selectedSmokingHabits.toString());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PartnerReligiousPreferenceScreen(),
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
