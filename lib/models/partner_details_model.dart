import 'package:equatable/equatable.dart';

class PartnerDetailsModel extends Equatable {
  final int? partnerFromAge;
  final int? partnerToAge;
  final int? partnerHeight;
  final int? partnerWeight;
  final String? partnerMaritalStatus;
  final String? partnerMotherTongue;
  final String? partnerPhysicalStatus;
  final String? partnerEatingHabits;
  final String? partnerDrinkingHabits;
  final String? partnerSmokingHabits;
  final String? partnerReligion;
  final String? partnerCaste;
  final String? partnerSubcaste;
  final String? partnerStar;
  final String? partnerRassi;
  final String? partnerDosham;
  final String? partnerEducation;
  final String? partnerEmployedIn;
  final String? partnerProfession;
  final String? partnerAnnualIncome;
  final String? partnerCountry;
  final String? partnerState;
  final String? partnerCity;
  final String? partnerDivision;
  final String? partnerLookingFor;
  final String? partnerLifestyle;
  final String? partnerHobbies;
  final String? partnerMusic;
  final String? partnerReading;
  final String? partnerMoviesTvShows;
  final String? partnerSportsAndFitness;
  final String? partnerFood;
  final String? partnerSpokenLanguages;
  final String? partnerInterest;
  final String? partnerViewList;
  final String? partnerOccupation;
  final String? partnerOwnHouse;

  const PartnerDetailsModel({
    this.partnerFromAge,
    this.partnerToAge,
    this.partnerHeight,
    this.partnerWeight,
    this.partnerMaritalStatus,
    this.partnerMotherTongue,
    this.partnerPhysicalStatus,
    this.partnerEatingHabits,
    this.partnerDrinkingHabits,
    this.partnerSmokingHabits,
    this.partnerReligion,
    this.partnerCaste,
    this.partnerSubcaste,
    this.partnerStar,
    this.partnerRassi,
    this.partnerDosham,
    this.partnerEducation,
    this.partnerEmployedIn,
    this.partnerProfession,
    this.partnerAnnualIncome,
    this.partnerCountry,
    this.partnerState,
    this.partnerCity,
    this.partnerDivision,
    this.partnerLookingFor,
    this.partnerLifestyle,
    this.partnerHobbies,
    this.partnerMusic,
    this.partnerReading,
    this.partnerMoviesTvShows,
    this.partnerSportsAndFitness,
    this.partnerFood,
    this.partnerSpokenLanguages,
    this.partnerInterest,
    this.partnerViewList,
    this.partnerOccupation,
    this.partnerOwnHouse,
  });

  /// Factory to create an object from JSON
  factory PartnerDetailsModel.fromJson(Map<String, dynamic> json) {
    final partnerPreference = json['partnerPreference'] ?? {};
    return PartnerDetailsModel(
      partnerFromAge: partnerPreference['fromAge'],
      partnerToAge: partnerPreference['toAge'],
      partnerHeight: partnerPreference['height'],
      partnerWeight: partnerPreference['weight'],
      partnerMaritalStatus: partnerPreference['maritalStatus'],
      partnerMotherTongue: partnerPreference['motherTongue'],
      partnerPhysicalStatus: partnerPreference['physicalStatus'],
      partnerEatingHabits: partnerPreference['eatingHabits'],
      partnerDrinkingHabits: partnerPreference['drinkingHabits'],
      partnerSmokingHabits: partnerPreference['smokingHabits'],
      partnerReligion: partnerPreference['religion'],
      partnerCaste: partnerPreference['caste'],
      partnerSubcaste: partnerPreference['subcaste'],
      partnerStar: partnerPreference['star'],
      partnerRassi: partnerPreference['rassi'],
      partnerDosham: partnerPreference['dosham'],
      partnerEducation: partnerPreference['education'],
      partnerEmployedIn: partnerPreference['employedIn'],
      partnerProfession: partnerPreference['profession'],
      partnerAnnualIncome: partnerPreference['annualIncome'],
      partnerCountry: partnerPreference['country'],
      partnerState: partnerPreference['state'],
      partnerCity: partnerPreference['city'],
      partnerDivision: partnerPreference['division'],
      partnerLookingFor: partnerPreference['lookingFor'],
      partnerLifestyle: partnerPreference['lifestyle'],
      partnerHobbies: partnerPreference['hobbies'],
      partnerMusic: partnerPreference['music'],
      partnerReading: partnerPreference['reading'],
      partnerMoviesTvShows: partnerPreference['moviesTvShows'],
      partnerSportsAndFitness: partnerPreference['sportsAndFitness'],
      partnerFood: partnerPreference['food'],
      partnerSpokenLanguages: partnerPreference['spokenLanguages'],
      partnerInterest: partnerPreference['interest'],
      partnerViewList: partnerPreference['viewList'],
      partnerOccupation: partnerPreference['occupation'],
      partnerOwnHouse: partnerPreference['ownHouse'],
    );
  }

