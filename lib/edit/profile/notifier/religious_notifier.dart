import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/user_register_riverpods/riverpod/create_user_notifier.dart';
import '../state/religious_state.dart';
import 'package:http/http.dart' as http;

class ReligiousNotifier extends StateNotifier<ReligiousState> {
  ReligiousNotifier() : super(ReligiousState());

  void updateMotherTongue(String value) {
    state = state.copyWith(motherTongue: value);
  }

  void updateReligion(String value) {
    state = state.copyWith(religion: value);
  }

  void updateCaste(String value) {
    state = state.copyWith(caste: value);
  }

  void updateSubCaste(String value) {
    state = state.copyWith(subCaste: value);
  }

  void updateWillingToMarry(bool value) {
    state = state.copyWith(willingToMarryOtherCommunities: value);
  }

  void updateStar(String value) {
    state = state.copyWith(star: value);
  }

  void updateRaasi(String value) {
    state = state.copyWith(raasi: value);
  }

  void setReligiousDetails(UserDetails userDetails) {
    print(userDetails.subcaste);
    state = state.copyWith(
        motherTongue: userDetails.motherTongue,
        caste: userDetails.caste,
        raasi: userDetails.raasi,
        religion: userDetails.religion,
        star: userDetails.star,
        subCaste: userDetails.subcaste,
        willingToMarryOtherCommunities:
            userDetails.willingToMarryFromOtherCommunities);
    print(state.subCaste);
  }

  Future<bool> updateReligiousDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editReligion),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'motherTongue': state.motherTongue,
          'caste': state.caste,
          'raasi': state.raasi,
          'religion': state.religion,
          'star': state.star,
          'subcaste': state.subCaste,
          'willingToMarryFromOtherCommunities':
              state.willingToMarryOtherCommunities
        }),
      );

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body) as List<dynamic>;
        state = state.copyWith(
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
      );
      return false;
    }
  }

  void disposeState() => state = ReligiousState();
}
