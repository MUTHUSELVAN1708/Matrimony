import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/widget/circularprogressIndicator.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/common/widget/full_screen_loader.dart';
import 'package:matrimony/edit/profile/providers/profile_percentage_state.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_uploaded_success_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_proof_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_photo_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_photo_picker_notifier.dart'; // Riverpod image picker

class RegisterUserPhotoUploadScreen extends ConsumerStatefulWidget {
  final bool? isEditPhoto;
  final List<String>? images;
  final Function(bool value)? onPop;

  const RegisterUserPhotoUploadScreen({
    super.key,
    this.isEditPhoto,
    this.images,
    this.onPop,
  });

  @override
  ConsumerState<RegisterUserPhotoUploadScreen> createState() =>
      _RegisterUserPhotoUploadScreenState();
}

class _RegisterUserPhotoUploadScreenState
    extends ConsumerState<RegisterUserPhotoUploadScreen> {
  @override
  void initState() {
    super.initState();
    disposeState();
  }

  Future<void> disposeState() async {
    await Future.delayed(Duration.zero);
    ref.read(imagePickerProvider.notifier).disposeState();
    if (widget.isEditPhoto != null && widget.images != null) {
      ref.read(imagePickerProvider.notifier).initialState(
            widget.images?.isNotEmpty == true
                ? widget.images!.first.isNotEmpty
                    ? widget.images?.first
                    : null
                : null,
            widget.images!.length > 1
                ? widget.images![1].isNotEmpty
                    ? widget.images![1]
                    : null
                : null,
            widget.images!.length > 2
                ? widget.images![2].isNotEmpty
                    ? widget.images![2]
                    : null
                : null,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerState = ref.watch(imagePickerProvider);
    final imageApi = ref.watch(imageRegisterApiProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          if (widget.onPop != null) {
            widget.onPop!(true);
          }
        }
      },
      child: EnhancedLoadingWrapper(
        isLoading: imageApi.isLoading,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: AppColors.primaryButtonColor),
                onPressed: () {
                  if (widget.onPop != null) {
                    widget.onPop!(true);
                  }
                  Navigator.pop(context);
                }),
            actions: [
              if (widget.isEditPhoto == null)
                TextButton(
                  child: Text('Skip',
                      style: AppTextStyles.headingTextstyle
                          .copyWith(color: Colors.black)),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            const RegisterUserGovernmentProof(),
                      ),
                    );
                  },
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  widget.isEditPhoto == null
                      ? 'Upload your photo'
                      : 'Edit your Photo',
                  style: AppTextStyles.headingTextstyle,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'We’d love to see. Upload a photo for your life journey',
                  style: AppTextStyles.spanTextStyle,
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Photos help you get 50% more likes. Add at least 2.',
                    style: AppTextStyles.spanTextStyle,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPhotoUploadBox(
                          context: context,
                          imageUrl: imagePickerState.imageUrl1,
                          isLoading: imagePickerState.isLoading1,
                          onTap: () {
                            _showImageSourceSelector(context, 1);
                            // ref.read(imagePickerProvider.notifier).pickImage2();
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildPhotoUploadBox(
                          context: context,
                          imageUrl: imagePickerState.imageUrl2,
                          isLoading: imagePickerState.isLoading2,
                          onTap: () {
                            _showImageSourceSelector(context, 2);
                            // ref.read(imagePickerProvider.notifier).pickImage3();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    _buildPhotoUploadBox(
                      large: true,
                      context: context,
                      imageUrl: imagePickerState.imageUrl3,
                      isLoading: imagePickerState.isLoading3,
                      onTap: () {
                        _showImageSourceSelector(context, 3);
                        // ref.read(imagePickerProvider.notifier).pickImage1();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (imageApi.isLoading) {
                      } else {
                        final isImagesNotEmpty = [
                          imagePickerState.imageUrl1 ?? '',
                          imagePickerState.imageUrl2 ?? '',
                          imagePickerState.imageUrl3 ?? ''
                        ];
                        if (isImagesNotEmpty
                                .where((url) => url.isNotEmpty)
                                .length >
                            1) {
                          final value = await ref
                              .read(imageRegisterApiProvider.notifier)
                              .uploadPhoto(isImagesNotEmpty
                                  .where((element) => element.isNotEmpty)
                                  .toList());
                          await ref
                              .read(getImageApiProvider.notifier)
                              .getImage();
                          ref
                              .read(completionProvider.notifier)
                              .getIncompleteFields();
                          ref.read(userManagementProvider.notifier).updateImage(
                              ref.read(getImageApiProvider).data?.images);
                          if (value) {
                            if (widget.isEditPhoto == null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterUserPhotoUploadedSuccessScreen(),
                                ),
                                // (route) => false,
                              );
                            } else {
                              if (widget.onPop != null) {
                                widget.onPop!(true);
                              }
                              Navigator.of(context).pop();
                            }
                          } else {
                            CustomSnackBar.show(
                              context: context,
                              message:
                                  'Something Went Wrong. Please Try Again!',
                              isError: true,
                            );
                          }
                        } else {
                          CustomSnackBar.show(
                            context: context,
                            message: 'Please Upload 2 Photos.',
                            isError: true,
                          );
                        }
                      }
                    },
                    style: AppTextStyles.primaryButtonstyle,
                    child: imageApi.isLoading
                        ? const LoadingIndicator()
                        : Text(
                            widget.isEditPhoto == null ? 'Continue' : 'Update',
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

  void _showImageSourceSelector(BuildContext context, int imageType) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text('Camera'),
              onTap: () async {
                Navigator.pop(context);
                imageType == 1
                    ? ref
                        .read(imagePickerProvider.notifier)
                        .pickImage1(ImageSource.camera)
                    : imageType == 2
                        ? ref
                            .read(imagePickerProvider.notifier)
                            .pickImage2(ImageSource.camera)
                        : ref
                            .read(imagePickerProvider.notifier)
                            .pickImage3(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: Colors.green),
              title: const Text('Gallery'),
              onTap: () async {
                Navigator.pop(context); // Close the bottom sheet
                imageType == 1
                    ? ref
                        .read(imagePickerProvider.notifier)
                        .pickImage1(ImageSource.gallery)
                    : imageType == 2
                        ? ref
                            .read(imagePickerProvider.notifier)
                            .pickImage2(ImageSource.gallery)
                        : ref
                            .read(imagePickerProvider.notifier)
                            .pickImage3(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhotoUploadBox({
    required BuildContext context,
    bool large = false,
    String? imageUrl,
    bool isLoading = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: large
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * 0.4,
        height: large ? 310 : 150,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : imageUrl != null
                ? Image.memory(
                    base64Decode(imageUrl),
                    fit: BoxFit.cover,
                  )
                : DashedBorder(
                    borderRadius: 10,
                    child: Center(
                      child: Icon(Icons.add,
                          color: Colors.red, size: large ? 40 : 30),
                    ),
                  ),
      ),
    );
  }
}

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const DashedBorder({Key? key, required this.child, this.borderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: child,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
    double startY = 0;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
