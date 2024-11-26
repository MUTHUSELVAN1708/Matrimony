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
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/common_selection_dialog.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';

class EditPartnerPreferencesLocation extends ConsumerStatefulWidget {
  const EditPartnerPreferencesLocation({
    super.key,
  });

  @override
  ConsumerState<EditPartnerPreferencesLocation> createState() =>
      _PartnerPreferenceBasicDetailScreenState();
}

class _PartnerPreferenceBasicDetailScreenState
    extends ConsumerState<EditPartnerPreferencesLocation> {
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
    editPartnerPreferenceProviderState.setLocationValues(ref.read(userManagementProvider).userPartnerDetails);
  }

  @override
  Widget build(BuildContext context) {
    final editPartnerPreferenceProviderState =
        ref.watch(editPartnerPreferenceProvider);
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
            _buildHeader(context, width),
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
          SizedBox(width: heightQuery * 0.20),
          const Text(
            'Edit Location',
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
                _buildCountrySelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(
                  height: 4,
                ),
                _buildStateSelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(
                  height: 4,
                ),
                _buildCitySelection(
                    context, ref, editPartnerPreferenceProviderState),
                const SizedBox(
                  height: 4,
                ),
                _buildOwnHouseSelection(
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
        'Location',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildCountrySelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Country',
            options: PartnerPreferenceConstData.countries,
            selectedValue: editPartnerPreferenceProviderState.country,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateCountry(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Country',
        editPartnerPreferenceProviderState.country,
      ),
    );
  }

  Widget _buildStateSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select State',
            options: PartnerPreferenceConstData
                .states[editPartnerPreferenceProviderState.country]!,
            selectedValue: editPartnerPreferenceProviderState.state,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateState(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'State',
        editPartnerPreferenceProviderState.state,
      ),
    );
  }

  Widget _buildCitySelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select City',
            options: PartnerPreferenceConstData
                .cities[editPartnerPreferenceProviderState.state]!,
            selectedValue: editPartnerPreferenceProviderState.city,
            onSelect: (value) {
              ref
                  .read(editPartnerPreferenceProvider.notifier)
                  .updateCity(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'City',
        editPartnerPreferenceProviderState.city,
      ),
    );
  }

  Widget _buildOwnHouseSelection(
    BuildContext context,
    WidgetRef ref,
    EditPartnerPreferenceState editPartnerPreferenceProviderState,
  ) {
    return GestureDetector(
      onTap: () {
        _selectHouse(context);
      },
      child: _buildListTile(
        'Own House',
        editPartnerPreferenceProviderState.isOwnHouse != null &&
                editPartnerPreferenceProviderState.isOwnHouse!
            ? 'Yes'
            : editPartnerPreferenceProviderState.isOwnHouse != null &&
                    !editPartnerPreferenceProviderState.isOwnHouse!
                ? 'No'
                : '',
      ),
    );
  }

  void _selectHouse(BuildContext context) {
    final editPartnerPreferenceProviderState =
        ref.watch(editPartnerPreferenceProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Own House')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  ref
                      .read(editPartnerPreferenceProvider.notifier)
                      .updateIsOwnHouse(true);
                  Navigator.pop(context, true);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: editPartnerPreferenceProviderState.isOwnHouse == true
                        ? const Color(0xFFFFCBCC)
                        : Colors.transparent,
                    border: Border.all(
                      color:
                          editPartnerPreferenceProviderState.isOwnHouse == true
                              ? Colors.transparent
                              : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              editPartnerPreferenceProviderState.isOwnHouse ==
                                      true
                                  ? Colors.black
                                  : Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  ref
                      .read(editPartnerPreferenceProvider.notifier)
                      .updateIsOwnHouse(false);
                  Navigator.pop(context, false);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        editPartnerPreferenceProviderState.isOwnHouse == false
                            ? const Color(0xFFFFCBCC)
                            : Colors.transparent,
                    border: Border.all(
                      color:
                          editPartnerPreferenceProviderState.isOwnHouse == false
                              ? Colors.transparent
                              : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontSize: 16,
                          color:
                              editPartnerPreferenceProviderState.isOwnHouse ==
                                      false
                                  ? Colors.black
                                  : Colors.grey),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
              .updateLocationDetails();
          ref
              .read(userManagementProvider.notifier)
              .updatePartnerLocationDetails(profileState);
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
