import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_initial_profile_success_screen.dart';

import '../../common/widget/linear_Progress_indicator.dart';

class RegisterUserAdditionalInfoScreen extends ConsumerStatefulWidget {
  @override
  _RegisterUserAdditionalInfoScreenState createState() =>
      _RegisterUserAdditionalInfoScreenState();
}

class _RegisterUserAdditionalInfoScreenState
    extends ConsumerState<RegisterUserAdditionalInfoScreen> {
  String? selectedFamilyStatus;
  final TextEditingController _aboutController = TextEditingController();
  String? name;
  String? education;
  String? city;
  String? employedType;
  String? occupation;
  String? matrimonyProfile;

  final List<String> familyStatusOptions = [
    'Lower Class',
    'Middle Class',
    'Upper Middle Class',
    'Rich - Affluent',
  ];
  @override
  void initState() {
    super.initState();
    getLocalDatas();
  }

  Future<String?> getLocalDatas() async {
    name = await SharedPrefHelper.getName() ?? 'user';
    education = await SharedPrefHelper.getEducation() ?? 'Msc cs';
    city = await SharedPrefHelper.getCity() ?? 'kalakad';
    employedType = await SharedPrefHelper.getEmployedType() ?? 'farmer';
    occupation = await SharedPrefHelper.getOccupation() ?? '';
    matrimonyProfile =
        'My name is $name. I have a $education degree and currently live in $city. I am employed as $employedType.';
    _aboutController.text = matrimonyProfile.toString();
    print(_aboutController);
    print(matrimonyProfile);
  }

  @override
  void dispose() {
    _aboutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ProgressIndicatorWidget(value: 0.9),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
                alignment: Alignment.center,
                child: Text(
                  'Additional Information',
                  style: AppTextStyles.headingTextstyle,
                )),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  'The Perfect Match for your Personal Preference...',
                  style: AppTextStyles.spanTextStyle,
                )),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Family Status',
                style: AppTextStyles.secondrySpanTextStyle,
              ),
            ),
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 16.0,
              runSpacing: 12.0,
              children: familyStatusOptions
                  .map((status) => _buildFamilyStatusChip(status))
                  .toList(),
            ),
            const SizedBox(height: 30),
            const Text(
              'A Few Words About Yourself',
              style: AppTextStyles.secondrySpanTextStyle,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _aboutController,
              maxLines: 4,
              maxLength: 200,
              decoration: const InputDecoration(
                // hintText:
                //     "I have a bachelor's degree and am employed full-time. I enjoy reading and traveling. I am currently based in California.",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '*Your bio might be visible to others',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (registerState.isLoading) {
                  } else {
                    final registerState = ref.read(registerProvider.notifier);
                    bool success = await registerState.addAdditionalApi(
                        aboutYourSelf: _aboutController.text,
                        employefamilyStatus: selectedFamilyStatus);
                    if (success) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterUserInitialProfileSuccessScreen(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }
                },
                style: AppTextStyles.primaryButtonstyle,
                child: registerState.isLoading
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
    );
  }

  Widget _buildFamilyStatusChip(String label) {
    final isSelected = selectedFamilyStatus == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          selectedFamilyStatus = selected ? label : null;
        });
      },
      backgroundColor: isSelected ? AppColors.selectedWrapBacgroundColor : null,
      selectedColor: Colors.red[100],
      labelStyle: AppTextStyles.spanTextStyle.copyWith(
        color: isSelected ? Colors.black : AppColors.spanTextColor,
      ),
    );
  }
}
