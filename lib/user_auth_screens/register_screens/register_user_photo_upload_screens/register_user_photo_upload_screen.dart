import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/app_text_style.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_photo_upload_screens/register_user_photo_uploaded_success_screen.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_photo_notifier.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_photo_picker_notifier.dart'; // Riverpod image picker

class RegisterUserPhotoUploadScreen extends ConsumerWidget {

 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePickerState = ref.watch(imagePickerProvider);
    final imageApi = ref.watch(imageRegisterApiProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryButtonColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            child: Text('Skip', style: AppTextStyles.headingTextstyle.copyWith(color: Colors.black)),
            onPressed: () {
              // Add navigation to the next screen on skip
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Upload your photo',
              style: AppTextStyles.headingTextstyle,
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
                _buildPhotoUploadBox(
                  large: true,
                  context: context,
                  imageUrl: imagePickerState.imageUrl1,
                  isLoading: imagePickerState.isLoading1,
                  onTap: () {
                    ref.read(imagePickerProvider.notifier).pickImage1();
                  },
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPhotoUploadBox(
                      context: context,
                      imageUrl: imagePickerState.imageUrl2,
                      isLoading: imagePickerState.isLoading2,
                      onTap: () {
                        ref.read(imagePickerProvider.notifier).pickImage2();
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildPhotoUploadBox(
                      context: context,
                      imageUrl: imagePickerState.imageUrl3,
                      isLoading: imagePickerState.isLoading3,
                      onTap: () {
                        ref.read(imagePickerProvider.notifier).pickImage3();
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                 final imagepicker = ref.watch(imagePickerProvider);
                 final imageApi = ref.watch(imageRegisterApiProvider);
                 final isImagesNotEmpty = [imagepicker.imageUrl1 ?? '',
                   imagepicker.imageUrl2 ?? '',
                   imagepicker.imageUrl3 ?? '' 
                   ];
                 if(isImagesNotEmpty.where((url) => url.isNotEmpty).length > 2){
                  ref.read(imageRegisterApiProvider.notifier).uploadPhoto(
                   isImagesNotEmpty
                  );
                  // if (imageApi.successMessage!.isNotEmpty ) {
                 
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => RegisterUserPhotoUploadedSuccessScreen(),
  ),
  // (route) => false, 
);

                  // } 
                   }
                
                  
                },
                style: AppTextStyles.primaryButtonstyle,
                child:imageApi.isLoading? const Center(child: CircularProgressIndicator()): const Text(
                  'Continue',
                  style: AppTextStyles.primarybuttonText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoUploadBox({
    required BuildContext context,
    bool large = false,
    String? imageUrl,
    bool isLoading = false,
    required VoidCallback onTap,
  }) {
    print(imageUrl);
    return InkWell(
      onTap: onTap,
      child: Container(
        width: large ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.4,
        height: large ? 300 : 150,
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
                      child: Icon(Icons.add, color: Colors.red, size: large ? 40 : 30),
                    ),
                  ),
      ),
    );
  }
}

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double borderRadius;

  const DashedBorder({Key? key, required this.child, this.borderRadius = 0}) : super(key: key);

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
