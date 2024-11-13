import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';
import '../../common/colors.dart';
import '../../common/widget/common_selection_dialog.dart';
import '../../common/widget/custom_snackbar.dart';
import '../../common/widget/custom_text_field.dart';
import '../../service/date_picker.dart';
import 'data/profile_options.dart';
import 'data/religious_options.dart';
import 'notifier/profile_notifier.dart';
import 'state/religious_state.dart';
import 'providers/religious_provider.dart';

class ReligiousDetailsScreen extends ConsumerWidget {
  final Function(String? value) onPop;

  const ReligiousDetailsScreen({
    super.key,
    required this.onPop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final religiousState = ref.watch(religiousProvider);
    final heightQuery = MediaQuery.of(context).size.height;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          _buildHeader(context, heightQuery),
          _buildForm(context, ref, religiousState, heightQuery),
        ],
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
              onPop('true');
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
            'Religious Information',
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
      ReligiousState religiousState,
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
                _buildReligionSelection(context, ref, religiousState),
                const SizedBox(height: 16),
                _buildCasteSelection(context, ref, religiousState),
                const SizedBox(height: 16),
                _buildSubCasteSelection(context, ref, religiousState),
                const SizedBox(height: 16),
                _buildMotherTongueSelection(context, ref, religiousState),
                const SizedBox(height: 16),
                _buildMarryFromOtherCommunitiesToggle(ref, religiousState),
                const SizedBox(height: 16),
                _buildStarSelection(context, ref, religiousState),
                const SizedBox(height: 16),
                _buildRaasiSelection(context, ref, religiousState),
                const SizedBox(height: 24),
                _buildSaveButton(context, ref, religiousState),
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
        'Religious Information',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildReligionSelection(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Religion',
            options: ReligiousOptions.religions,
            selectedValue: religiousState.religion ?? 'Select',
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateReligion(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Religion',
        religiousState.religion ?? 'Select',
      ),
    );
  }

  Widget _buildCasteSelection(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Caste',
            options: ReligiousOptions.castes,
            selectedValue: religiousState.caste ?? "don't wish to specify",
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateCaste(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Caste',
        religiousState.caste ?? "don't wish to specify",
      ),
    );
  }

  Widget _buildSubCasteSelection(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Sub Caste',
            options: ReligiousOptions.subCastes,
            selectedValue: religiousState.subCaste ?? "don't wish to specify",
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateSubCaste(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Sub Caste',
        religiousState.subCaste ?? "don't wish to specify",
      ),
    );
  }

  Widget _buildMotherTongueSelection(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Mother Tongue',
            options: ReligiousOptions.motherTongues,
            selectedValue: religiousState.motherTongue ?? '-',
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateMotherTongue(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Mother Tongue',
        religiousState.motherTongue ?? '-',
      ),
    );
  }

  Widget _buildMarryFromOtherCommunitiesToggle(
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('Willing To Marry From Other Communities'),
      trailing: Switch(
        value: religiousState.willingToMarryOtherCommunities ?? false,
        onChanged: (bool value) {
          ref.read(religiousProvider.notifier).updateWillingToMarry(value);
        },
        activeColor: AppColors.primaryButtonColor,
      ),
    );
  }

  Widget _buildStarSelection(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Star',
            options: ReligiousOptions.stars,
            selectedValue: religiousState.star ?? 'Select',
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateStar(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Star',
        religiousState.star ?? 'Select',
      ),
    );
  }

  Widget _buildRaasiSelection(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Raasi/Moon Sign',
            options: ReligiousOptions.raasis,
            selectedValue: religiousState.raasi ?? 'Select',
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateRaasi(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Raasi / Moon Sign',
        religiousState.raasi ?? 'Select',
      ),
    );
  }

  Widget _buildSaveButton(
      BuildContext context,
      WidgetRef ref,
      ReligiousState religiousState,
      ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (ref.read(profileProvider.notifier).validateProfile()) {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
              onPop('true');
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Profile updated successfully!',
              );
            });
          } else {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
              onPop('true');
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Profile updated successfully!',
              );
            });
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
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}