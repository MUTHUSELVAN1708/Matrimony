import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/edit/profile/data/profile_options.dart';
import 'package:matrimony/edit/profile/notifier/profile_notifier.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_state.dart';
import 'package:matrimony/edit_partner_preferences/screens/edit_partner_preference_dialog.dart';
import 'package:matrimony/edit_partner_preferences/screens/edit_partner_preferences_height_dialog.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import '../../common/colors.dart';
import '../../common/widget/common_selection_dialog.dart';
import '../../common/widget/custom_snackbar.dart';
import '../../common/widget/custom_text_field.dart';
import '../../service/date_picker.dart';
import '../../user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/prefarence_height_comment_box.dart';
import '../../user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/preference_age_dialogBox.dart';

class EditPartnerPreferenceBasicDetailScreen extends ConsumerStatefulWidget {
  const EditPartnerPreferenceBasicDetailScreen({
    super.key,
  });

  @override
  ConsumerState<EditPartnerPreferenceBasicDetailScreen> createState() =>
      _PartnerPreferenceBasicDetailScreenState();
}

class _PartnerPreferenceBasicDetailScreenState
    extends ConsumerState<EditPartnerPreferenceBasicDetailScreen> {
  List<String> selectedAge = [];
  List<String> selectWeight = [];
  List<String> selectedHeight = [];

  @override
  void initState() {
    super.initState();
    getValues();
  }

  Future<void> getValues() async {
    await Future.delayed(Duration.zero);
    final editPartnerPreferenceProviderState =
        ref.read(editPartnerPreferenceProvider.notifier);
    editPartnerPreferenceProviderState.resetState();
    ref.read(userManagementProvider.notifier).getUserDetails(2);
    // editPartnerPreferenceProviderState.setValuesInitial('20 - 25',
    //     '4 ft 7 in(139 cm)', '49 - 55', 'widowed', 'Normal', 'karnadaka');
  }

  @override
  Widget build(BuildContext context) {
    final editPartnerPreferenceProviderState =
        ref.watch(editPartnerPreferenceProvider);
    final heightQuery = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(bottom: heightQuery * 0.2),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/initialimage.png'),
                  // Use your image path here
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            _buildHeader(context, heightQuery),
            _buildForm(
                context, ref, editPartnerPreferenceProviderState, heightQuery),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double heightQuery) {
    return Positioned(
      top: 40,
      left: 16,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              // onPop('true');
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          SizedBox(width: heightQuery * 0.15),
          const Text(
            'Edit Basic Details',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
    double heightQuery,
  ) {
    return Positioned(
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
                _buildTitle(),
                const SizedBox(height: 16),
                EditPartnerPreferenceDialog(
                  value: selectedAge,
                  hint: 'Age',
                  hint2: 'From Age',
                  hint3: 'To Age',
                  items: PartnerPreferenceConstData.toAgeList,
                  onChanged: (value) {
                    setState(() {
                      selectedAge = value;
                    });
                  },
                  ageheight: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                EditPartnerPreferencesHeightDialog(
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
                const SizedBox(
                  height: 4,
                ),
                EditPartnerPreferenceDialog(
                  value: selectWeight,
                  hint: 'Weight',
                  hint2: 'From Weight',
                  hint3: 'To Weight',
                  items: PartnerPreferenceConstData.weightListPartner,
                  onChanged: (value) {
                    setState(() {
                      selectWeight = value;
                      // selectToAge = selectedAge[1];
                    });
                  },
                  ageheight: true,
                ),
                _buildMaritalStatusSelection(
                    context, ref, editPartnerPreferenceProviderState),
                _buildPhysicalStatusSelection(
                    context, ref, editPartnerPreferenceProviderState),
                _buildMotherTongueSelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(height: 24),
                _buildSaveButton(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Basic Details',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildMaritalStatusSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Marital Status',
            options: ProfileOptions.maritalStatus,
            selectedValue: editPartnerPreferenceProviderState.maritalStatus,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateMaritalStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Marital Status',
        editPartnerPreferenceProviderState.maritalStatus,
      ),
    );
  }

  Widget _buildPhysicalStatusSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Physical Status',
            options: ProfileOptions.physicalStatus,
            selectedValue: editPartnerPreferenceProviderState.physicalStatus,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updatePhysicalStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Physical Status',
        editPartnerPreferenceProviderState.physicalStatus,
      ),
    );
  }

  Widget _buildMotherTongueSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Mother Tongue',
            options: PartnerPreferenceConstData.motherTongueOptions,
            selectedValue: editPartnerPreferenceProviderState.eatingHabits,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateMotherTongue(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Mother Tongue',
        editPartnerPreferenceProviderState.eatingHabits,
      ),
    );
  }

  Widget _buildDrinkingHabitsSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Drinking Habit',
            options: ProfileOptions.drinkingHabits,
            selectedValue: editPartnerPreferenceProviderState.drinkingHabits,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateDrinkingHabits(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Drinking Habits',
        editPartnerPreferenceProviderState.drinkingHabits,
      ),
    );
  }

  Widget _buildSmokingHabitsSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Smoking Habit',
            options: ProfileOptions.smokingHabits,
            selectedValue: profileState.smokingHabits,
            onSelect: (value) {
              ref
                  .read(profileProvider.notifier)
                  .updateSmokingHabitsStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Smoking Habits',
        profileState.smokingHabits,
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState profileState,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final age = selectedAge.isNotEmpty
              ? selectedAge[0]
                  .replaceAll(RegExp(r'[\[\]]'), '')
                  .split(' ')
                  .join(' - ')
              : '';
          final height = selectedHeight[0];
          final weight = selectWeight.isNotEmpty
              ? selectWeight[0]
                  .replaceAll(RegExp(r'[\[\]]'), '')
                  .split(' ')
                  .join(' - ')
              : '';
          ref
              .read(editPartnerPreferenceProvider.notifier)
              .setValues(age, height, weight);
          if (true) {
            Future.delayed(const Duration(microseconds: 50), () {
              // Navigator.pop(context);
              // onPop('true');
            })
                .then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Profile updated successfully!',
              );
            });
            // Handle save logic
          } else {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
              // onPop('true');
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Profile updated successfully!',
              );
            });

            // CustomSnackBar.show(
            //   context: context,
            //   message: 'Please fill all required fields and ensure age is 18+',
            //   isError: true,
            // );
          }
        },
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
    );
  }

  Widget _buildListTile(String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        subtitle == '' ? 'Select' : subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
