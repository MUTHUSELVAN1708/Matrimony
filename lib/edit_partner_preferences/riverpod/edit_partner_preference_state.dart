import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_notifier.dart';
import 'package:matrimony/models/religion_model.dart';

class EditPartnerPreferenceState {
  final String fromAge;
  final String toAge;
  final String fromHeight;
  final String toHeight;
  final String fromWeight;
  final String toWeight;
  final String motherTongue;
  final String maritalStatus;
  final String physicalStatus;
  final String religion;
  final String caste;
  final String subCaste;
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
  final bool isLoading;
  final List<Religion> religionList;
  final List<Caste> casteList;
  final List<SubCaste> subCasteList;

  EditPartnerPreferenceState(
      {this.fromAge = '',
      this.toAge = '',
      this.fromHeight = '',
      this.toHeight = '',
      this.fromWeight = '',
      this.toWeight = '',
      this.motherTongue = '',
      this.maritalStatus = '',
      this.physicalStatus = '',
      this.religion = '',
      this.caste = '',
      this.subCaste = '',
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
      this.isLoading = false,
      this.religionList = const [],
      this.casteList = const [],
      this.subCasteList = const []});

  EditPartnerPreferenceState copyWith(
      {String? fromAge,
      String? toAge,
      String? fromHeight,
      String? toHeight,
      String? fromWeight,
      String? toWeight,
      String? motherTongue,
      String? maritalStatus,
      String? physicalStatus,
      String? religion,
      String? caste,
      String? subCaste,
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
      bool? isLoading,
      List<Religion>? religionList,
      List<Caste>? casteList,
      List<SubCaste>? subCasteList}) {
    return EditPartnerPreferenceState(
        toHeight: toHeight ?? this.toHeight,
        fromAge: fromAge ?? this.fromAge,
        fromHeight: fromHeight ?? this.fromHeight,
        fromWeight: fromWeight ?? this.fromWeight,
        toAge: toAge ?? this.toAge,
        toWeight: toWeight ?? this.toWeight,
        motherTongue: motherTongue ?? this.motherTongue,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        physicalStatus: physicalStatus ?? this.physicalStatus,
        religion: religion ?? this.religion,
        caste: caste ?? this.caste,
        subCaste: subCaste ?? this.subCaste,
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
        isLoading: isLoading ?? this.isLoading,
        casteList: casteList ?? this.casteList,
        religionList: religionList ?? this.religionList,
        subCasteList: subCasteList ?? this.subCasteList);
  }
}

final editPartnerPreferenceProvider = StateNotifierProvider<
    EditPartnerPreferenceNotifier, EditPartnerPreferenceState>(
  (ref) => EditPartnerPreferenceNotifier(),
);
