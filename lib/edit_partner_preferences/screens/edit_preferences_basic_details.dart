import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/reverpod/get_all_matches_notifier.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/data/profile_options.dart';
import 'package:matrimony/edit/profile/notifier/profile_notifier.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_state.dart';
import 'package:matrimony/edit_partner_preferences/screens/edit_partner_preference_age_and_weight.dart';
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
  late List<String> selectedHeight = [];

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
    editPartnerPreferenceProviderState
        .setValuesInitial(ref.read(userManagementProvider).userPartnerDetails);
  }

  @override
  Widget build(BuildContext context) {
    final editPartnerPreferenceProviderState =
        ref.watch(editPartnerPreferenceProvider);
    final heightQuery = MediaQuery.of(context).size.height;
    selectedHeight.add(
        ref.read(userManagementProvider).userPartnerDetails.partnerFromHeight ??
            '');
    selectedHeight.add(
        ref.read(userManagementProvider).userPartnerDetails.partnerToHeight ??
            '');
    return EnhancedLoadingWrapper(
      isLoading: editPartnerPreferenceProviderState.isLoading ||
          ref.watch(allMatchesProvider).isLoading,
      child: Material(
        color: Colors.transparent,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                AgeSelectionDialog(
                  hint: 'Age',
                  toValue: ref
                      .read(userManagementProvider)
                      .userPartnerDetails
                      .partnerToAge,
                  fromValue: ref
                      .read(userManagementProvider)
                      .userPartnerDetails
                      .partnerFromAge,
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
                    if (selectedHeight.isNotEmpty) {
                      ref
                          .read(editPartnerPreferenceProvider.notifier)
                          .updateFromHeight(
                              value.first.split('-').first.trim());
                      ref
                          .read(editPartnerPreferenceProvider.notifier)
                          .updateToHeight(value.first.split('-').last.trim());
                    }
                  },
                ),
                const SizedBox(
                  height: 4,
                ),
                AgeSelectionDialog(
                  hint: 'Weight',
                  toValue: ref
                      .read(userManagementProvider)
                      .userPartnerDetails
                      .partnerFromWeight,
                  fromValue: ref
                      .read(userManagementProvider)
                      .userPartnerDetails
                      .partnerToWeight,
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
            options: ProfileOptions.maritalStatusPartner,
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
            options: const [...PartnerPreferenceConstData.motherTongueOptions],
            selectedValue: editPartnerPreferenceProviderState.motherTongue,
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
        editPartnerPreferenceProviderState.motherTongue,
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
          final editPreference = ref.watch(editPartnerPreferenceProvider);
          final result = await ref
              .read(editPartnerPreferenceProvider.notifier)
              .updateBasicDetails();
          await ref.read(allMatchesProvider.notifier).allMatchDataFetch();
          ref
              .read(userManagementProvider.notifier)
              .updatePartnerBasicDetails(editPreference);
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
