import 'package:flutter_riverpod/flutter_riverpod.dart';

class PreferenceInput {
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


  PreferenceInput({
    this.userId,
    this.fromAge,
    this.toAge,
    this.height,
    this.maritalStatus,
    this.motherTongue,
    this.physicalStatus,
    this.eatingHabits,
    this.drinkingHabits,
    this.smokingHabits,
    this.religion,
    this.caste,
    this.subcaste,
    this.star,
    this.rassi,
    this.dosham,
    this.education,
    this.employedIn,
    this.profession,
    this.annualIncome,
    this.country,
    this.states,
    this.city,
    this.lookingFor,
    this.lifestyle,
    this.hobbies,
    this.music,
    this.reading,
    this.moviesTvShows,
    this.sportsAndFitness,
    this.food,
    this.spokenLanguages,
    this.interest,
  });
}

class PreferenceInputNotifier extends StateNotifier<PreferenceInput?> {
  PreferenceInputNotifier() : super(null);

  void updatePreferenceInput({
    int? userId,
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
    state = PreferenceInput(
      userId: userId ?? state?.userId,
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
  }
}

final preferenceInputProvider = StateNotifierProvider<PreferenceInputNotifier, PreferenceInput?>((ref) {
  return PreferenceInputNotifier();
});
