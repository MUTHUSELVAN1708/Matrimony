import 'package:flutter/material.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_main_screens/home_screens/widgets/custom_svg.dart';
import 'package:matrimony/helper/nav_helper.dart';
import 'package:matrimony/profile/more/screens/safe_matrimony_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "More",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: const SafeMatrimonyScreen(),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                shadowColor: Colors.black38,
                child: const ListTile(
                  leading: CustomSvg(name: 'privacy'),
                  title: Text(
                    "Privacy Policy",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                NavigationHelper.slideNavigateTo(
                  context: context,
                  screen: const SafeMatrimonyScreen(),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                color: Colors.white,
                shadowColor: Colors.black38,
                child: const ListTile(
                  leading: CustomSvg(name: 'help'),
                  title: Text(
                    "Safe Matrimony",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
