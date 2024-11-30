import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/notifier/profile_notifier.dart';
import 'package:matrimony/edit/profile/providers/professional_info_provider.dart';
import 'package:matrimony/edit/profile/providers/profile_percentage_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import '../../common/colors.dart';
import '../../common/widget/common_selection_dialog.dart';
import '../../common/widget/custom_snackbar.dart';
import '../../common/widget/custom_text_field.dart';
import 'data/professional_info_options.dart';
import 'state/professional_info_state.dart';

class ProfessionalInformationDetailsScreen extends ConsumerStatefulWidget {
  final Function(String? value) onPop;

  const ProfessionalInformationDetailsScreen({
    super.key,
    required this.onPop,
  });

  @override
  ConsumerState<ProfessionalInformationDetailsScreen> createState() =>
      _ProfessionalInformationDetailsScreenState();
}

class _ProfessionalInformationDetailsScreenState
    extends ConsumerState<ProfessionalInformationDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Future.delayed(Duration.zero);
    ref.read(professionalInfoProvider.notifier).disposeState();
    ref
        .read(professionalInfoProvider.notifier)
        .setProfessionalDetails(ref.read(userManagementProvider).userDetails);
  }

  @override
  Widget build(BuildContext context) {
    final professionalInfoState = ref.watch(professionalInfoProvider);
    final heightQuery = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return EnhancedLoadingWrapper(
      isLoading: professionalInfoState.isLoading,
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
              _buildForm(context, ref, professionalInfoState, heightQuery),
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
          SizedBox(width: width * 0.10),
          const Text(
            'Professional Information',
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
    ProfessionalInfoState professionalInfoState,
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
                const SizedBox(height: 5),
                _buildEducationSelection(context, ref, professionalInfoState),
                // if (professionalInfoState.education != null &&
                //     professionalInfoState.education?.toLowerCase() !=
                //         "other") ...[
                //   const SizedBox(height: 5),
                //   _buildTextField('Enter College / Institution',
                //       professionalInfoState.college ?? '', true, (value) {
                //     // ref.read(professionalInfoProvider.notifier).updateCollege(value);
                //   }),
                // ],
                const SizedBox(height: 5),
                _buildOccupationSelection(context, ref, professionalInfoState),
                // if (professionalInfoState.occupation != null) ...[
                //   const SizedBox(height: 5),
                //   _buildTextField('Enter Organization Name',
                //       professionalInfoState.college ?? '', true, (value) {
                //     // ref.read(professionalInfoProvider.notifier).updateCollege(value);
                //   }),
                // ],
                const SizedBox(height: 5),
                _buildEmployedInSelection(context, ref, professionalInfoState),
                const SizedBox(height: 5),
                _buildCitizenshipSelection(context, ref, professionalInfoState),
                const SizedBox(height: 5),
                _buildCurrencyTypeSelection(
                    context, ref, professionalInfoState),
                const SizedBox(height: 5),
                _buildAnnualIncomeSelection(
                    context, ref, professionalInfoState),
                const SizedBox(height: 24),
                _buildSaveButton(context, ref, professionalInfoState),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, String initialValue, bool isEnabled,
      Function(String)? onChanged) {
    return CustomTextFieldWidget(
      hintText: hintText,
      initialValue: initialValue,
      isEnabled: true,
      onChanged: onChanged,
    );
  }

  Widget _buildTitle() {
    return const Center(
      child: Text(
        'Professional Information',
        style: TextStyle(
          color: AppColors.primaryButtonColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _buildEducationSelection(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Education',
            options: EducationOptions.options,
            selectedValue: professionalInfoState.education ?? 'Select',
            onSelect: (value) {
              ref
                  .read(professionalInfoProvider.notifier)
                  .updateEducation(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Education',
        professionalInfoState.education ?? 'Select',
      ),
    );
  }

  Widget _buildEmployedInSelection(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Employed In',
            options: EmploymentOptions.options,
            selectedValue: professionalInfoState.employedIn ?? 'Select',
            onSelect: (value) {
              ref
                  .read(professionalInfoProvider.notifier)
                  .updateEmployedIn(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Employed In',
        professionalInfoState.employedIn ?? 'Select',
      ),
    );
  }

  Widget _buildOccupationSelection(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Occupation',
            options: OccupationOptions.options,
            selectedValue: professionalInfoState.occupation ?? 'Select',
            onSelect: (value) {
              ref
                  .read(professionalInfoProvider.notifier)
                  .updateOccupation(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Occupation',
        professionalInfoState.occupation ?? 'Select',
      ),
    );
  }

  Widget _buildCitizenshipSelection(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Citizenship',
            options: CitizenshipOptions.options,
            selectedValue: professionalInfoState.citizenship ?? 'Select',
            onSelect: (value) {
              ref
                  .read(professionalInfoProvider.notifier)
                  .updateCitizenship(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Citizenship',
        professionalInfoState.citizenship ?? 'Select',
      ),
    );
  }

  Widget _buildCurrencyTypeSelection(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => CommonSelectionDialog(
            title: 'Select Currency Type',
            options: CurrencyOptions.options,
            selectedValue: professionalInfoState.currencyType ?? 'Select',
            onSelect: (value) {
              ref
                  .read(professionalInfoProvider.notifier)
                  .updateCurrencyType(value);
            },
          ),
        );
      },
      child: _buildListTile(
        'Currency Type',
        professionalInfoState.currencyType ?? 'Select',
      ),
    );
  }

  Widget _buildAnnualIncomeSelection(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return GestureDetector(
      onTap: () {
        if (professionalInfoState.currencyType != null) {
          showDialog(
            context: context,
            builder: (context) => CommonSelectionDialog(
              title: 'Select Annual Income',
              options: IncomeOptions
                  .options[professionalInfoState.currencyType ?? 'INR (₹)']!,
              selectedValue: professionalInfoState.annualIncome ?? 'Select',
              onSelect: (value) {
                ref
                    .read(professionalInfoProvider.notifier)
                    .updateAnnualIncome(value);
              },
            ),
          );
        } else {
          CustomSnackBar.show(
              context: context,
              message: 'Please Select First Currency Type!.',
              isError: true);
        }
      },
      child: _buildListTile(
        'Annual Income',
        professionalInfoState.annualIncome ?? 'Select',
      ),
    );
  }

  Widget _buildSaveButton(
    BuildContext context,
    WidgetRef ref,
    ProfessionalInfoState professionalInfoState,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final result = await ref
              .read(professionalInfoProvider.notifier)
              .updateProfessionalDetails();
          ref.read(completionProvider.notifier).getIncompleteFields();
          ref
              .read(userManagementProvider.notifier)
              .updateProfessionalDetails(professionalInfoState);
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
