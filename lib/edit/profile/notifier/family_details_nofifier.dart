import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/edit/profile/providers/family_details_state.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/models/user_details_model.dart';

class FamilyDetailsNotifier extends StateNotifier<FamilyDetailsState> {
  FamilyDetailsNotifier() : super(FamilyDetailsState());

  void updateFamliyValue(String value) {
    state = state.copyWith(famliyValue: value);
  }

  void updateFamliyType(String value) {
    state = state.copyWith(famliyType: value);
  }

  void updateFamliyStatus(String value) {
    state = state.copyWith(famliyStatus: value);
  }

  void updateFatherName(String name) {
    state = state.copyWith(
      fatherName: name,
    );
  }

  void updateFatherOccupation(String occupation) {
    state = state.copyWith(
      fatherOccupation: occupation,
    );
  }

  void updateMotherOccupation(String occupation) {
    state = state.copyWith(
      motherOccupation: occupation,
    );
  }

  void updateMotherName(String name) {
    state = state.copyWith(
      motherName: name,
    );
  }

  void updateNoOfSisters(int sisters) {
    state = state.copyWith(
      noOfSisters: sisters,
    );
  }

  void updateNoOfBrothers(int brothers) {
    state = state.copyWith(noOfBrothers: brothers);
  }

  void updateBrotherMarried(String value) {
    state = state.copyWith(brotherMarried: value);
  }

  void updateSisterMarried(String value) {
    state = state.copyWith(sisterMarried: value);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void disposeState() {
    state = FamilyDetailsState();
  }

  Future<bool> updateFamilyDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.put(
        Uri.parse(Api.editfamliyinfo),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'famliyValue': state.famliyValue,
          'famliyType': state.famliyType,
          'famliyStatus': state.famliyStatus,
          'fatherName': state.fatherName,
          'fatherOccupation': state.fatherOccupation,
          'motherName': state.motherName,
          'motherOccupation': state.motherOccupation,
          'noOfBrothers': state.noOfBrothers,
          'noOfSisters': state.noOfSisters,
          'brotherMarried': state.brotherMarried,
          'sisterMarried': state.sisterMarried
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  void setFamilyDetails(UserDetails userDetails) {
    state = state.copyWith(
        sisterMarried: userDetails.sisterMarried,
        brotherMarried: userDetails.brotherMarried,
        noOfBrothers: userDetails.noOfBrothers,
        noOfSisters: userDetails.noOfSisters,
        motherOccupation: userDetails.motherOccupation,
        motherName: userDetails.motherName,
        fatherOccupation: userDetails.fatherOccupation,
        fatherName: userDetails.fatherName,
        famliyStatus: userDetails.famliyStatus,
        famliyType: userDetails.famliyType,
        famliyValue: userDetails.famliyValue);
  }
}

final familyDetailsProvider =
    StateNotifierProvider<FamilyDetailsNotifier, FamilyDetailsState>((ref) {
  return FamilyDetailsNotifier();
});
