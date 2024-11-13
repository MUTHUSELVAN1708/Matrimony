import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/bottom_bar_screens/bottom_nav_bar_screen.dart';
import 'package:matrimony/inital_screen.dart';
import 'package:matrimony/profile/main_profile_screen.dart';
import 'package:matrimony/profile/profile.dart';
import 'package:matrimony/user_auth_screens/otp_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_basic_screen/partner_basic_widgets/partner_basic_preference_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: FutureBuilder<String?>(
        future: _getToken(),
        builder: (context, snapshot) {
          // Check if the Future is completed and the snapshot has data
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.isNotEmpty) {
              // Token is present, navigate to BottomNavScreen
              return const MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: BottomNavBarScreen(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: EditProfileScreen(),
              );
            }
          }
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to get the token from SharedPreferences
  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Make sure the key matches your saved key
  }
}
