import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_notifier.dart';

class EditPartnerPreferenceState {
  final String age;
  final String height;
  final String weight;
  final String motherTongue;
  final String maritalStatus;
  final String physicalStatus;
  final String religion;
  final String caste;
  final String division;
  final String star;
  final String raasi;
  final String occupation;
  final String annulIncome;
  final String employmentType;
  final String education;
  final String country;
  final String state;
  final String city;
  final bool? isOwnHouse;
  final String eatingHabits;
  final String smokingHabits;
  final String drinkingHabits;

  EditPartnerPreferenceState({
    this.age = '',
    this.height = '',
    this.weight = '',
    this.motherTongue = '',
    this.maritalStatus = '',
    this.physicalStatus = '',
    this.religion = '',
    this.caste = '',
    this.division = '',
    this.star = '',
    this.raasi = '',
    this.occupation = '',
    this.annulIncome = '',
    this.employmentType = '',
    this.education = '',
    this.country = '',
    this.state = '',
    this.city = '',
    this.isOwnHouse,
    this.eatingHabits = '',
    this.smokingHabits = '',
    this.drinkingHabits = '',
  });

  EditPartnerPreferenceState copyWith({
    String? age,
    String? height,
    String? weight,
    String? motherTongue,
    String? maritalStatus,
    String? physicalStatus,
    String? religion,
    String? caste,
    String? division,
    String? star,
    String? raasi,
    String? occupation,
    String? annulIncome,
    String? employmentType,
    String? education,
    String? country,
    String? state,
    String? city,
    bool? isOwnHouse,
    String? eatingHabits,
    String? smokingHabits,
    String? drinkingHabits,
  }) {
    return EditPartnerPreferenceState(
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      motherTongue: motherTongue ?? this.motherTongue,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      physicalStatus: physicalStatus ?? this.physicalStatus,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      division: division ?? this.division,
      star: star ?? this.star,
      raasi: raasi ?? this.raasi,
      occupation: occupation ?? this.occupation,
      annulIncome: annulIncome ?? this.annulIncome,
      employmentType: employmentType ?? this.employmentType,
      education: education ?? this.education,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      isOwnHouse: isOwnHouse ?? this.isOwnHouse,
      eatingHabits: eatingHabits ?? this.eatingHabits,
      smokingHabits: smokingHabits ?? this.smokingHabits,
      drinkingHabits: drinkingHabits ?? this.drinkingHabits,
    );
  }
}

final editPartnerPreferenceProvider = StateNotifierProvider<
    EditPartnerPreferenceNotifier, EditPartnerPreferenceState>(
  (ref) => EditPartnerPreferenceNotifier(),
);
