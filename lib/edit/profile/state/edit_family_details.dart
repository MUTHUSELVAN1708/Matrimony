import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/family_details_const_data.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/notifier/family_details_nofifier.dart';
import 'package:matrimony/edit/profile/providers/family_details_state.dart';
import 'package:matrimony/edit/profile/providers/location_provider.dart';
import 'package:matrimony/edit/profile/state/location_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/common_selection_dialog.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/custom_text_field.dart';

class EditFamilyDetails extends ConsumerStatefulWidget {
  final Function(String? value) onPop;

  const EditFamilyDetails({
    super.key,
    required this.onPop,
  });

  @override
  ConsumerState<EditFamilyDetails> createState() =>
      _ProfessionalInformationDetailsScreenState();
}

class _ProfessionalInformationDetailsScreenState
    extends ConsumerState<EditFamilyDetails> {
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    ref.read(familyDetailsProvider.notifier).disposeState();
    ref
        .read(familyDetailsProvider.notifier)
        .setFamilyDetails(ref.read(userManagementProvider).userDetails);
    final user = ref.read(userManagementProvider).userDetails;
    fatherNameController.text = user.fatherName ?? '';
    motherNameController.text = user.motherName ?? '';
  }

  @override
  void dispose() {
    fatherNameController.dispose();
    motherNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final familyDetailsState = ref.watch(familyDetailsProvider);
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return EnhancedLoadingWrapper(
      isLoading: familyDetailsState.isLoading,
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
              _buildForm(context, ref, familyDetailsState, heightQuery),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double width) {
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
          SizedBox(width: width * 0.25),
          const Text(
            'Edit Family Details',
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
    FamilyDetailsState familyDetailsState,
    double heightQuery,
  ) {
    final countryState = ref.watch(locationProvider);
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
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 5),
                  _buildFamilyValueSelection(context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildFamilyTypeSelection(context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildFamilyStatusSelection(context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildTextField(
                      'Father Name', familyDetailsState.fatherName ?? '',
                      (value) {
                    ref
                        .read(familyDetailsProvider.notifier)
                        .updateFatherName(value);
                  }, fatherNameController),
                  const SizedBox(height: 5),
                  _buildFatherOccupationSelection(
                      context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildTextField(
                      'Mother Name', familyDetailsState.motherName ?? '',
                      (value) {
                    ref
                        .read(familyDetailsProvider.notifier)
                        .updateMotherName(value);
                  }, motherNameController),
                  const SizedBox(height: 5),
                  _buildMotherOccupationSelection(
                      context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildNoOfBrothersSelection(context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildBrothersMarriedSelection(
                      context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildNoOfSistersSelection(context, ref, familyDetailsState),
                  const SizedBox(height: 5),
                  _buildSistersMarriedSelection(
                      context, ref, familyDetailsState),
                  const SizedBox(height: 24),
                  _buildSaveButton(context, ref, familyDetailsState),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, String initialValue,
      Function(String)? onChanged, TextEditingController controller) {
    return CustomTextFieldWidget(
      controller: controller,
      fillColor: Colors.transparent,
      hintText: hintText,
      initialValue: initialValue,
      onChanged: onChanged,
      borderRadius: 10,
      borderColor: Colors.grey.withOpacity(0.5),
      inputFormatters: [LengthLimitingTextInputFormatter(25)],
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Family Details',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildFamilyValueSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Family Value',
            options: FamilyDetailsConstData.familyValue,
            selectedValue: familyDetailsState.famliyValue,
            onSelect: (value) {
              ref.read(familyDetailsProvider.notifier).updateFamliyValue(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Family Value',
        familyDetailsState.famliyValue ?? 'Select',
      ),
    );
  }

  Widget _buildFamilyTypeSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Family Type',
            options: FamilyDetailsConstData.familyTypes,
            selectedValue: familyDetailsState.famliyType,
            onSelect: (value) {
              ref.read(familyDetailsProvider.notifier).updateFamliyType(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Family Type',
        familyDetailsState.famliyType ?? 'Select',
      ),
    );
  }

  Widget _buildFamilyStatusSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Family Status',
            options: FamilyDetailsConstData.familyStatus,
            selectedValue: familyDetailsState.famliyStatus,
            onSelect: (value) {
              ref
                  .read(familyDetailsProvider.notifier)
                  .updateFamliyStatus(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Family Status',
        familyDetailsState.famliyStatus ?? 'Select',
      ),
    );
  }

  Widget _buildFatherOccupationSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Father Occupation',
            options: FamilyDetailsConstData.fathersOccupation,
            selectedValue: familyDetailsState.fatherOccupation,
            onSelect: (value) {
              ref
                  .read(familyDetailsProvider.notifier)
                  .updateFatherOccupation(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Father Occupation',
        familyDetailsState.fatherOccupation ?? 'Select',
      ),
    );
  }

  Widget _buildMotherOccupationSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Mother Occupation',
            options: FamilyDetailsConstData.mothersOccupation,
            selectedValue: familyDetailsState.motherOccupation,
            onSelect: (value) {
              ref
                  .read(familyDetailsProvider.notifier)
                  .updateMotherOccupation(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Mother Occupation',
        familyDetailsState.motherOccupation ?? 'Select',
      ),
    );
  }

  Widget _buildNoOfBrothersSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'No. Of Brother\'s',
            options: FamilyDetailsConstData.noOfBrothers,
            selectedValue: familyDetailsState.noOfBrothers.toString(),
            onSelect: (value) {
              ref
                  .read(familyDetailsProvider.notifier)
                  .updateNoOfBrothers(int.parse(value));
            },
          ),
        );
      },
      child: _buildListTile(
        'No. Of Brother\'s',
        familyDetailsState.noOfBrothers?.toString() ?? 'Select',
      ),
    );
  }

  Widget _buildBrothersMarriedSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        if (familyDetailsState.noOfBrothers != null &&
            familyDetailsState.noOfBrothers != 0) {
          showDialog(
            context: context,
            builder: (context) => CommonSelectionDialog(
              title: 'Brother\'s Married',
              options: FamilyDetailsConstData.marriedOptions,
              selectedValue: familyDetailsState.brotherMarried,
              onSelect: (value) {
                ref
                    .read(familyDetailsProvider.notifier)
                    .updateBrotherMarried(value);
              },
            ),
          );
        } else {
          CustomSnackBar.show(
              context: context,
              message: 'Please Select No. Of Brothers',
              isError: true);
        }
      },
      child: _buildListTile(
        'Brother\'s Married',
        familyDetailsState.brotherMarried ?? 'Select',
      ),
    );
  }

  Widget _buildNoOfSistersSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'No. Of Sister\'s',
            options: FamilyDetailsConstData.noOfSisters,
            selectedValue: familyDetailsState.noOfSisters.toString(),
            onSelect: (value) {
              ref
                  .read(familyDetailsProvider.notifier)
                  .updateNoOfSisters(int.parse(value));
            },
          ),
        );
      },
      child: _buildListTile(
        'No. Of Sister\'s',
        familyDetailsState.noOfSisters?.toString() ?? 'Select',
      ),
    );
  }

  Widget _buildSistersMarriedSelection(BuildContext context, WidgetRef ref,
      FamilyDetailsState familyDetailsState) {
    return GestureDetector(
      onTap: () {
        if (familyDetailsState.noOfSisters != null &&
            familyDetailsState.noOfSisters != 0) {
          showDialog(
            context: context,
            builder: (context) => CommonSelectionDialog(
              title: 'Sister\'s Married',
              options: FamilyDetailsConstData.marriedOptions,
              selectedValue: familyDetailsState.sisterMarried,
              onSelect: (value) {
                ref
                    .read(familyDetailsProvider.notifier)
                    .updateSisterMarried(value);
              },
            ),
          );
        } else {
          CustomSnackBar.show(
              context: context,
              message: 'Please Select No. Of Sisters',
              isError: true);
        }
      },
      child: _buildListTile(
        'Sister\'s Married',
        familyDetailsState.sisterMarried ?? 'Select',
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    WidgetRef ref,
    FamilyDetailsState familyDetailsState,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final result = await ref
              .read(familyDetailsProvider.notifier)
              .updateFamilyDetails();
          ref
              .read(userManagementProvider.notifier)
              .updateFamilyDetails(familyDetailsState);
          if (result) {
            Future.delayed(const Duration(microseconds: 50), () {
              Navigator.pop(context);
              widget.onPop('true');
            }).then((_) {
              CustomSnackBar.show(
                isError: false,
                context: context,
                message: 'Location Details updated successfully!',
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
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