  /// Converts the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'fromAge': partnerFromAge,
      'toAge': partnerToAge,
      'height': partnerHeight,
      'weight': partnerWeight,
      'maritalStatus': partnerMaritalStatus,
      'motherTongue': partnerMotherTongue,
      'physicalStatus': partnerPhysicalStatus,
      'eatingHabits': partnerEatingHabits,
      'drinkingHabits': partnerDrinkingHabits,
      'smokingHabits': partnerSmokingHabits,
      'religion': partnerReligion,
      'caste': partnerCaste,
      'subcaste': partnerSubcaste,
      'star': partnerStar,
      'rassi': partnerRassi,
      'dosham': partnerDosham,
      'education': partnerEducation,
      'employedIn': partnerEmployedIn,
      'profession': partnerProfession,
      'annualIncome': partnerAnnualIncome,
      'country': partnerCountry,
      'state': partnerState,
      'city': partnerCity,
      'division': partnerDivision,
      'lookingFor': partnerLookingFor,
      'lifestyle': partnerLifestyle,
      'hobbies': partnerHobbies,
      'music': partnerMusic,
      'reading': partnerReading,
      'moviesTvShows': partnerMoviesTvShows,
      'sportsAndFitness': partnerSportsAndFitness,
      'food': partnerFood,
      'spokenLanguages': partnerSpokenLanguages,
      'interest': partnerInterest,
      'viewList': partnerViewList,
      'occupation': partnerOccupation,
      'ownHouse': partnerOwnHouse,
    };
  }

  /// Copy with method
  PartnerDetailsModel copyWith({
    int? partnerFromAge,
    int? partnerToAge,
    int? partnerHeight,
    int? partnerWeight,
    String? partnerMaritalStatus,
    String? partnerMotherTongue,
    String? partnerPhysicalStatus,
    String? partnerEatingHabits,
    String? partnerDrinkingHabits,
    String? partnerSmokingHabits,
    String? partnerReligion,
    String? partnerCaste,
    String? partnerSubcaste,
    String? partnerStar,
    String? partnerRassi,
    String? partnerDosham,
    String? partnerEducation,
    String? partnerEmployedIn,
    String? partnerProfession,
    String? partnerAnnualIncome,
    String? partnerCountry,
    String? partnerState,
    String? partnerCity,
    String? partnerDivision,
    String? partnerLookingFor,
    String? partnerLifestyle,
    String? partnerHobbies,
    String? partnerMusic,
    String? partnerReading,
    String? partnerMoviesTvShows,
    String? partnerSportsAndFitness,
    String? partnerFood,
    String? partnerSpokenLanguages,
    String? partnerInterest,
    String? partnerViewList,
    String? partnerOccupation,
    String? partnerOwnHouse,
  }) {
    return PartnerDetailsModel(
      partnerFromAge: partnerFromAge ?? this.partnerFromAge,
      partnerToAge: partnerToAge ?? this.partnerToAge,
      partnerHeight: partnerHeight ?? this.partnerHeight,
      partnerWeight: partnerWeight ?? this.partnerWeight,
      partnerMaritalStatus: partnerMaritalStatus ?? this.partnerMaritalStatus,
      partnerMotherTongue: partnerMotherTongue ?? this.partnerMotherTongue,
      partnerPhysicalStatus:
          partnerPhysicalStatus ?? this.partnerPhysicalStatus,
      partnerEatingHabits: partnerEatingHabits ?? this.partnerEatingHabits,
      partnerDrinkingHabits:
          partnerDrinkingHabits ?? this.partnerDrinkingHabits,
      partnerSmokingHabits: partnerSmokingHabits ?? this.partnerSmokingHabits,
      partnerReligion: partnerReligion ?? this.partnerReligion,
      partnerCaste: partnerCaste ?? this.partnerCaste,
      partnerSubcaste: partnerSubcaste ?? this.partnerSubcaste,
      partnerStar: partnerStar ?? this.partnerStar,
      partnerRassi: partnerRassi ?? this.partnerRassi,
      partnerDosham: partnerDosham ?? this.partnerDosham,
      partnerEducation: partnerEducation ?? this.partnerEducation,
      partnerEmployedIn: partnerEmployedIn ?? this.partnerEmployedIn,
      partnerProfession: partnerProfession ?? this.partnerProfession,
      partnerAnnualIncome: partnerAnnualIncome ?? this.partnerAnnualIncome,
      partnerCountry: partnerCountry ?? this.partnerCountry,
      partnerState: partnerState ?? this.partnerState,
      partnerCity: partnerCity ?? this.partnerCity,
      partnerDivision: partnerDivision ?? this.partnerDivision,
      partnerLookingFor: partnerLookingFor ?? this.partnerLookingFor,
      partnerLifestyle: partnerLifestyle ?? this.partnerLifestyle,
      partnerHobbies: partnerHobbies ?? this.partnerHobbies,
      partnerMusic: partnerMusic ?? this.partnerMusic,
      partnerReading: partnerReading ?? this.partnerReading,
      partnerMoviesTvShows: partnerMoviesTvShows ?? this.partnerMoviesTvShows,
      partnerSportsAndFitness:
          partnerSportsAndFitness ?? this.partnerSportsAndFitness,
      partnerFood: partnerFood ?? this.partnerFood,
      partnerSpokenLanguages:
          partnerSpokenLanguages ?? this.partnerSpokenLanguages,
      partnerInterest: partnerInterest ?? this.partnerInterest,
      partnerViewList: partnerViewList ?? this.partnerViewList,
      partnerOccupation: partnerOccupation ?? this.partnerOccupation,
      partnerOwnHouse: partnerOwnHouse ?? this.partnerOwnHouse,
    );
  }

  @override
  List<Object?> get props => [
        partnerFromAge,
        partnerToAge,
        partnerHeight,
        partnerWeight,
        partnerMaritalStatus,
        partnerMotherTongue,
        partnerPhysicalStatus,
        partnerEatingHabits,
        partnerDrinkingHabits,
        partnerSmokingHabits,
        partnerReligion,
        partnerCaste,
        partnerSubcaste,
        partnerStar,
        partnerRassi,
        partnerDosham,
        partnerEducation,
        partnerEmployedIn,
        partnerProfession,
        partnerAnnualIncome,
        partnerCountry,
        partnerState,
        partnerCity,
        partnerDivision,
        partnerLookingFor,
        partnerLifestyle,
        partnerHobbies,
        partnerMusic,
        partnerReading,
        partnerMoviesTvShows,
        partnerSportsAndFitness,
        partnerFood,
        partnerSpokenLanguages,
        partnerInterest,
        partnerViewList,
        partnerOccupation,
        partnerOwnHouse,
      ];
}
