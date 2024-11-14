import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchFilterInput {
  int? userId;
  int? fromAge;
  int? toAge;
  String? height;
  String? maritalStatus;
  String? motherTongue;
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
    this.fromAge = 0,
    this.toAge = 0,
    this.height = "",
    this.maritalStatus = "",
    this.motherTongue = "",
    this.physicalStatus = "",
    this.eatingHabits = "",
    this.drinkingHabits = "",
    this.smokingHabits = "",
    this.religion = "",
    this.caste = "",
    this.subcaste = "",
    this.star = "",
    this.rassi = "",
    this.dosham = "",
    this.education = "",
    this.employedIn = "",
    this.profession = "",
    this.annualIncome = "",
    this.country = "",
    this.states = "",
    this.city = "",
    this.lookingFor = "",
    this.lifestyle = "",
    this.hobbies = "",
    this.music = "",
    this.reading = "",
    this.moviesTvShows = "",
    this.sportsAndFitness = "",
    this.food = "",
    this.spokenLanguages = "",
    this.interest = "",
  });

  @override
  String toString() {
    return 'SearchFilterInput( fromAge: $fromAge, toAge: $toAge, height: $height, maritalStatus: $maritalStatus, motherTongue: $motherTongue, physicalStatus: $physicalStatus, eatingHabits: $eatingHabits, drinkingHabits: $drinkingHabits, smokingHabits: $smokingHabits, religion: $religion, caste: $caste, subcaste: $subcaste, star: $star, rassi: $rassi, dosham: $dosham, education: $education, employedIn: $employedIn, profession: $profession, annualIncome: $annualIncome, country: $country, states: $states, city: $city, lookingFor: $lookingFor, lifestyle: $lifestyle, hobbies: $hobbies, music: $music, reading: $reading, moviesTvShows: $moviesTvShows, sportsAndFitness: $sportsAndFitness, food: $food, spokenLanguages: $spokenLanguages, interest: $interest)';
  }
}

class SearchFilterInputNotifier extends StateNotifier<SearchFilterInput?> {
  SearchFilterInputNotifier()
      : super(SearchFilterInput()); // Initialize with default empty values

  void updateSearchFilterInput({
    int? fromAge,
    int? toAge,
    String? height,
    String? maritalStatus,
    String? motherTongue,
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
    state = SearchFilterInput(
      fromAge: fromAge ?? state?.fromAge,
      toAge: toAge ?? state?.toAge,
      height: height ?? state?.height,
      maritalStatus: maritalStatus ?? state?.maritalStatus,
      motherTongue: motherTongue ?? state?.motherTongue,
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

    // Print the updated state
    print("Updated SearchFilterInput: ${state.toString()}");
  }
}

final searchFilterInputProvider =
    StateNotifierProvider<SearchFilterInputNotifier, SearchFilterInput?>((ref) {
  return SearchFilterInputNotifier();
});
