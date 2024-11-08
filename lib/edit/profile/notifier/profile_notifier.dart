import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../service/date_picker.dart';
import '../providers/profile_provider.dart';

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

  bool validateProfile() {
    return state.selectedProfile.isNotEmpty &&
        state.selectedName.isNotEmpty &&
        state.selectedDateOfBirth != null &&
        state.isValidAge;
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});