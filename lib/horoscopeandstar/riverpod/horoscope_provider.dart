import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/horoscopeandstar/riverpod/horoscope_state.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/models/user_details_model.dart';

/// Define the HoroscopeNotifier to manage HoroscopeState
class HoroscopeNotifier extends StateNotifier<HoroscopeState> {
  HoroscopeNotifier() : super(HoroscopeState());

  /// Update individual fields using the copyWith method
  void updateDateOfBirth(String dateOfBirth) {
    state = state.copyWith(dateOfBirth: dateOfBirth);
  }

  void updateTimeOfBirth(String timeOfBirth) {
    state = state.copyWith(timeOfBirth: timeOfBirth);
  }

  void updateBirthCountry(String birthCountry) {
    state = state.copyWith(birthCountry: birthCountry);
  }

  void updateBirthState(String birthState) {
    state = state.copyWith(birthState: birthState);
  }

  void updateBirthCity(String birthCity) {
    state = state.copyWith(birthCity: birthCity);
  }

  /// Optionally, reset the entire state
  void resetHoroscope() {
    state = HoroscopeState();
  }

  void setHoroscope(UserDetails userDetails) {
    // state = state.copyWith(dateOfBirth: )
  }

  Future<bool> editHoroscope() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editHoroscope),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'dob': state.dateOfBirth,
          'timeOfBirth': state.timeOfBirth,
          'countryOfBirth': state.birthCountry,
          'stateOfBirth': state.birthState,
          'cityOfBirth': state.birthCity
        }),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        state = state.copyWith(
          isLoading: false,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
        );
        return false;
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
      );
      return false;
    }
  }
}

/// Create the provider
final horoscopeProvider =
    StateNotifierProvider<HoroscopeNotifier, HoroscopeState>((ref) {
  return HoroscopeNotifier();
});
