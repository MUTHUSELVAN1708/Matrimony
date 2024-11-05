import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:http/http.dart' as http;

class PartnerPreferenceState<T> {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  PartnerPreferenceState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  PartnerPreferenceState<T> copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return PartnerPreferenceState<T>(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

class PartnerPreferenceNotifier<T> extends StateNotifier<PartnerPreferenceState<T>> {
  PartnerPreferenceNotifier() : super(PartnerPreferenceState<T>());

  Future<void> uploadPartnerPreference({
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
    String? subCaste,
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
    
  }) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);
    try {
      final response = await http.post(
        Uri.parse(Api.createpartnerPreference), 
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,     
          'fromAge': fromAge,
          'toAge': toAge,
          'height': height,
          'maritalStatus': maritalStatus,
          'motherTongue': motherTongue,
          'physicalStatus': physicalStatus,
          'eatingHabits': eatingHabits,
          'drinkingHabits': drinkingHabits,
          'smokingHabits': smokingHabits,
          'religion': religion,
          'caste': caste,
          'subCaste': subCaste,
          'star': star,
          'rassi': rassi,
          'dosham': dosham,
          'education': education,
          'employedIn': employedIn,
          'profession': profession,
          'annualIncome': annualIncome,
          'country': country,
          'state': states,
          'city': city,
          'lookingFor': lookingFor,
          'lifestyle': lifestyle,
          'hobbies': hobbies,
          'music': music,
          'reading': reading,
          'moviesTvShows': moviesTvShows,
          'sportsAndFitness': sportsAndFitness,
          'food': food,
          'spokenLanguages': spokenLanguages,
          'interest': interest,
        }),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(
          isLoading: false,
          successMessage: "Partner preference uploaded successfully!",
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to upload partner preference: ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final partnerPreferenceProvider = StateNotifierProvider<PartnerPreferenceNotifier<void>, PartnerPreferenceState<void>>((ref) {
  return PartnerPreferenceNotifier<void>();
});
