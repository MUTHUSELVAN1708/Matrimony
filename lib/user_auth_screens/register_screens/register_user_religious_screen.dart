import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/patner_preference_const_data.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preparence_religion_screen/riverpod/religious_api_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_preffesional_info_screen.dart';

class RegisterReligiousDetailsScreen extends ConsumerStatefulWidget {
  const RegisterReligiousDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterReligiousDetailsScreen> createState() =>
      _RegisterReligiousDetailsScreenState();
}

class _RegisterReligiousDetailsScreenState
    extends ConsumerState<RegisterReligiousDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String motherTongue = '';
  String religion = '';
  String caste = '';
  String subCaste = '';
  bool willingToMarryOtherCastes = false;

  @override
  void initState() {
    super.initState();
    _religonFetch();
  }

  Future<void> _religonFetch() async {
    await Future.delayed(Duration.zero);
    ref.read(religiousProvider.notifier).getReligiousData();
  }

  @override
  Widget build(BuildContext context) {
    final registerStateNotifier = ref.watch(registerProvider);
    final religionState = ref.watch(religiousProvider);
    return EnhancedLoadingWrapper(
      isLoading: religionState.isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: ProgressIndicatorWidget(value: 0.6),
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
            child: Form(
              key: _formKey,
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
                    value: motherTongue,
                    hint: 'Mother Tongue',
                    items: PartnerPreferenceConstData.motherTongueOptions,
                    onChanged: (value) {
                      setState(() => motherTongue = value);
                    },
                  ),
                  const SizedBox(height: 16),

                  CustomDropdownField(
                    value: religion,
                    hint: 'Religion',
                    items: religionState.data.map((e) => e.religion).toList(),
                    onChanged: (value) async {
                      setState(() {
                        religion = value;
                        caste = '';
                        subCaste = '';
                      });

                      int? stateId;
                      for (var e in religionState.data) {
                        if (e.religion == religion) {
                          stateId = e.id;
                          break;
                        }
                      }

                      print("Selected State ID: $stateId");
                      if (stateId != null) {
                        await ref
                            .read(religiousProvider.notifier)
                            .getCasteData('$stateId');
                      } else {
                        print("No state ID found for the selected country.");
                      }
                    },
                  ),
                  religion.isEmpty || religionState.casteList.isEmpty
                      ? const SizedBox()
                      : const SizedBox(height: 16),

                  religion.isEmpty || religionState.casteList.isEmpty
                      ? const SizedBox()
                      : CustomDropdownField(
                          value: caste,
                          hint: 'Caste',
                          items: religionState.casteList
                              .map((e) => e.caste)
                              .toList(),
                          onChanged: (value) async {
                            setState(() {
                              caste = value;
                              subCaste = '';
                            });
                            int? stateId;
                            for (var e in religionState.casteList) {
                              if (e.caste == caste) {
                                stateId = e.id;
                                break;
                              }
                            }

                            print("Selected State ID: $stateId");
                            if (stateId != null) {
                              await ref
                                  .read(religiousProvider.notifier)
                                  .getSubCasteData("$stateId");
                            } else {
                              print(
                                  "No state ID found for the selected country.");
                            }
                          },
                        ),
                  caste.isEmpty || religionState.subCasteList.isEmpty
                      ? const SizedBox()
                      : const SizedBox(height: 16),

                  caste.isEmpty || religionState.subCasteList.isEmpty
                      ? const SizedBox()
                      : CustomDropdownField(
                          value: subCaste,
                          hint: 'Sub Caste',
                          items: religionState.subCasteList
                              .map((e) => e.subCaste)
                              .toList(),
                          onChanged: (value) {
                            setState(() => subCaste = value);
                          },
                        ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: willingToMarryOtherCastes,
                          onChanged: (value) {
                            setState(() =>
                                willingToMarryOtherCastes = value ?? false);
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
                      onPressed: motherTongue.isEmpty && religion.isEmpty
                          ? null
                          : () async {
                              if (motherTongue.isNotEmpty &&
                                  religion.isNotEmpty) {
                                final registerState =
                                    ref.read(registerProvider.notifier);
                                final success =
                                    await registerState.createReligionsApi(
                                  motherTongue: motherTongue,
                                  religion: religion,
                                  caste: caste,
                                  subCaste: subCaste,
                                  division: '',
                                );
                                if (registerStateNotifier.error == null &&
                                    registerStateNotifier.success != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterUserProfessionalInfoScreen()),
                                  );
                                }
                              }
                            },
                      style: AppTextStyles.primaryButtonstyle,
                      child: registerStateNotifier.isLoading
                          ? const Center(
                              child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  )),
                            )
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
      ),
    );
  }
}
