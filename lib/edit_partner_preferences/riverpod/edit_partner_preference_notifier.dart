import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_state.dart';
import 'package:matrimony/models/partner_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/models/religion_model.dart';
import 'package:matrimony/user_auth_screens/register_screens/register_partner_preparence_screens/partner_preference_location_screen/riverpod/location_api_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPartnerPreferenceNotifier
    extends StateNotifier<EditPartnerPreferenceState> {
  EditPartnerPreferenceNotifier() : super(EditPartnerPreferenceState());

  void updateFromAge(String age) => state = state.copyWith(fromAge: age);

  void updateToAge(String age) => state = state.copyWith(toAge: age);

  void updateFromHeight(String height) =>
      state = state.copyWith(fromHeight: height);

  void updateToHeight(String height) =>
      state = state.copyWith(toHeight: height);

  void updateFromWeight(String weight) =>
      state = state.copyWith(fromWeight: weight);

  void updateToWeight(String weight) =>
      state = state.copyWith(toWeight: weight);

  void updateMotherTongue(String motherTongue) =>
      state = state.copyWith(motherTongue: motherTongue);

  void updateMaritalStatus(String maritalStatus) =>
      state = state.copyWith(maritalStatus: maritalStatus);

  void updatePhysicalStatus(String physicalStatus) =>
      state = state.copyWith(physicalStatus: physicalStatus);

  void updateReligion(String religion) {
    state = state.copyWith(
        religion: religion,
        caste: religion != state.religion ? '' : state.caste,
        subCaste: religion != state.religion ? '' : state.subCaste);
  }

  void updateCaste(String caste) {
    state = state.copyWith(
        caste: caste, subCaste: caste != state.caste ? '' : state.subCaste);
  }

  void updateSubCaste(String subCaste) =>
      state = state.copyWith(subCaste: subCaste);

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

  void updateCountry(String country) => state = state.copyWith(
      country: country,
      state: country != state.country ? '' : state.state,
      city: country != state.country ? '' : state.city);

  void updateState(String stateValue) => state = state.copyWith(
      state: stateValue, city: stateValue != state.state ? '' : state.city);

  void updateCity(String city) => state = state.copyWith(city: city);

  void updateIsOwnHouse(bool isOwnHouse) =>
      state = state.copyWith(isOwnHouse: isOwnHouse);

  void updateEatingHabits(String eatingHabits) =>
      state = state.copyWith(eatingHabits: eatingHabits);

  void updateSmokingHabits(String smokingHabits) =>
      state = state.copyWith(smokingHabits: smokingHabits);

  void updateDrinkingHabits(String drinkingHabits) =>
      state = state.copyWith(drinkingHabits: drinkingHabits);

  void setValuesInitial(PartnerDetailsModel partnerDetails) {
    state = state.copyWith(
        fromAge: partnerDetails.partnerFromAge.toString(),
        toAge: partnerDetails.partnerToAge.toString(),
        fromWeight: partnerDetails.partnerFromWeight.toString(),
        toWeight: partnerDetails.partnerToWeight.toString(),
        fromHeight: partnerDetails.partnerFromHeight,
        toHeight: partnerDetails.partnerToHeight,
        maritalStatus: partnerDetails.partnerMaritalStatus,
        motherTongue: partnerDetails.partnerMotherTongue,
        physicalStatus: partnerDetails.partnerPhysicalStatus);
  }

  void setLifeStyleValues(PartnerDetailsModel partnerDetails) {
    state = state.copyWith(
        smokingHabits: partnerDetails.partnerSmokingHabits,
        eatingHabits: partnerDetails.partnerEatingHabits,
        drinkingHabits: partnerDetails.partnerDrinkingHabits);
  }

  void setReligionValues(PartnerDetailsModel partnerDetails) {
    state = state.copyWith(
        religion: partnerDetails.partnerReligion,
        caste: partnerDetails.partnerCaste,
        subCaste: partnerDetails.partnerSubcaste,
        raasi: partnerDetails.partnerRassi,
        star: partnerDetails.partnerStar);
  }

  void setProfessionalValues(PartnerDetailsModel partnerDetails) {
    state = state.copyWith(
        education: partnerDetails.partnerEducation,
        employmentType: partnerDetails.partnerEmployedIn,
        occupation: partnerDetails.partnerProfession ??
            partnerDetails.partnerOccupation,
        annulIncome: partnerDetails.partnerAnnualIncome);
  }

  void setLocationValues(PartnerDetailsModel partnerDetails) {
    state = state.copyWith(
        country: partnerDetails.partnerCountry,
        state: partnerDetails.partnerState,
        city: partnerDetails.partnerCity,
        isOwnHouse: partnerDetails.partnerOwnHouse == 'true' ? true : false);
  }

  void resetState() => state = EditPartnerPreferenceState();

  Future<bool> updateBasicDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editBacicPreference),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'fromAge': state.fromAge,
          'toAge': state.toAge,
          'fromHeight': state.fromHeight,
          'toHeight': state.toHeight,
          'fromWeight': state.fromWeight,
          'toWeight': state.toWeight,
          'maritalStatus': state.maritalStatus,
          'motherTongue': state.motherTongue,
          'physicalStatus': state.physicalStatus
        }),
      );
      print(response.body);
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

  Future<bool> updateLifeStyleDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.edithobbiesPreference),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'eatingHabits': state.eatingHabits,
          'drinkingHabits': state.drinkingHabits,
          'smokingHabits': state.smokingHabits
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

  Future<bool> updateProfessionalDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editProfessionalPreference),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'education': state.education,
          'employedIn': state.employmentType,
          'annualIncome': state.annulIncome,
          'occupation': state.occupation,
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

  Future<bool> updateReligionDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editReligiousPreference),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'religion': state.religion,
          'caste': state.caste,
          'subcaste': state.subCaste,
          'star': state.star,
          'rassi': state.raasi
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

  Future<bool> updateLocationDetails() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      final response = await http.put(
        Uri.parse(Api.editlocationPreference),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'country': state.country,
          'state': state.state,
          'city': state.city,
          'ownHouse': state.isOwnHouse != null
              ? state.isOwnHouse!
                  ? 'true'
                  : 'false'
              : null
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

  Future<void> getReligiousDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final religionString = prefs.getString('religion');
    int? religionId;
    if (religionString != null && religionString.isNotEmpty) {
      final List<dynamic> religious = jsonDecode(religionString);
      List<Religion> religionList = religious
          .map((e) => Religion.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.religion == state.religion) {
          religionId = a.id;
          break;
        }
      }
      state = state.copyWith(religionList: religionList);
    } else {
      state = state.copyWith(religionList: []);
    }
    getCasteDetails(religionId);
  }

  Future<void> getCasteDetails(int? religionId) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('caste');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<Caste> casteList = castes
          .map((e) => Caste.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.religionId == religionId)
          .toList();
      for (final a in casteList) {
        if (a.castes == state.caste) {
          casteId = a.id;
          break;
        }
      }
      state = state.copyWith(casteList: casteList);
    } else {
      state = state.copyWith(casteList: []);
    }
    getSubCasteDetails(casteId);
  }

  Future<void> getSubCasteDetails(int? casteId) async {
    final prefs = await SharedPreferences.getInstance();
    final subCaste = prefs.getString('subcaste');
    if (subCaste != null && subCaste.isNotEmpty) {
      final List<dynamic> subCastes = jsonDecode(subCaste);
      List<SubCaste> subCasteList = subCastes
          .map((e) => SubCaste.fromJson(e as Map<String, dynamic>))
          .where((subcaste) => subcaste.casteId == casteId)
          .toList();
      state = state.copyWith(subCasteList: subCasteList);
    } else {
      state = state.copyWith(subCasteList: []);
    }
  }

  Future<void> getCasteDetailsList(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('caste');
    final religion = prefs.getString('religion');
    int? religionId;
    if (religion != null && religion.isNotEmpty) {
      final List<dynamic> religions = jsonDecode(religion);
      List<Religion> religionList = religions
          .map((e) => Religion.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.religion == value) {
          religionId = a.id;
          break;
        }
      }
    }
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<Caste> casteList = castes
          .map((e) => Caste.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.religionId == religionId)
          .toList();
      state = state.copyWith(casteList: casteList, subCasteList: []);
    } else {
      state = state.copyWith(casteList: [], subCasteList: []);
    }
  }

  Future<void> getSubCasteDetailsList(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final subcaste = prefs.getString('subcaste');
    final caste = prefs.getString('caste');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<Caste> casteList =
          castes.map((e) => Caste.fromJson(e as Map<String, dynamic>)).toList();
      for (final a in casteList) {
        if (a.castes == value) {
          casteId = a.id;
          break;
        }
      }
    }
    if (subcaste != null && subcaste.isNotEmpty) {
      final List<dynamic> subcastes = jsonDecode(subcaste);
      List<SubCaste> subcasteList = subcastes
          .map((e) => SubCaste.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.casteId == casteId)
          .toList();
      // subcasteList.removeWhere((caste) => caste.casteId != casteId);
      state = state.copyWith(subCasteList: subcasteList);
    } else {
      state = state.copyWith(subCasteList: []);
    }
  }

  Future<void> getCountryDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final religionString = prefs.getString('country');
    int? religionId;
    if (religionString != null && religionString.isNotEmpty) {
      final List<dynamic> religious = jsonDecode(religionString);
      List<Country> religionList = religious
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.countrys == state.country) {
          religionId = a.id;
          break;
        }
      }
      state = state.copyWith(countryList: religionList);
    } else {
      state = state.copyWith(countryList: []);
    }
    getStateDetails(religionId);
  }

  Future<void> getStateDetails(int? religionId) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('state');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<StateModel> casteList = castes
          .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.countryId == religionId)
          .toList();
      for (final a in casteList) {
        if (a.states == state.state) {
          casteId = a.id;
          break;
        }
      }
      state = state.copyWith(stateList: casteList);
    } else {
      state = state.copyWith(stateList: []);
    }
    getCityDetails(casteId);
  }

  Future<void> getCityDetails(int? casteId) async {
    final prefs = await SharedPreferences.getInstance();
    final subCaste = prefs.getString('city');
    if (subCaste != null && subCaste.isNotEmpty) {
      final List<dynamic> subCastes = jsonDecode(subCaste);
      List<City> subCasteList = subCastes
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .where((subcaste) => subcaste.stateId == casteId)
          .toList();
      state = state.copyWith(cityList: subCasteList);
    } else {
      state = state.copyWith(cityList: []);
    }
  }

  Future<void> getStateDetailsList(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final caste = prefs.getString('state');
    final religion = prefs.getString('country');
    int? religionId;
    if (religion != null && religion.isNotEmpty) {
      final List<dynamic> religions = jsonDecode(religion);
      List<Country> religionList = religions
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in religionList) {
        if (a.countrys == value) {
          religionId = a.id;
          break;
        }
      }
    }
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<StateModel> casteList = castes
          .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.countryId == religionId)
          .toList();
      state = state.copyWith(stateList: casteList, cityList: []);
    } else {
      state = state.copyWith(stateList: [], cityList: []);
    }
  }

  Future<void> getCityDetailsList(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final subcaste = prefs.getString('city');
    final caste = prefs.getString('state');
    int? casteId;
    if (caste != null && caste.isNotEmpty) {
      final List<dynamic> castes = jsonDecode(caste);
      List<StateModel> casteList = castes
          .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
          .toList();
      for (final a in casteList) {
        if (a.states == value) {
          casteId = a.id;
          break;
        }
      }
    }
    if (subcaste != null && subcaste.isNotEmpty) {
      final List<dynamic> subcastes = jsonDecode(subcaste);
      List<City> subcasteList = subcastes
          .map((e) => City.fromJson(e as Map<String, dynamic>))
          .where((caste) => caste.stateId == casteId)
          .toList();
      // subcasteList.removeWhere((caste) => caste.casteId != casteId);
      state = state.copyWith(cityList: subcasteList);
    } else {
      state = state.copyWith(cityList: []);
    }
  }
}
