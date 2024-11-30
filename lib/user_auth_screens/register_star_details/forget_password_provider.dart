import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forgot_password_state.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier() : super(ForgotPasswordState());

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  Future<String> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await http.post(
        Uri.parse(Api.forgot),
        headers: {
          'Content-Type': 'application/json',
          'AppId': "1",
        },
        body: jsonEncode({
          'email': email,
        }),
      );
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body);
        state = state.copyWith(isLoading: false);
        print(response.body);
        return response.body;
      } else {
        state = state.copyWith(isLoading: false);
        return 'Email is Invalid!.';
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Email is Invalid!.',
      );
      return 'Email is Invalid!.';
    }
  }

  Future<String> otpVerification(String phoneNumber, String otp) async {
    if (otp == '' || phoneNumber == '') {
      return 'OTP is Empty!.';
    }
    try {
      state = state.copyWith(isLoading: true);
      final response = await http.post(
        Uri.parse(Api.forgototpverify),
        headers: {
          'Content-Type': 'application/json',
          'AppId': "1",
        },
        body: jsonEncode({'otp': otp, 'phoneNumber': phoneNumber}),
      );
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return 'Success';
      } else {
        state = state.copyWith(isLoading: false);
        return 'OTP is Invalid!.';
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return 'Something Went Wrong. Please Try Again!.';
    }
  }

  Future<String> newPassword(String password, String phoneNumber) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await http.post(
        Uri.parse(Api.newpassword),
        headers: {
          'Content-Type': 'application/json',
          'AppId': "1",
        },
        body: jsonEncode({'password': password, 'phoneNumber': phoneNumber}),
      );
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return 'Success';
      } else {
        print(response.body);
        state = state.copyWith(isLoading: false);
        return 'Something Went Wrong. Please Try Again!.';
      }
    } catch (e) {
      print(e);
      state = state.copyWith(isLoading: false);
      return 'Something Went Wrong. Please Try Again!.';
    }
  }
}
