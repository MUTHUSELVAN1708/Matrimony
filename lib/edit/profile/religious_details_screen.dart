import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
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

class ReligiousDetailsScreen extends ConsumerStatefulWidget {
  final Function(String? value) onPop;

  const ReligiousDetailsScreen({
    super.key,
    required this.onPop,
  });

  @override
  ConsumerState<ReligiousDetailsScreen> createState() =>
      _ReligiousDetailsScreenState();
}

class _ReligiousDetailsScreenState
    extends ConsumerState<ReligiousDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getValues();
  }

  Future<void> getValues() async {
    await Future.delayed(Duration.zero);
    ref.read(religiousProvider.notifier).disposeState();
    ref
        .read(religiousProvider.notifier)
        .setReligiousDetails(ref.read(userManagementProvider).userDetails);
    await ref.read(userManagementProvider.notifier).getLocalData();
    await ref.read(religiousProvider.notifier).getReligiousDetails();
  }

  @override
  Widget build(BuildContext context) {
    final religiousState = ref.watch(religiousProvider);
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return EnhancedLoadingWrapper(
      isLoading: religiousState.isLoading,
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            widget.onPop('true');
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              _buildHeader(context, width),
              _buildForm(context, ref, religiousState, heightQuery),
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
              widget.onPop('true');
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
      top: heightQuery * 0.2,
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
                const SizedBox(height: 6),
                _buildReligionSelection(context, ref, religiousState),
                const SizedBox(height: 6),
                _buildCasteSelection(context, ref, religiousState),
                const SizedBox(height: 6),
                _buildSubCasteSelection(context, ref, religiousState),
                const SizedBox(height: 6),
                _buildMotherTongueSelection(context, ref, religiousState),
                const SizedBox(height: 6),
                _buildMarryFromOtherCommunitiesToggle(ref, religiousState),
                const SizedBox(height: 6),
                _buildStarSelection(context, ref, religiousState),
                const SizedBox(height: 6),
                _buildRaasiSelection(context, ref, religiousState),
                const SizedBox(height: 6),
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
            options: religiousState.religionList
                .map((religion) => religion.religion)
                .toList(),
            selectedValue: religiousState.religion ?? 'Select',
            onSelect: (value) async {
              ref.read(religiousProvider.notifier).updateReligion(value);
              if (value != religiousState.religion) {
                await ref
                    .read(religiousProvider.notifier)
                    .getCasteDetailsList();
              }
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
            options:
                religiousState.casteList.map((caste) => caste.castes).toList(),
            selectedValue: religiousState.caste ?? "Select",
            onSelect: (value) async {
              ref.read(religiousProvider.notifier).updateCaste(value);
              if (value != religiousState.caste) {
                await ref
                    .read(religiousProvider.notifier)
                    .getSubCasteDetailsList();
              }
            },
          ),
        );
      },
      child: _buildListTile(
        'Caste',
        religiousState.caste == null || religiousState.caste == ''
            ? "Select"
            : religiousState.caste.toString(),
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
            options: religiousState.subCasteList
                .map((subCaste) => subCaste.subCaste)
                .toList(),
            selectedValue: religiousState.subCaste ?? "Select",
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateSubCaste(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Sub Caste',
        religiousState.subCaste == null || religiousState.subCaste == ''
            ? "Select"
            : religiousState.subCaste.toString(),
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
            selectedValue: religiousState.motherTongue ?? 'Select',
            onSelect: (value) {
              ref.read(religiousProvider.notifier).updateMotherTongue(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Mother Tongue',
        religiousState.motherTongue ?? 'Select',
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
      trailing: Transform.scale(
        scale: 0.7,
        child: Switch(
          value: religiousState.willingToMarryOtherCommunities ?? false,
          onChanged: (bool value) {
            ref.read(religiousProvider.notifier).updateWillingToMarry(value);
          },
          activeColor: AppColors.primaryButtonColor,
        ),
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
        onPressed: () async {
          final result = await ref
              .read(religiousProvider.notifier)
              .updateReligiousDetails();
          ref
              .read(userManagementProvider.notifier)
              .updateReligiousDetails(religiousState);
          if (result) {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
              widget.onPop('true');
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Profile updated successfully!',
              );
            });
          } else {
            CustomSnackBar.show(
              isError: false,
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
