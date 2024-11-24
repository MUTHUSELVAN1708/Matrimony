import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_register_riverpods/riverpod/register_religion_state.dart';

// StateNotifier
class RegisterReligionNotifier extends StateNotifier<RegisterReligionState> {
  RegisterReligionNotifier() : super(RegisterReligionState());

  // Update mother tongue
  void updateMotherTongue(String motherTongue) {
    state = state.copyWith(motherTongue: motherTongue);
  }

  // Update religion
  void updateReligion(String religion) {
    print(religion);
    print(state.religion);
    state = state.copyWith(
        religion: religion,
        caste: religion != state.religion ? '' : state.caste,
        subCaste: religion != state.religion ? '' : state.subCaste,
        otherCaste: religion != state.religion ? '' : state.otherCaste,
        otherReligion: religion != state.religion ? '' : state.otherReligion,
        otherSubCaste: religion != state.religion ? '' : state.otherSubCaste);
  }

  // Update caste
  void updateCaste(String caste) {
    state = state.copyWith(
        caste: caste,
        subCaste: caste != state.caste ? '' : state.subCaste,
        otherSubCaste: caste != state.caste ? '' : state.otherSubCaste);
  }

  // Update sub-caste
  void updateSubCaste(String subCaste) {
    state = state.copyWith(subCaste: subCaste);
  }

  void updateOtherMotherTongue(String otherMotherTongue) {
    state = state.copyWith(otherMotherTongue: otherMotherTongue);
  }

  void updateOtherSubCaste(String otherSubCaste) {
    state = state.copyWith(otherSubCaste: otherSubCaste);
  }

  void updateOtherCaste(String otherCaste) {
    state = state.copyWith(otherCaste: otherCaste);
  }

  void updateOtherReligion(String otherReligion) {
    state = state.copyWith(otherReligion: otherReligion);
  }

  // Update loading state
  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void updateWillingToMarryOtherCastes(bool willingToMarryOtherCastes) {
    state =
        state.copyWith(willingToMarryOtherCastes: willingToMarryOtherCastes);
  }

  // Clear all fields
  void clearFields() {
    state = RegisterReligionState();
  }
}

// Riverpod provider
final registerReligionProvider =
    StateNotifierProvider<RegisterReligionNotifier, RegisterReligionState>(
        (ref) => RegisterReligionNotifier());
