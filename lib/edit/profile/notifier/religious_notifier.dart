import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/religious_state.dart';

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
}