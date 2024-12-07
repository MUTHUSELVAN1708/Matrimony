import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
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

class EditPartnerPreferencesHobbiesLifestyle extends ConsumerStatefulWidget {
  const EditPartnerPreferencesHobbiesLifestyle({
    super.key,
  });

  @override
  ConsumerState<EditPartnerPreferencesHobbiesLifestyle> createState() =>
      _PartnerPreferenceBasicDetailScreenState();
}

class _PartnerPreferenceBasicDetailScreenState
    extends ConsumerState<EditPartnerPreferencesHobbiesLifestyle> {
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
    editPartnerPreferenceProviderState.setLifeStyleValues(
        ref.read(userManagementProvider).userPartnerDetails);
  }

  @override
  Widget build(BuildContext context) {
    final editPartnerPreferenceProviderState =
        ref.watch(editPartnerPreferenceProvider);
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: EnhancedLoadingWrapper(
        isLoading: editPartnerPreferenceProviderState.isLoading ||
            ref.watch(allMatchesProvider).isLoading,
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
              _buildHeader(context, width),
              _buildForm(context, ref, editPartnerPreferenceProviderState,
                  heightQuery),
            ],
          ),
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
          SizedBox(width: heightQuery * 0.20),
          const Text(
            'Edit Hobbies & Life Style',
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
                const SizedBox(
                  height: 4,
                ),
                _buildEatingHabitsSelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(
                  height: 4,
                ),
                _buildDrinkingHabitsSelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(
                  height: 4,
                ),
                _buildSmokingHabitsSelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(
                  height: 4,
                ),
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
        'Hobbies & Life Style',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildEatingHabitsSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Eating Habit',
            options: ProfileOptions.eatingHabits,
            selectedValue: editPartnerPreferenceProviderState.eatingHabits,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateEatingHabits(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Eating Habits',
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
            title: 'Select Drinking Habit',
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
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Smoking Habit',
            options: ProfileOptions.smokingHabits,
            selectedValue: editPartnerPreferenceProviderState.smokingHabits,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateSmokingHabits(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Smoking Habits',
        editPartnerPreferenceProviderState.smokingHabits,
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
          final result = await ref
              .read(editPartnerPreferenceProvider.notifier)
              .updateLifeStyleDetails();
          await ref.read(allMatchesProvider.notifier).allMatchDataFetch();
          ref
              .read(userManagementProvider.notifier)
              .updatePartnerLifeStyleDetails(profileState);
          if (result) {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Partner Preference updated successfully!',
              );
            });
          } else {
            CustomSnackBar.show(
              isError: true,
              context: context,
              message: 'Something Went wrong. Please Try Again!',
            );
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
