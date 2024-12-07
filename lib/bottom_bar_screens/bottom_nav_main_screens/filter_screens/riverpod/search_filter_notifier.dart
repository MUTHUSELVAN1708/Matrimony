import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/models/partner_details_model.dart';

class SearchFilterInput {
  int? userId;
  int? fromAge;
  int? toAge;
  String? fromHeight;
  String? toHeight;
  String? maritalStatus;
  String? motherTongue;
  String? profileCreatedBy;
  String? physicalStatus;
  String? eatingHabits;
  String? drinkingHabits;
  String? smokingHabits;
  String? religion;
  String? caste;
  String? subcaste;
  String? star;
  String? rassi;
  String? dosham;
  String? education;
  String? employedIn;
  String? profession;
  String? annualIncome;
  String? country;
  String? states;
  String? city;
  String? lookingFor;
  String? lifestyle;
  String? hobbies;
  String? music;
  String? reading;
  String? moviesTvShows;
  String? sportsAndFitness;
  String? food;
  String? spokenLanguages;
  String? interest;

  // Constructor with default values (empty or zero values)
  SearchFilterInput({
    this.userId,
    this.fromAge = 18,
    this.toAge = 40,
    this.fromHeight = "4 ft 6 in (137 cm)",
    this.toHeight = "6 ft 9 in (206 cm)",
    this.maritalStatus = "Any",
    this.motherTongue = "Any",
    this.profileCreatedBy = 'Any',
    this.physicalStatus = "Doesn’t Matter",
    this.eatingHabits = "Doesn’t Matter",
    this.drinkingHabits = "Doesn’t Matter",
    this.smokingHabits = "Doesn’t Matter",
    this.religion = "Any",
    this.caste = "Any",
    this.subcaste = "Any",
    this.star = "Any",
    this.rassi = "Any",
    this.dosham = "Any",
    this.education = "Any",
    this.employedIn = "Any",
    this.profession = "Any",
    this.annualIncome = "Any",
    this.country = "Any",
    this.states = "Any",
    this.city = "Any",
    this.lookingFor = "Any",
    this.lifestyle = "Any",
    this.hobbies = "Any",
    this.music = "Any",
    this.reading = "Any",
    this.moviesTvShows = "Any",
    this.sportsAndFitness = "Any",
    this.food = "Any",
    this.spokenLanguages = "Any",
    this.interest = "Any",
  });

  // CopyWith method
  SearchFilterInput copyWith({
    int? userId,
    int? fromAge,
    int? toAge,
    String? fromHeight,
    String? toHeight,
    String? maritalStatus,
    String? motherTongue,
    String? profileCreatedBy,
    String? physicalStatus,
    String? eatingHabits,
    String? drinkingHabits,
    String? smokingHabits,
    String? religion,
    String? caste,
    String? subcaste,
    String? star,
    String? rassi,
    String? dosham,
    String? education,
    String? employedIn,
    String? profession,
    String? annualIncome,
    String? country,
    String? states,
    String? city,
    String? lookingFor,
    String? lifestyle,
    String? hobbies,
    String? music,
    String? reading,
    String? moviesTvShows,
    String? sportsAndFitness,
    String? food,
    String? spokenLanguages,
    String? interest,
  }) {
    return SearchFilterInput(
      userId: userId ?? this.userId,
      fromAge: fromAge ?? this.fromAge,
      toAge: toAge ?? this.toAge,
      fromHeight: fromHeight ?? this.fromHeight,
      toHeight: toHeight ?? this.toHeight,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      motherTongue: motherTongue ?? this.motherTongue,
      profileCreatedBy: profileCreatedBy ?? this.profileCreatedBy,
      physicalStatus: physicalStatus ?? this.physicalStatus,
      eatingHabits: eatingHabits ?? this.eatingHabits,
      drinkingHabits: drinkingHabits ?? this.drinkingHabits,
      smokingHabits: smokingHabits ?? this.smokingHabits,
      religion: religion ?? this.religion,
      caste: caste ?? this.caste,
      subcaste: subcaste ?? this.subcaste,
      star: star ?? this.star,
      rassi: rassi ?? this.rassi,
      dosham: dosham ?? this.dosham,
      education: education ?? this.education,
      employedIn: employedIn ?? this.employedIn,
      profession: profession ?? this.profession,
      annualIncome: annualIncome ?? this.annualIncome,
      country: country ?? this.country,
      states: states ?? this.states,
      city: city ?? this.city,
      lookingFor: lookingFor ?? this.lookingFor,
      lifestyle: lifestyle ?? this.lifestyle,
      hobbies: hobbies ?? this.hobbies,
      music: music ?? this.music,
      reading: reading ?? this.reading,
      moviesTvShows: moviesTvShows ?? this.moviesTvShows,
      sportsAndFitness: sportsAndFitness ?? this.sportsAndFitness,
      food: food ?? this.food,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      interest: interest ?? this.interest,
    );
  }

