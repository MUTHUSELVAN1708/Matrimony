import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';
import '../../common/colors.dart';
import '../../common/widget/common_selection_dialog.dart';
import '../../common/widget/custom_snackbar.dart';
import '../../common/widget/custom_text_field.dart';
import '../../service/date_picker.dart';
import 'data/profile_options.dart';
import 'notifier/profile_notifier.dart';

class EditBasicDetailScreen extends ConsumerStatefulWidget {
  final Function(String? value) onPop;

  const EditBasicDetailScreen({
    super.key,
    required this.onPop,
  });

  @override
  ConsumerState<EditBasicDetailScreen> createState() =>
      _EditBasicDetailScreenState();
}

class _EditBasicDetailScreenState extends ConsumerState<EditBasicDetailScreen> {
  @override
  void initState() {
    super.initState();
    getValues();
  }

  Future<void> getValues() async {
    await Future.delayed(Duration.zero);
    ref.read(profileProvider.notifier).disposeState();
    ref
        .read(profileProvider.notifier)
        .setBasicDetails(ref.read(userManagementProvider).userDetails);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final heightQuery = MediaQuery.of(context).size.height;

    return EnhancedLoadingWrapper(
      isLoading: profileState.isLoading,
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
              _buildHeader(context, heightQuery),
              _buildForm(context, ref, profileState, heightQuery),
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
          SizedBox(width: heightQuery * 0.15),
          const Text(
            'Basic Details',
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
    ProfileState profileState,
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
                const SizedBox(height: 16),
                _buildProfileSelection(context, ref, profileState),
                _buildNameField(context, ref, profileState),
                _buildDateOfBirthField(context, ref, profileState),
                _buildHeightSelection(context, ref, profileState),
                _buildWeightSelection(context, ref, profileState),
                _buildSkinToneSelection(context, ref, profileState),
                _buildMaritalStatusSelection(context, ref, profileState),
                _buildPhysicalStatusSelection(context, ref, profileState),
                _buildEatingHabitsSelection(context, ref, profileState),
                _buildDrinkingHabitsSelection(context, ref, profileState),
                _buildSmokingHabitsSelection(context, ref, profileState),
                const SizedBox(height: 24),
                _buildSaveButton(context, ref, profileState),
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

  Widget _buildProfileSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Profile Type',
            options: ProfileOptions.profileCreatedFor,
            selectedValue: profileState.selectedProfile,
            onSelect: (value) {
              ref.read(profileProvider.notifier).updateProfile(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Profile Created For',
        profileState.selectedProfile ?? 'Select',
      ),
    );
  }

  Widget _buildHeightSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Height',
            options: ProfileOptions.height,
            selectedValue: profileState.selectedHeight,
            onSelect: (value) {
              ref.read(profileProvider.notifier).updateHeight(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Height',
        profileState.selectedHeight ?? 'Select',
      ),
    );
  }

  Widget _buildWeightSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Weight Range',
            options: ProfileOptions.weight,
            selectedValue: profileState.selectedWeight,
            onSelect: (value) {
              ref.read(profileProvider.notifier).updateWeight(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Weight',
        profileState.selectedWeight ?? 'Select',
      ),
    );
  }

  Widget _buildSkinToneSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Skin Tone',
            options: ProfileOptions.skinTones,
            selectedValue: profileState.skinTone,
            onSelect: (value) {
              ref.read(profileProvider.notifier).updateSkinTone(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Skin Tone',
        profileState.skinTone ?? 'Select',
      ),
    );
  }

  Widget _buildMaritalStatusSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Marital Status',
            options: ProfileOptions.maritalStatus,
            selectedValue: profileState.maritalStatus,
            onSelect: (value) {
              ref.read(profileProvider.notifier).updateMaritalStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Marital Status',
        profileState.maritalStatus ?? 'Select',
      ),
    );
  }

  Widget _buildPhysicalStatusSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Physical Status',
            options: ProfileOptions.physicalStatusForUser,
            selectedValue: profileState.physicalStatus,
            onSelect: (value) {
              ref.read(profileProvider.notifier).updatePhysicalStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Physical Status',
        profileState.physicalStatus ?? 'Select',
      ),
    );
  }

  Widget _buildEatingHabitsSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Eating Habit',
            options: ProfileOptions.eatingHabitsForUser,
            selectedValue: profileState.eatingHabits,
            onSelect: (value) {
              ref
                  .read(profileProvider.notifier)
                  .updateEatingHabitsStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Eating Habit',
        profileState.eatingHabits ?? 'Select',
      ),
    );
  }

  Widget _buildDrinkingHabitsSelection(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Your Drinking Habit',
            options: ProfileOptions.drinkingHabitsForUser,
            selectedValue: profileState.drinkingHabits,
            onSelect: (value) {
              ref
                  .read(profileProvider.notifier)
                  .updateDrinkingHabitsStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Drinking Habits',
        profileState.drinkingHabits ?? 'Select',
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
            options: ProfileOptions.smokingHabitsForUser,
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
        profileState.smokingHabits ?? 'Select',
      ),
    );
  }

  Widget _buildNameField(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () =>
          _showNameDialog(context, ref, profileState.selectedName ?? '-'),
      child: _buildListTile(
        'Name',
        profileState.selectedName == null || profileState.selectedName!.isEmpty
            ? 'Enter Name'
            : profileState.selectedName!,
      ),
    );
  }

  Widget _buildDateOfBirthField(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return GestureDetector(
      onTap: () => _showDatePicker(context, ref),
      child: _buildListTile(
        'Age / Date of Birth',
        DatePickerService.formatDateWithAge(profileState.selectedDateOfBirth),
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    WidgetRef ref,
    ProfileState profileState,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          if (ref.read(profileProvider.notifier).validateProfile()) {
            final result =
                await ref.read(profileProvider.notifier).updateBasicDetails();
            await ref.read(getImageApiProvider.notifier).getImage();
            ref
                .read(userManagementProvider.notifier)
                .updateBasicDetails(profileState);
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
                isError: true,
                context: context,
                message: 'Something Went wrong. Please Try Again!',
              );
            }
          } else {
            CustomSnackBar.show(
              isError: false,
              context: context,
              message: 'Name, Date of Birth and ProfileFor must Not be Empty!',
            );
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

  void _showNameDialog(
      BuildContext context, WidgetRef ref, String currentName) {
    final TextEditingController controller =
        TextEditingController(text: currentName == '-' ? '' : currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        title: const Text(
          'Enter Name',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        content: CustomTextFieldWidget(
          controller: controller,
          hintText: 'Enter your name',
          initialValue: controller.text,
          isEnabled: true,
        ),
        actions: [
          SizedBox(
            width: 100,
            height: 38,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.cancelBtnColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            width: 100,
            height: 38,
            child: ElevatedButton(
              onPressed: () {
                ref
                    .read(profileProvider.notifier)
                    .updateName(controller.text.trim());
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context, WidgetRef ref) async {
    final DateTime? picked =
        await DatePickerService.showCustomDatePicker(context);

    if (picked != null) {
      if (DatePickerService.isValidAge(picked)) {
        ref.read(profileProvider.notifier).updateDateOfBirth(picked);
      } else {
        CustomSnackBar.show(
          context: context,
          message: 'Age must be 18 years or older',
          isError: true,
        );
      }
    }
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
