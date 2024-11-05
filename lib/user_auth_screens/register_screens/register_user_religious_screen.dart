import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/common_dialog_box.dart';
import 'package:matrimony/common/widget/linear_Progress_indicator.dart';
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

  String? motherTongue;
  String? religion;
  String? caste;
  String? subCaste;
  bool willingToMarryOtherCastes = false;

  final List<String> motherTongueOptions = [
    'Hindi',
    'English',
    'Tamil',
    'Telugu',
    'Malayalam',
    'Kannada',
    'Bengali',
    'Marathi',
    'Gujarati',
    'Punjabi'
  ];

  final List<String> religionOptions = [
    'Hindu',
    'Muslim',
    'Christian',
    'Sikh',
    'Buddhist',
    'Jain',
    'Jewish',
    'Parsi',
    'Other'
  ];

  final List<String> casteOptions = [
    'Brahmin',
    'Kshatriya',
    'Vaishya',
    'Others'
  ];

  final List<String> subCasteOptions = [
    'Sub Caste 1',
    'Sub Caste 2',
    'Sub Caste 3',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                // Mother Tongue Dropdown
                CustomDropdownField(
                  value: motherTongue ?? '',
                  hint: 'Mother Tongue',
                  items: motherTongueOptions,
                  onChanged: (value) {
                    setState(() => motherTongue = value);
                  },
                ),
                const SizedBox(height: 16),

                // Religion Dropdown
                CustomDropdownField(
                  value: religion ?? '',
                  hint: 'Religion',
                  items: religionOptions,
                  onChanged: (value) {
                    setState(() {
                      religion = value;
                      caste = null;
                      subCaste = null;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Caste Dropdown
                CustomDropdownField(
                  value: caste ?? '',
                  hint: 'Caste',
                  items: casteOptions,
                  onChanged: (value) {
                    setState(() {
                      caste = value;
                      subCaste = null;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Sub Caste Dropdown
                CustomDropdownField(
                  value: subCaste ?? '',
                  hint: 'Sub Caste',
                  items: subCasteOptions,
                  onChanged: (value) {
                    setState(() => subCaste = value);
                  },
                ),
                const SizedBox(height: 16),

                // Willing to marry other castes checkbox
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: willingToMarryOtherCastes,
                        onChanged: (value) {
                          setState(
                              () => willingToMarryOtherCastes = value ?? false);
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
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        final registerState =
                            ref.read(registerProvider.notifier);
                        final success = await registerState.createReligionsApi(
                          motherTongue: motherTongue,
                          religion: religion,
                          caste: caste,
                          subCaste: subCaste,
                          division: '',
                        );
                        print(success);
                        if (success) {
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
                    child: const Text(
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
