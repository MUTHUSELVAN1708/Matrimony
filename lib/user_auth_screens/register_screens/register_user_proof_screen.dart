import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/success_page.dart';
import 'package:matrimony/edit/profile/providers/profile_percentage_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/partner_basic_preference_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_proof_add_success_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_government_proof_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/proof_image_picker_notifier.dart';

class RegisterUserGovernmentProof extends ConsumerStatefulWidget {
  final String? title;
  final UserDetails? userDetails;

  const RegisterUserGovernmentProof({super.key, this.title, this.userDetails});

  @override
  ConsumerState<RegisterUserGovernmentProof> createState() =>
      _RegisterUserGovernmentProofState();
}

class _RegisterUserGovernmentProofState
    extends ConsumerState<RegisterUserGovernmentProof> {
  String? selectedProof;
  final List<String> proofOptions = [
    'Aadhaar Card',
    'Driving License',
    'Voter ID',
    'PAN Card',
    'Passport',
    'Divorce Certificate',
    'Widower Certificate',
    "Partner's Death Certificate",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.userDetails != null) {
      selectedProof = widget.userDetails!.govtIdProof;
    }
    setImage();
  }

  Future<void> setImage() async {
    await Future.delayed(Duration.zero);
    if (widget.userDetails != null) {
      ref.read(proofImageProvider.notifier).setIdImage(widget.userDetails!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final proofState = ref.watch(proofImageProvider);
    final proofApiState = ref.watch(governmentProofApiProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Govt Id Proof',
          style: AppTextStyles.headingTextstyle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          widget.title != null
              ? const SizedBox()
              : TextButton(
                  child: Text('Skip',
                      style: AppTextStyles.headingTextstyle
                          .copyWith(color: Colors.black)),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RegisterPartnerBasicPreferenceScreen()),
                    );
                  },
                ),
        ],
      ),
      body: widget.userDetails != null &&
              (widget.userDetails!.govtIdProofStatus ?? false)
          ? const SuccessPage()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    'Select the Govt ID to verify.',
                    style: AppTextStyles.secondrySpanTextStyle
                        .copyWith(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: proofOptions.length,
                      itemBuilder: (context, index) {
                        final proof = proofOptions[index];
                        final isSelected = selectedProof == proof;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedProof = proof;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.selectedWrapBacgroundColor
                                    : Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: isSelected
                                  ? Colors.red.withOpacity(0.1)
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              proof,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.spanTextStyle.copyWith(
                                  color: isSelected
                                      ? Colors.black
                                      : AppColors.spanTextColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (selectedProof != null) {
                        ref
                            .read(proofImageProvider.notifier)
                            .pickImage(selectedProof ?? '');
                      } else {
                        CustomSnackBar.show(
                            context: context,
                            message: 'Please Select Govt ID Type.',
                            isError: true);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Text(
                            proofState.imageName ?? 'Add Id Proof',
                            style: TextStyle(
                                color: proofState.imageName != null
                                    ? Colors.black
                                    : Colors.grey,
                                fontSize: 16),
                          ),
                          const Spacer(),
                          Icon(
                              proofState.imageName != null
                                  ? Icons.check_circle_rounded
                                  : Icons.upload_outlined,
                              color: proofState.imageName != null
                                  ? Colors.green
                                  : Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (proofApiState.isLoading) {
                        } else {
                          if (selectedProof != null &&
                              proofState.base64Image != null) {
                            final value = await ref
                                .read(governmentProofApiProvider.notifier)
                                .uploadGovernmentProofApi(
                                    govtIdProof: selectedProof,
                                    idImage: proofState.base64Image);
                            ref
                                .read(completionProvider.notifier)
                                .getIncompleteFields();
                            ref
                                .read(userManagementProvider.notifier)
                                .updateGovtProof(
                                    selectedProof, proofState.base64Image);
                            if (value) {
                              if (widget.userDetails != null) {
                                CustomSnackBar.show(
                                    context: context,
                                    message:
                                        'Govt Id Proof Updated Successfully.',
                                    isError: false);
                                Navigator.of(context).pop();
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterUserGovernmentProofSuccessScreen()),
                                  // (Route<dynamic> route) =>
                                  //     false,
                                );
                              }
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: proofApiState.isLoading
                          ? const LoadingIndicator()
                          : Text(
                              widget.title != null ? "verify" : 'Continue',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }
}
