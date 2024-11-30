import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/common/colors.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/common/widget/custom_snackbar.dart';
import 'package:matrimony/user_auth_screens/login_screens/login_screen.dart';

class LogOutModel extends StatelessWidget {
  const LogOutModel({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvg(
            name: 'successcircle',
            height: 85,
            width: 85,
          ),
          SizedBox(height: 15),
          Text(
            'Do You Want To Log Out?',
            style: TextStyle(
              color: AppColors.spanTextColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          text: 'Are You Sure You Want To ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: 'Log Out',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            TextSpan(
              text: ' From My App?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await SharedPrefHelper.removeUser();
                  if (!context.mounted) return;
                  CustomSnackBar.show(
                    context: context,
                    message: 'Logged Out Successfully.',
                    isError: false,
                  );
                  navigator.pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryButtonColor, // Button color
                  ),
                  child: const Center(
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
