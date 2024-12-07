import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/edit/profile/providers/family_details_state.dart';
import 'package:matrimony/edit/profile/providers/profile_provider.dart';
import 'package:matrimony/edit/profile/state/edit_contact_state.dart';
import 'package:matrimony/edit/profile/state/location_state.dart';
import 'package:matrimony/edit/profile/state/professional_info_state.dart';
import 'package:matrimony/edit/profile/state/religious_state.dart';
import 'package:matrimony/edit_partner_preferences/riverpod/edit_partner_preference_state.dart';
import 'package:matrimony/horoscopeandstar/riverpod/horoscope_state.dart';
import 'package:matrimony/models/partner_details_model.dart';
import 'package:matrimony/models/riverpod/usermanagement_state.dart';
import 'package:matrimony/models/user_details_model.dart';
import 'package:matrimony/models/user_partner_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagementProvider extends StateNotifier<UserManagementState> {
  UserManagementProvider()
      : super(UserManagementState(
            userDetails: const UserDetails(),
            userPartnerDetails: const PartnerDetailsModel()));

  void resetState() => state = UserManagementState(
      userDetails: const UserDetails(),
      userPartnerDetails: const PartnerDetailsModel());

  Future<void> getUserDetails() async {
    state =
        state.copyWith(isLoadingForUser: true, error: null, userDetails: null);
    final int? userId = await SharedPrefHelper.getUserId();
    try {
      final response = await http.post(
        Uri.parse(Api.getProfileDetails),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        final userDetails = UserDetails.fromJson(jsonResponse);
        print('User');
        print(userDetails.toJson());
        final userPartnerDetails = PartnerDetailsModel.fromJson(jsonResponse);
        print('Partner');
        print(userPartnerDetails.toJson());
        print(userPartnerDetails.partnerProfession);
        state = state.copyWith(
            isLoadingForUser: false,
            userDetails: userDetails,
            userPartnerDetails: userPartnerDetails);
      } else {
        state = state.copyWith(
          isLoadingForUser: false,
          error: '',
        );
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoadingForUser: false,
        error: e.toString(),
      );
    }
  }

  Future<UserPartnerData?> getPartnerDetails(int userId) async {
    state = state.copyWith(
        isLoadingForPartner: true, error: null, partnerDetails: null);
    try {
      final response = await http.post(
        Uri.parse(Api.getProfileDetails),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        final partnerDetails = UserDetails.fromJson(jsonResponse);
        final partnerPartnerDetails =
            PartnerDetailsModel.fromJson(jsonResponse);
        // print(partnerDetails.toJson());
        // print(partnerPartnerDetails.toJson());
        state = state.copyWith(
            isLoadingForPartner: false,
            partnerDetails: partnerDetails,
            partnerPartnerDetails: partnerPartnerDetails);
        return UserPartnerData(
            partnerDetails: partnerPartnerDetails, userDetails: partnerDetails);
      } else {
        state = state.copyWith(
          isLoadingForPartner: false,
          error: '',
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingForPartner: false,
        error: e.toString(),
      );
      return null;
    }
  }

  void updateReligiousDetails(ReligiousState religiousState) {
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
            religion: religiousState.religion,
            star: religiousState.star,
            raasi: religiousState.raasi,
            caste: religiousState.caste,
            motherTongue: religiousState.motherTongue,
            subcaste: religiousState.subCaste,
            willingToMarryFromOtherCommunities:
                religiousState.willingToMarryOtherCommunities != null
                    ? religiousState.willingToMarryOtherCommunities!
                        ? 'true'
                        : 'false'
                    : null));
  }

  void updateLocationDetails(LocationState locationState) {
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
            country: locationState.country,
            state: locationState.state,
            pincode: locationState.pincode,
            city: locationState.city,
            flatNumber: locationState.flatNo,
            address: locationState.address,
            ownHouse: locationState.ownHouse != null
                ? locationState.ownHouse!
                    ? 'Yes'
                    : 'No'
                : null));
  }

  void updateContactDetails(EditContactState editContactState) {
    final countryCode = editContactState.currentPhoneNumber
        ?.substring(0, editContactState.currentPhoneNumber!.length - 10);
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
            email: editContactState.currentEmail,
            whomToContact: editContactState.whomToContact,
            comments: editContactState.comments,
            availableTimeToCall: editContactState.availableTimeToCall,
            phoneNumber: editContactState.newPhoneNumber != null &&
                    editContactState.newPhoneNumber!.isNotEmpty
                ? '$countryCode${editContactState.newPhoneNumber}'
                : editContactState.currentPhoneNumber,
            contactPersonName: editContactState.contactPersonsName));
  }

  void updateFamilyDetails(FamilyDetailsState familyDetailsState) {
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
            famliyValue: familyDetailsState.famliyValue,
            famliyType: familyDetailsState.famliyType,
            famliyStatus: familyDetailsState.famliyStatus,
            fatherName: familyDetailsState.fatherName,
            fatherOccupation: familyDetailsState.fatherOccupation,
            motherName: familyDetailsState.motherName,
            motherOccupation: familyDetailsState.motherOccupation,
            noOfSisters: familyDetailsState.noOfSisters,
            noOfBrothers: familyDetailsState.noOfBrothers,
            brotherMarried: familyDetailsState.brotherMarried,
            sisterMarried: familyDetailsState.sisterMarried));
  }

  void updateBasicDetails(ProfileState profileState) {
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
      skinTone: profileState.skinTone,
      physicalStatus: profileState.physicalStatus,
      profileFor: profileState.selectedProfile,
      name: profileState.selectedName,
      maritalStatus: profileState.maritalStatus,
      drinkingHabits: profileState.drinkingHabits,
      smokingHabits: profileState.smokingHabits,
      eatingHabits: profileState.eatingHabits,
      dateOfBirth: profileState.selectedDateOfBirth.toString(),
      age: calculateAge(profileState.selectedDateOfBirth),
      height: profileState.selectedHeight,
      weight: profileState.selectedWeight,
    ));
  }

  void updateProfessionalDetails(ProfessionalInfoState professionalInfoState) {
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
            education: professionalInfoState.education,
            occupation: professionalInfoState.occupation,
            employedType: professionalInfoState.employedIn,
            citizenShip: professionalInfoState.citizenship,
            annualIncomeCurrency: professionalInfoState.currencyType,
            annualIncome: professionalInfoState.annualIncome));
  }

  void updatePartnerBasicDetails(
      EditPartnerPreferenceState editPartnerPreferenceState) {
    state = state.copyWith(
        userPartnerDetails: state.userPartnerDetails.copyWith(
            partnerFromAge: int.tryParse(editPartnerPreferenceState.fromAge),
            partnerToAge: int.tryParse(editPartnerPreferenceState.toAge),
            partnerToHeight: editPartnerPreferenceState.toHeight,
            partnerFromHeight: editPartnerPreferenceState.fromHeight,
            partnerToWeight: int.tryParse(editPartnerPreferenceState.toWeight),
            partnerFromWeight:
                int.tryParse(editPartnerPreferenceState.fromWeight),
            partnerMaritalStatus: editPartnerPreferenceState.maritalStatus,
            partnerPhysicalStatus: editPartnerPreferenceState.physicalStatus,
            partnerMotherTongue: editPartnerPreferenceState.motherTongue));
  }

  void updatePartnerProfessionalDetails(
      EditPartnerPreferenceState editPartnerPreferenceState) {
    state = state.copyWith(
        userPartnerDetails: state.userPartnerDetails.copyWith(
            partnerProfession: editPartnerPreferenceState.occupation,
            partnerOccupation: editPartnerPreferenceState.occupation,
            partnerAnnualIncome: editPartnerPreferenceState.annulIncome,
            partnerEmployedIn: editPartnerPreferenceState.employmentType,
            partnerEducation: editPartnerPreferenceState.education));
  }

  void updatePartnerLifeStyleDetails(
      EditPartnerPreferenceState editPartnerPreferenceState) {
    state = state.copyWith(
        userPartnerDetails: state.userPartnerDetails.copyWith(
            partnerEatingHabits: editPartnerPreferenceState.eatingHabits,
            partnerSmokingHabits: editPartnerPreferenceState.smokingHabits,
            partnerDrinkingHabits: editPartnerPreferenceState.drinkingHabits));
  }

  void updatePartnerReligiousDetails(
      EditPartnerPreferenceState editPartnerPreferenceState) {
    state = state.copyWith(
        userPartnerDetails: state.userPartnerDetails.copyWith(
            partnerCaste: editPartnerPreferenceState.caste,
            partnerReligion: editPartnerPreferenceState.religion,
            partnerSubcaste: editPartnerPreferenceState.subCaste,
            partnerRassi: editPartnerPreferenceState.raasi,
            partnerStar: editPartnerPreferenceState.star));
  }

  void updatePartnerLocationDetails(
      EditPartnerPreferenceState editPartnerPreferenceState) {
    state = state.copyWith(
        userPartnerDetails: state.userPartnerDetails.copyWith(
            partnerCountry: editPartnerPreferenceState.country,
            partnerState: editPartnerPreferenceState.state,
            partnerCity: editPartnerPreferenceState.city,
            partnerOwnHouse: editPartnerPreferenceState.isOwnHouse != null
                ? editPartnerPreferenceState.isOwnHouse!
                    ? 'true'
                    : 'false'
                : state.userPartnerDetails.partnerOwnHouse));
  }

  int calculateAge(DateTime? dateOfBirth) {
    if (dateOfBirth != null) {
      final DateTime now = DateTime.now();
      int calculatedAge = now.year - dateOfBirth.year;

      if (now.month < dateOfBirth.month ||
          (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
        calculatedAge--;
      }
      return calculatedAge;
    }
    return 0;
  }

  void updateImage(List<String>? images) {
    state =
        state.copyWith(userDetails: state.userDetails.copyWith(images: images));
  }

  Future<void> getLocalData() async {
    getAllCountryLocal();
    getAllStateLocal();
    getAllCityLocal();
    getAllReligionLocal();
    getAllCasteLocal();
    getAllSubcasteLocal();
  }

  Future<void> getAllCountryLocal() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('country') == null) {
      final response = await http.get(Uri.parse(Api.getallCountry));
      if (response.statusCode == 200) {
        await prefs.setString('country', response.body);
        // final jsonData = json.decode(response.body) as List;
      }
    }
  }

  Future<void> getAllStateLocal() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('state') == null) {
      final response = await http.get(Uri.parse(Api.getAllState));
      if (response.statusCode == 200) {
        await prefs.setString('state', response.body);
        // final jsonData = json.decode(response.body) as List;
      }
    }
  }

  Future<void> getAllCityLocal() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('city') == null) {
      final response = await http.get(Uri.parse(Api.getAllCity));
      if (response.statusCode == 200) {
        await prefs.setString('city', response.body);
        // final jsonData = json.decode(response.body) as List;
      }
    }
  }

  Future<void> getAllReligionLocal() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('religion') == null) {
      final response = await http.get(Uri.parse(Api.getAllReligion));
      if (response.statusCode == 200) {
        await prefs.setString('religion', response.body);
        // final jsonData = json.decode(response.body) as List;
      }
    }
  }

  Future<void> getAllCasteLocal() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('caste') == null) {
      final response = await http.get(Uri.parse(Api.getAllCaste));
      if (response.statusCode == 200) {
        await prefs.setString('caste', response.body);
        // final jsonData = json.decode(response.body) as List;
      }
    }
  }

  Future<void> getAllSubcasteLocal() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('subcaste') == null) {
      final response = await http.get(Uri.parse(Api.getAllSubCaste));
      if (response.statusCode == 200) {
        await prefs.setString('subcaste', response.body);
        // final jsonData = json.decode(response.body) as List;
      }
    }
  }

  void updateYourSelf(String? familyStatus, String? yourSelf) {
    state = state.copyWith(
        userDetails: state.userDetails
            .copyWith(familyStatus: familyStatus, aboutYourSelf: yourSelf));
  }

  void updateGovtProof(String? govtIdProof, String? idImage) {
    state = state.copyWith(
        userDetails: state.userDetails
            .copyWith(govtIdProof: govtIdProof, idImage: idImage));
  }

  void updateHoroscopeDetails(HoroscopeState horoscopeState) {
    state = state.copyWith(
        userDetails: state.userDetails.copyWith(
            timeOfBirth: horoscopeState.timeOfBirth,
            stateOfBirth: horoscopeState.birthState,
            countryOfBirth: horoscopeState.birthCountry,
            cityOfBirth: horoscopeState.birthCity,
            dob: horoscopeState.dateOfBirth));
  }
}
