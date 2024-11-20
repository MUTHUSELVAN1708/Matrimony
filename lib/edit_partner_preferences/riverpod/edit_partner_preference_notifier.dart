import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_state.dart';

class EditPartnerPreferenceNotifier
    extends StateNotifier<EditPartnerPreferenceState> {
  EditPartnerPreferenceNotifier() : super(EditPartnerPreferenceState());

  void updateFromAge(String age) => state = state.copyWith(age: age);

  void updateFromHeight(String height) =>
      state = state.copyWith(height: height);

  void updateFromWeight(String weight) =>
      state = state.copyWith(weight: weight);

  void updateMotherTongue(String motherTongue) =>
      state = state.copyWith(motherTongue: motherTongue);

  void updateMaritalStatus(String maritalStatus) =>
      state = state.copyWith(maritalStatus: maritalStatus);

  void updatePhysicalStatus(String physicalStatus) =>
      state = state.copyWith(physicalStatus: physicalStatus);

  void updateReligion(String religion) =>
      state = state.copyWith(religion: religion);

  void updateCaste(String caste) => state = state.copyWith(caste: caste);

  void updateDivision(String division) =>
      state = state.copyWith(division: division);

  void updateStar(String? star) => state = state.copyWith(star: star);

  void updateRaasi(String raasi) => state = state.copyWith(raasi: raasi);

  void updateOccupation(String occupation) =>
      state = state.copyWith(occupation: occupation);

  void updateAnnulIncome(String annulIncome) =>
      state = state.copyWith(annulIncome: annulIncome);

  void updateEmploymentType(String employmentType) =>
      state = state.copyWith(employmentType: employmentType);

  void updateEducation(String education) =>
      state = state.copyWith(education: education);

  void updateCountry(String country) =>
      state = state.copyWith(country: country);

  void updateState(String stateValue) =>
      state = state.copyWith(state: stateValue);

  void updateCity(String city) => state = state.copyWith(city: city);

  void updateIsOwnHouse(bool isOwnHouse) =>
      state = state.copyWith(isOwnHouse: isOwnHouse);

  void updateEatingHabits(String eatingHabits) =>
      state = state.copyWith(eatingHabits: eatingHabits);

  void updateSmokingHabits(String smokingHabits) =>
      state = state.copyWith(smokingHabits: smokingHabits);

  void updateDrinkingHabits(String drinkingHabits) =>
      state = state.copyWith(drinkingHabits: drinkingHabits);

  void setValues(String age, String height, String weight) {
    state = state.copyWith(age: age, height: height, weight: weight);
  }

  void setValuesInitial(String age, String height, String weight,
      String maritalStatus, String motherTongue, String physicalStatus) {
    state = state.copyWith(
        age: age,
        height: height,
        weight: weight,
        maritalStatus: maritalStatus,
        motherTongue: motherTongue,
        physicalStatus: physicalStatus);
  }

  void resetState() => state = EditPartnerPreferenceState();
}
