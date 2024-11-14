import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_proof_add_success_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_government_proof_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/proof_image_picker_notifier.dart';

class RegisterUserGovernmentProof extends ConsumerStatefulWidget {
  const RegisterUserGovernmentProof({super.key});

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
  Widget build(BuildContext context) {
    final proofState = ref.watch(proofImageProvider);
    final proofApiState = ref.watch(governmentProofApiProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            child: Text('Skip',
                style: AppTextStyles.headingTextstyle
                    .copyWith(color: Colors.black)),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Add Govt Id Proof',
                style: AppTextStyles.headingTextstyle,
              ),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "we'd love to see, upload a photo for\nyour life journey",
                style: AppTextStyles.spanTextStyle,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Select the govt ID to verify.',
              style: AppTextStyles.secondrySpanTextStyle
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(height: 8),
            const Text(
              'You Have Option To Protect Your Photo And Control\nWho Can See Your Photo.',
              style: AppTextStyles.spanTextStyle,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: proofOptions.length,
                itemBuilder: (context, index) {
                  final proof = proofOptions[index];
                  final isSelected = selectedProof == proof;
                  // final isDeathCertificate = proof == "Partner's Death Certificate";

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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    proofState.imageName ?? 'Add Id Proof',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        ref.read(proofImageProvider.notifier).pickImage();
                      },
                      child: Icon(Icons.upload_outlined, color: Colors.grey)),
                ],
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
                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterUserGovernmentProofSuccessScreen()),
                          (Route<dynamic> route) =>
                              false, // Removes all previous routes
                        );
                      } else {
                        CustomSnackBar.show(
                          context: context,
                          message: 'Something Went Wrong. Please Try Again!',
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
                    : const Text(
                        'Continue',
                        style: TextStyle(
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