  @override
  String toString() {
    return 'SearchFilterInput( fromAge: $fromAge, toAge: $toAge, fromHeight: $fromHeight,toHeight: $toHeight, maritalStatus: $maritalStatus, motherTongue: $motherTongue, physicalStatus: $physicalStatus, eatingHabits: $eatingHabits, drinkingHabits: $drinkingHabits, smokingHabits: $smokingHabits, religion: $religion, caste: $caste, subcaste: $subcaste, star: $star, rassi: $rassi, dosham: $dosham, education: $education, employedIn: $employedIn, profession: $profession, annualIncome: $annualIncome, country: $country, states: $states, city: $city, lookingFor: $lookingFor, lifestyle: $lifestyle, hobbies: $hobbies, music: $music, reading: $reading, moviesTvShows: $moviesTvShows, sportsAndFitness: $sportsAndFitness, food: $food, spokenLanguages: $spokenLanguages, interest: $interest)';
  }
}

class SearchFilterInputNotifier extends StateNotifier<SearchFilterInput?> {
  SearchFilterInputNotifier() : super(SearchFilterInput());

  void updateSearchFilterInput({
    int? fromAge,
    int? toAge,
    String? fromHeight,
    String? toHeight,
    String? maritalStatus,
    String? motherTongue,
    String? physicalStatus,
    String? profileCreatedBy,
    String? eatingHabits,
    String? drinkingHabits,
    String? smokingHabits,
    String? religion,
    String? caste,
    String? subcaste,
    String? star,
    String? rassi,
    String? dosham,
    String? education,
    String? employedIn,
    String? profession,
    String? annualIncome,
    String? country,
    String? states,
    String? city,
    String? lookingFor,
    String? lifestyle,
    String? hobbies,
    String? music,
    String? reading,
    String? moviesTvShows,
    String? sportsAndFitness,
    String? food,
    String? spokenLanguages,
    String? interest,
  }) {
    state = SearchFilterInput(
      fromAge: fromAge ?? state?.fromAge,
      toAge: toAge ?? state?.toAge,
      fromHeight: fromHeight ?? state?.fromHeight,
      toHeight: toHeight ?? state?.toHeight,
      maritalStatus: maritalStatus ?? state?.maritalStatus,
      motherTongue: motherTongue ?? state?.motherTongue,
      profileCreatedBy: profileCreatedBy ?? state?.profileCreatedBy,
      physicalStatus: physicalStatus ?? state?.physicalStatus,
      eatingHabits: eatingHabits ?? state?.eatingHabits,
      drinkingHabits: drinkingHabits ?? state?.drinkingHabits,
      smokingHabits: smokingHabits ?? state?.smokingHabits,
      religion: religion ?? state?.religion,
      caste: caste ?? state?.caste,
      subcaste: subcaste ?? state?.subcaste,
      star: star ?? state?.star,
      rassi: rassi ?? state?.rassi,
      dosham: dosham ?? state?.dosham,
      education: education ?? state?.education,
      employedIn: employedIn ?? state?.employedIn,
      profession: profession ?? state?.profession,
      annualIncome: annualIncome ?? state?.annualIncome,
      country: country ?? state?.country,
      states: states ?? state?.states,
      city: city ?? state?.city,
      lookingFor: lookingFor ?? state?.lookingFor,
      lifestyle: lifestyle ?? state?.lifestyle,
      hobbies: hobbies ?? state?.hobbies,
      music: music ?? state?.music,
      reading: reading ?? state?.reading,
      moviesTvShows: moviesTvShows ?? state?.moviesTvShows,
      sportsAndFitness: sportsAndFitness ?? state?.sportsAndFitness,
      food: food ?? state?.food,
      spokenLanguages: spokenLanguages ?? state?.spokenLanguages,
      interest: interest ?? state?.interest,
    );

    print("Updated SearchFilterInput: ${state.toString()}");
  }

