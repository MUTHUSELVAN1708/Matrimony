import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_basic_preference_screen.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_user_personal_details_screen.dart';
import 'inital_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        // home:  RegisterUserPhotoUploadScreen(),
        home: RegisterUserPersonalDetailsScreen(),
      ),
    );
  }
}
