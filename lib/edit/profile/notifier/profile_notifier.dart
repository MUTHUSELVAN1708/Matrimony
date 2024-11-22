import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/service/date_picker.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileState());

  void updateProfile(String profile) {
    state = state.copyWith(selectedProfile: profile);
  }

  void updateReligion(String religion) {
    state = state.copyWith(selectedReligion: religion);
  }

  void updateCaste(String caste) {
    state = state.copyWith(selectedCaste: caste);
  }

  void updateName(String value) {
    state = state.copyWith(selectedName: value);
  }

  void updateHeight(String value) {
    state = state.copyWith(selectedHeight: value);
  }

  void updateWeight(String value) {
    state = state.copyWith(selectedWeight: value);
  }

  void updateSkinTone(String value) {
    state = state.copyWith(skinTone: value);
  }

  void updateMaritalStatus(String value) {
    state = state.copyWith(maritalStatus: value);
  }

  void updatePhysicalStatus(String value) {
    state = state.copyWith(physicalStatus: value);
  }

  void updateEatingHabitsStatus(String value) {
    state = state.copyWith(eatingHabits: value);
  }

  void updateDrinkingHabitsStatus(String value) {
    state = state.copyWith(drinkingHabits: value);
  }

  void updateSmokingHabitsStatus(String value) {
    state = state.copyWith(smokingHabits: value);
  }

  // void updateDateOfBirth(DateTime value) {
  //   state = state.copyWith(selectedDateOfBirth: value);
  // }

  void updateDateOfBirth(DateTime? date) {
    if (date != null) {
      final isValid = DatePickerService.isValidAge(date);
      state = state.copyWith(
        selectedDateOfBirth: date,
        isValidAge: isValid,
      );
    }
  }

  void setBasicDetails(UserDetails userDetails) {
    state = state.copyWith(
        physicalStatus: userDetails.physicalStatus,
        selectedProfile: userDetails.profileFor,
        maritalStatus: userDetails.maritalStatus,
        drinkingHabits: userDetails.drinkingHabits,
        eatingHabits: userDetails.eatingHabits,
        selectedCaste: userDetails.caste,
        selectedHeight: userDetails.height,
        selectedName: userDetails.name,
        selectedReligion: userDetails.religion,
        selectedWeight: userDetails.weight,
        skinTone: userDetails.skinTone,
        smokingHabits: userDetails.smokingHabits,
        selectedDateOfBirth: userDetails.dateOfBirth != null
            ? DateTime.tryParse(userDetails.dateOfBirth!)
            : null,
        isValidAge: true);
  }

  Future<bool> updateBasicDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editBasic),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'physicalStatus': state.physicalStatus,
          'profileFor': state.selectedProfile,
          'maritalStatus': state.maritalStatus,
          'drinkingHabits': state.drinkingHabits,
          'eatingHabits': state.eatingHabits,
          'caste': state.selectedCaste,
          'height': state.selectedHeight,
          'name': state.selectedName,
          'religion': state.selectedReligion,
          'weight': state.selectedWeight,
          'skinTone': state.skinTone,
          'smokingHabits': state.smokingHabits,
          'dateOfBirth': state.selectedDateOfBirth.toString(),
          'age': calculateAge(state.selectedDateOfBirth)
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

  bool validateProfile() {
    return state.selectedProfile != null &&
        state.selectedProfile!.isNotEmpty &&
        state.selectedName != null &&
        state.selectedName!.isNotEmpty &&
        state.selectedDateOfBirth != null &&
        state.selectedDateOfBirth != null &&
        state.isValidAge != null &&
        state.isValidAge!;
  }

  void disposeState() => state = ProfileState();
}

int calculateAge(DateTime? dateOfBirth) {
  if (dateOfBirth != null) {
    final DateTime now = DateTime.now();
    int calculatedAge = now.year - dateOfBirth.year;

    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }
  return 0;
}

final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});
