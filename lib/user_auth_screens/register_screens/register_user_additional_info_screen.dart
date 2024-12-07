import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_initial_profile_success_screen.dart';

import '../../common/widget/linear_Progress_indicator.dart';

class RegisterUserAdditionalInfoScreen extends ConsumerStatefulWidget {
  final UserDetails? userDetails;
  final Function(String)? onPop;

  const RegisterUserAdditionalInfoScreen(
      {super.key, this.userDetails, this.onPop});

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
    if (widget.userDetails != null &&
        widget.userDetails!.aboutYourSelf != null &&
        widget.userDetails!.aboutYourSelf!.isNotEmpty) {
      _aboutController.text = widget.userDetails!.aboutYourSelf!;
    } else if (widget.userDetails == null) {
      getLocalDatas();
    }

    if (widget.userDetails != null &&
        widget.userDetails!.familyStatus != null &&
        widget.userDetails!.familyStatus!.isNotEmpty) {
      selectedFamilyStatus = widget.userDetails!.familyStatus!;
    }
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
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && widget.onPop != null) {
          widget.onPop!('true');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: widget.userDetails != null
              ? const Text(
                  'Additional Information',
                  style: AppTextStyles.headingTextstyle,
                )
              : const ProgressIndicatorWidget(value: 0.9),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: AppColors.primaryButtonColor),
              onPressed: () {
                if (widget.onPop != null) {
                  widget.onPop!('true');
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }
              }),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.userDetails == null) ...[
                const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Additional Information',
                      style: AppTextStyles.headingTextstyle,
                    )),
              ],
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'The Perfect Match for your Personal Preference...',
                    style: AppTextStyles.spanTextStyle,
                  )),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Family Status',
                  style: AppTextStyles.secondrySpanTextStyle
                      .copyWith(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 16.0,
                runSpacing: 12.0,
                children: familyStatusOptions
                    .map((status) => _buildFamilyStatusChip(status))
                    .toList(),
              ),
              const SizedBox(height: 30),
              Text(
                'A Few Words About Yourself',
                style:
                    AppTextStyles.secondrySpanTextStyle.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _aboutController,
                maxLines: 4,
                maxLength: 200,
                decoration: const InputDecoration(
                  hintText: 'About Yourself...',
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
                        if (widget.userDetails != null) {
                          widget.onPop!('true');
                          Navigator.of(context).pop();
                          ref
                              .read(userManagementProvider.notifier)
                              .updateYourSelf(
                                  selectedFamilyStatus, _aboutController.text);
                          CustomSnackBar.show(
                              context: context,
                              message: 'About Yourself Updated Successfully',
                              isError: false);
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RegisterUserInitialProfileSuccessScreen(),
                            ),
                          );
                        }
                      } else {
                        CustomSnackBar.show(
                          context: context,
                          message: 'Something Went Wrong. Please Try Again!',
                          isError: true,
                        );
                      }
                    }
                  },
                  style: AppTextStyles.primaryButtonstyle,
                  child: registerState.isLoading
                      ? const LoadingIndicator()
                      : Text(
                          widget.userDetails != null ? 'Save' : 'Next',
                          style: AppTextStyles.primarybuttonText,
                        ),
                ),
              ),
            ],
          ),
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