  void setSearchFilterInput(PartnerDetailsModel partnerDetails) {
    state = SearchFilterInput(
      fromAge: isNullOrEmpty(partnerDetails.partnerFromAge?.toString())
          ? state?.fromAge
          : partnerDetails.partnerFromAge,
      toAge: isNullOrEmpty(partnerDetails.partnerToAge?.toString())
          ? state?.toAge
          : partnerDetails.partnerToAge,
      fromHeight: isNullOrEmpty(partnerDetails.partnerFromHeight)
          ? state?.fromHeight
          : partnerDetails.partnerFromHeight,
      toHeight: isNullOrEmpty(partnerDetails.partnerToHeight)
          ? state?.toHeight
          : partnerDetails.partnerToHeight,
      maritalStatus: isNullOrEmpty(partnerDetails.partnerMaritalStatus)
          ? state?.maritalStatus
          : partnerDetails.partnerMaritalStatus,
      motherTongue: isNullOrEmpty(partnerDetails.partnerMotherTongue)
          ? state?.motherTongue
          : partnerDetails.partnerMotherTongue,
      profileCreatedBy: state?.profileCreatedBy,
      physicalStatus: isNullOrEmpty(partnerDetails.partnerPhysicalStatus)
          ? state?.physicalStatus
          : partnerDetails.partnerPhysicalStatus,
      eatingHabits: isNullOrEmpty(partnerDetails.partnerEatingHabits)
          ? state?.eatingHabits
          : partnerDetails.partnerEatingHabits,
      drinkingHabits: isNullOrEmpty(partnerDetails.partnerDrinkingHabits)
          ? state?.drinkingHabits
          : partnerDetails.partnerDrinkingHabits,
      smokingHabits: isNullOrEmpty(partnerDetails.partnerSmokingHabits)
          ? state?.smokingHabits
          : partnerDetails.partnerSmokingHabits,
      religion: isNullOrEmpty(partnerDetails.partnerReligion)
          ? state?.religion
          : partnerDetails.partnerReligion,
      caste: isNullOrEmpty(partnerDetails.partnerCaste)
          ? state?.caste
          : partnerDetails.partnerCaste,
      subcaste: isNullOrEmpty(partnerDetails.partnerSubcaste)
          ? state?.subcaste
          : partnerDetails.partnerSubcaste,
      star: isNullOrEmpty(partnerDetails.partnerStar)
          ? state?.star
          : partnerDetails.partnerStar,
      rassi: isNullOrEmpty(partnerDetails.partnerRassi)
          ? state?.rassi
          : partnerDetails.partnerRassi,
      dosham: state?.dosham,
      education: isNullOrEmpty(partnerDetails.partnerEducation)
          ? state?.education
          : partnerDetails.partnerEducation,
      employedIn: isNullOrEmpty(partnerDetails.partnerEmployedIn)
          ? state?.employedIn
          : partnerDetails.partnerEmployedIn,
      profession: isNullOrEmpty(partnerDetails.partnerProfession)
          ? isNullOrEmpty(partnerDetails.partnerOccupation)
              ? state?.profession
              : partnerDetails.partnerOccupation
          : partnerDetails.partnerProfession,
      annualIncome: isNullOrEmpty(partnerDetails.partnerAnnualIncome)
          ? state?.annualIncome
          : partnerDetails.partnerAnnualIncome,
      country: isNullOrEmpty(partnerDetails.partnerCountry)
          ? state?.country
          : partnerDetails.partnerCountry,
      states: isNullOrEmpty(partnerDetails.partnerState)
          ? state?.states
          : partnerDetails.partnerState,
      city: isNullOrEmpty(partnerDetails.partnerCity)
          ? state?.city
          : partnerDetails.partnerCity,
    );
  }

