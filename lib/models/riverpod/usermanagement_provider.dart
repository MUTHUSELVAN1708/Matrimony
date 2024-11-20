import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/models/partner_details_model.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/models/user_partner_data.dart';

class UserManagementProvider extends StateNotifier<UserManagementState> {
  UserManagementProvider()
      : super(UserManagementState(
            userDetails: const UserDetails(),
            userPartnerDetails: const PartnerDetailsModel()));

  void resetState() => state = UserManagementState(
      userDetails: const UserDetails(),
      userPartnerDetails: const PartnerDetailsModel());

  Future<void> getUserDetails(int userId) async {
    state =
        state.copyWith(isLoadingForUser: true, error: null, userDetails: null);
    try {
      final response = await http.post(
        Uri.parse(Api.getProfileDetails),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userDetails = UserDetails.fromJson(jsonResponse);
        final userPartnerDetails = PartnerDetailsModel.fromJson(jsonResponse);
        print('User');
        print(userDetails.toJson());
        print('Partner');
        print(userPartnerDetails.toJson());
        state = state.copyWith(
            isLoadingForUser: false,
            userDetails: userDetails,
            userPartnerDetails: userPartnerDetails);
      } else if (response.statusCode == 400) {
        state = state.copyWith(
          isLoadingForUser: false,
          error: json.decode(response.body)['errorMessage'],
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingForUser: false,
        error: e.toString(),
      );
    }
  }

  Future<UserPartnerData?> getPartnerDetails(int userId) async {
    state = state.copyWith(
        isLoadingForPartner: true, error: null, partnerDetails: null);
    try {
      final response = await http.post(
        Uri.parse(Api.getProfileDetails),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final partnerDetails = UserDetails.fromJson(jsonResponse);
        final partnerPartnerDetails =
            PartnerDetailsModel.fromJson(jsonResponse);
        print(partnerDetails.toJson());
        print(partnerPartnerDetails.toJson());
        state = state.copyWith(
            isLoadingForPartner: false,
            partnerDetails: partnerDetails,
            partnerPartnerDetails: partnerPartnerDetails);
        return UserPartnerData(
            partnerDetails: partnerPartnerDetails, userDetails: partnerDetails);
      } else if (response.statusCode == 400) {
        state = state.copyWith(
          isLoadingForPartner: false,
          error: json.decode(response.body)['errorMessage'],
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingForPartner: false,
        error: e.toString(),
      );
      return null;
    }
    return null;
  }
}
