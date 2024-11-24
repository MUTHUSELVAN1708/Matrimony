import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preparence_religion_screen/riverpod/religious_api_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_preffesional_info_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/register_religion_provider.dart';

class RegisterReligiousDetailsScreen extends ConsumerStatefulWidget {
  const RegisterReligiousDetailsScreen({super.key});

  @override
  ConsumerState<RegisterReligiousDetailsScreen> createState() =>
      _RegisterReligiousDetailsScreenState();
}

class _RegisterReligiousDetailsScreenState
    extends ConsumerState<RegisterReligiousDetailsScreen> {
  // final _formKey = GlobalKey<FormState>();
  final otherReligionController = TextEditingController();
  final otherCasteController = TextEditingController();
  final otherSubCasteController = TextEditingController();
  final otherMotherTongueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _religionFetch();
  }

  Future<void> _religionFetch() async {
    await Future.delayed(Duration.zero);
    ref.read(religiousProvider.notifier).getReligiousData();
  }

  @override
  Widget build(BuildContext context) {
    final registerStateNotifier = ref.watch(registerProvider);
    final religionState = ref.watch(religiousProvider);
    final registerReligionState = ref.watch(registerReligionProvider);
    return EnhancedLoadingWrapper(
      isLoading: religionState.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const ProgressIndicatorWidget(value: 0.6),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: AppColors.primaryButtonColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Religious Information',
                  style: AppTextStyles.headingTextstyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'The Perfect Match for Your Personal Preferences',
                  style: AppTextStyles.spanTextStyle,
                ),
                const SizedBox(height: 30),
                CustomDropdownField(
                  isOtherValue: registerReligionState.otherMotherTongue,
                  controller: otherMotherTongueController,
                  // isOther: registerReligionState.motherTongue == 'Other',
                  isOther: true,
                  value: registerReligionState.motherTongue ?? '',
                  hint: 'Mother Tongue',
                  items: PartnerPreferenceConstData.motherTongueOptions,
                  onChanged: (value) {
                    ref
                        .read(registerReligionProvider.notifier)
                        .updateMotherTongue(value);
                    if (value == 'Other') {
                      ref
                          .read(registerReligionProvider.notifier)
                          .updateOtherMotherTongue(
                              otherMotherTongueController.text);
                    }
                  },
                ),
                const SizedBox(height: 16),

                CustomDropdownField(
                  controller: otherReligionController,
                  isOtherValue: registerReligionState.otherReligion,
                  value: registerReligionState.religion ?? '',
                  hint: 'Religion',
                  // isOther: registerReligionState.religion == 'Other',
                  isOther: true,
                  items: religionState.data.map((e) => e.religion).toList()
                    ..add('Other'),
                  onChanged: (value) async {
                    ref
                        .read(registerReligionProvider.notifier)
                        .updateReligion(value);
                    if (value == 'Other') {
                      ref
                          .read(registerReligionProvider.notifier)
                          .updateOtherReligion(otherReligionController.text);
                    }
                    int? stateId;
                    for (var e in religionState.data) {
                      if (e.religion == value) {
                        stateId = e.id;
                        break;
                      }
                    }
                    if (stateId != null) {
                      await ref
                          .read(religiousProvider.notifier)
                          .getCasteData('$stateId');
                    } else {
                      ref.read(religiousProvider.notifier).removeCasteData();
                    }
                  },
                ),
                registerReligionState.religion == null
                    ? const SizedBox()
                    : const SizedBox(height: 16),

                registerReligionState.religion == null
                    ? const SizedBox()
                    : CustomDropdownField(
                        isOtherValue: registerReligionState.otherCaste,
                        controller: otherCasteController,
                        value: registerReligionState.caste ?? '',
                        hint: 'Caste',
                        // isOther: registerReligionState.caste == 'Other',
                        isOther: true,
                        items:
                            religionState.casteList.map((e) => e.caste).toList()
                              ..add('Other'),
                        onChanged: (value) async {
                          ref
                              .read(registerReligionProvider.notifier)
                              .updateCaste(value);
                          if (value == 'Other') {
                            ref
                                .read(registerReligionProvider.notifier)
                                .updateOtherCaste(otherCasteController.text);
                          }
                          int? stateId;
                          for (var e in religionState.casteList) {
                            if (e.caste == value) {
                              stateId = e.id;
                              break;
                            }
                          }
                          if (stateId != null) {
                            await ref
                                .read(religiousProvider.notifier)
                                .getSubCasteData("$stateId");
                          } else {
                            ref
                                .read(religiousProvider.notifier)
                                .removeSubCasteData();
                          }
                        },
                      ),
                registerReligionState.caste == null ||
                        registerReligionState.caste == ''
                    ? const SizedBox()
                    : const SizedBox(height: 16),

                registerReligionState.caste == null ||
                        registerReligionState.caste == ''
                    ? const SizedBox()
                    : CustomDropdownField(
                        value: registerReligionState.subCaste ?? '',
                        // isOther: registerReligionState.subCaste == 'Other',
                        controller: otherSubCasteController,
                        isOtherValue: registerReligionState.otherSubCaste,
                        hint: 'Sub Caste',
                        isOther: true,
                        items: religionState.subCasteList
                            .map((e) => e.subCaste)
                            .toList()
                          ..add('Other'),
                        onChanged: (value) {
                          ref
                              .read(registerReligionProvider.notifier)
                              .updateSubCaste(value);
                          if (value == 'Other') {
                            ref
                                .read(registerReligionProvider.notifier)
                                .updateOtherSubCaste(
                                    otherSubCasteController.text);
                          }
                        },
                      ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: registerReligionState.willingToMarryOtherCastes,
                        onChanged: (value) {
                          ref
                              .read(registerReligionProvider.notifier)
                              .updateWillingToMarryOtherCastes(value ?? false);
                        },
                        activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Willing to marry from other castes',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Next Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: registerReligionState.religion == null ||
                            registerReligionState.motherTongue == null
                        ? null
                        : () async {
                            if (registerStateNotifier.isLoading) {
                            } else {
                              if (registerReligionState.religion != null &&
                                  registerReligionState.motherTongue != null) {
                                final registerState =
                                    ref.read(registerProvider.notifier);
                                final success =
                                    await registerState.createReligionsApi(
                                  motherTongue: registerReligionState
                                              .motherTongue ==
                                          'Other'
                                      ? registerReligionState.otherMotherTongue
                                      : registerReligionState.motherTongue,
                                  religion:
                                      registerReligionState.religion == 'Other'
                                          ? registerReligionState.otherReligion
                                          : registerReligionState.religion,
                                  caste: registerReligionState.caste == 'Other'
                                      ? registerReligionState.otherCaste
                                      : registerReligionState.caste,
                                  subCaste:
                                      registerReligionState.subCaste == 'Other'
                                          ? registerReligionState.otherSubCaste
                                          : registerReligionState.subCaste,
                                  willingToMarry: registerReligionState
                                          .willingToMarryOtherCastes
                                      ? 'true'
                                      : 'false',
                                );
                                if (success) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterUserProfessionalInfoScreen()),
                                  );
                                } else {
                                  CustomSnackBar.show(
                                    context: context,
                                    message:
                                        'Something Went Wrong. Please Try Again!',
                                    isError: true,
                                  );
                                }
                              }
                            }
                          },
                    style: AppTextStyles.primaryButtonstyle,
                    child: registerStateNotifier.isLoading
                        ? const LoadingIndicator()
                        : const Text(
                            'Next',
                            style: AppTextStyles.primarybuttonText,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
