import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/profile/setting_screens/riverpod/change_pass_state.dart';
import 'package:matrimony/user_auth_screens/register_star_details/forgot_password_state.dart';
import 'package:http/http.dart' as http;

class ChangePassNotifier extends StateNotifier<ChangePassState> {
  ChangePassNotifier() : super(ChangePassState());

  Future<String> changePassword(String oldPassword, String newPassword) async {
    state = state.copyWith(isLoading: true);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.put(
        Uri.parse(Api.changePassword),
        headers: {
          'Content-Type': 'application/json',
          'AppId': "1",
        },
        body: jsonEncode({
          'password': oldPassword,
          'newPassword': newPassword,
          'userId': userId
        }),
      );
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        print(response.body);
        return 'Success';
      } else {
        state = state.copyWith(isLoading: false);
        return 'Old Password Is Incorrect!';
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something Went Wrong. Please Try Again!',
      );
      return 'Something Went Wrong. Please Try Again!';
    }
  }
}
