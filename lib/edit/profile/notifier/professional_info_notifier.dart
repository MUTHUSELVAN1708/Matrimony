import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/models/user_details_model.dart';
import '../state/professional_info_state.dart';
import 'package:http/http.dart' as http;

class ProfessionalInfoNotifier extends StateNotifier<ProfessionalInfoState> {
  ProfessionalInfoNotifier() : super(ProfessionalInfoState());

  void updateEducation(String value) {
    state = state.copyWith(education: value);
  }

  void updateCollege(String value) {
    state = state.copyWith(college: value);
  }

  void updateEmployedIn(String value) {
    state = state.copyWith(employedIn: value);
  }

  void updateOccupation(String value) {
    state = state.copyWith(occupation: value);
  }

  void updateCitizenship(String value) {
    state = state.copyWith(citizenship: value);
  }

  void updateOrganization(String value) {
    state = state.copyWith(organization: value);
  }

  void updateCurrencyType(String value) {
    state = state.copyWith(currencyType: value);
  }

  void updateAnnualIncome(String value) {
    state = state.copyWith(annualIncome: value);
  }

  void setProfessionalDetails(UserDetails userDetails) {
    state = state.copyWith(
        education: userDetails.education,
        annualIncome: userDetails.annualIncome,
        citizenship: userDetails.citizenShip,
        currencyType: userDetails.annualIncomeCurrency,
        employedIn: userDetails.employedType,
        occupation: userDetails.occupation);
  }

  Future<bool> updateProfessionalDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editProfession),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'education': state.education,
          'occupation': state.occupation,
          'annualIncome': state.annualIncome,
          'annualIncomeCurrency': state.currencyType,
          'citizenShip': state.citizenship,
          'employedType': state.employedIn
        }),
      );

      if (response.statusCode == 200) {
        // final data = jsonDecode(response.body) as List<dynamic>;
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

  void disposeState() => state = ProfessionalInfoState();

  bool validateForm() {
    return state.education != null &&
        state.college?.isNotEmpty == true &&
        state.employedIn != null &&
        state.occupation != null &&
        state.citizenship != null &&
        state.organization?.isNotEmpty == true &&
        state.currencyType != null &&
        state.annualIncome != null;
  }

  void saveForm() {
    // Add logic to save the form data
    // This could involve making an API call or storing locally
  }
}