  bool isNullOrEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  void updateInputHabitsValues(String? key, List<String> values) {
    if (key == 'drinkingHabits') {
      state = state?.copyWith(drinkingHabits: values.first);
    } else if (key == 'smokingHabits') {
      state = state?.copyWith(smokingHabits: values.first);
    } else if (key == 'eatingHabits') {
      state = state?.copyWith(eatingHabits: values.first);
    } else if (key == 'physicalStatus') {
      state = state?.copyWith(physicalStatus: values.first);
    } else {
      state = state?.copyWith(profileCreatedBy: values.first);
    }
    print("Updated drinkingHabits: ${state?.smokingHabits}");
  }

  void updateInputAgeValues(
      String? key, List<String> fromAge, List<String> toAge) {
    if (key == 'fromAge') {
      state = state?.copyWith(
          fromAge: int.parse(fromAge.first), toAge: int.parse(toAge.first));
    }
  }

  void updateInputHeightValues(
      String? key, List<String> fromItem, List<String> toItem) {
    if (key == 'fromHeight') {
      state =
          state?.copyWith(fromHeight: fromItem.first, toHeight: toItem.first);
    }
  }

  void updateInputAnyValues(String? key, List<String> values) {
    if (key == 'Mother Tongue') {
      state = state?.copyWith(motherTongue: values.first);
    } else if (key == 'Marital Status') {
      state = state?.copyWith(maritalStatus: values.first);
    } else if (key == 'Physical Status') {
      state = state?.copyWith(physicalStatus: values.first);
    } else if (key == 'Education') {
      state = state?.copyWith(education: values.first);
    } else if (key == 'annual income') {
      state = state?.copyWith(annualIncome: values.first);
    } else if (key == 'employment type') {
      state = state?.copyWith(employedIn: values.first);
    } else if (key == 'Occupation') {
      state = state?.copyWith(profession: values.first);
    }
  }

  void updateInputReligionValues(
    String? key,
    List<String> values,
  ) {
    if (key == 'religion') {
      state = state?.copyWith(
          religion: values.first,
          caste: values.first == 'Any' ? 'Any' : state?.caste,
          subcaste: values.first == 'Any' ? 'Any' : state?.subcaste);
    } else if (key == 'caste') {
      state = state?.copyWith(
          caste: values.first,
          subcaste: values.first == 'Any' ? 'Any' : state?.subcaste);
    } else if (key == 'subCaste') {
      state = state?.copyWith(subcaste: values.first);
    } else if (key == 'country') {
      state = state?.copyWith(
          country: values.first,
          states: values.first == 'Any' ? 'Any' : state?.states,
          city: values.first == 'Any' ? 'Any' : state?.city);
    } else if (key == 'state') {
      state = state?.copyWith(
          states: values.first,
          city: values.first == 'Any' ? 'Any' : state?.city);
    } else if (key == 'city') {
      state = state?.copyWith(city: values.first);
    }
  }
}

final searchFilterInputProvider =
    StateNotifierProvider<SearchFilterInputNotifier, SearchFilterInput?>((ref) {
  return SearchFilterInputNotifier();
});
