import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/user_register_riverpods/service/register_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterState {
  final bool isLoading;
  final String? error;
  final String? success;

  RegisterState({required this.isLoading, this.error, this.success});
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  return RegisterNotifier(RegisterService());
});

class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterService _service;

  RegisterNotifier(this._service)
      : super(RegisterState(isLoading: false, error: null, success: null));

  String? profileFor;
  String? name;
  String? email;
  String? password;
  String? phoneNumber;
  String? otp;
  String? phoneNo;

  Future<bool> register() async {
    state = RegisterState(isLoading: true, error: null, success: null);

    if (profileFor == null ||
        name == null ||
        email == null ||
        password == null ||
        phoneNumber == null) {
      state = RegisterState(
          isLoading: false, error: 'Please fill all fields.', success: null);
      return false;
    }

    try {
      final response = await _service.registerApi(
        profileFor!,
        name!,
        email!,
        password!,
        phoneNumber!,
      );

      if (response != null && response['errorMessage'] == '') {
        await _saveUserData(response['userId']);
        state = RegisterState(
            isLoading: false, error: null, success: 'Registration successful.');
        return true;
      } else {
        print(response?['errorMessage']);
        state = RegisterState(
            isLoading: false, error: response?['errorMessage'], success: null);
        return false;
      }
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<bool> otpVerification() async {
    state = RegisterState(isLoading: true, error: null, success: null);

    if (otp == null || phoneNo == null) {
      state = RegisterState(
          isLoading: false, error: 'Please fill all fields.', success: null);
      return false;
    }

    try {
      final response = await _service.otpVerificationApi(otp!, phoneNo!);

      state = RegisterState(
          isLoading: false,
          error: null,
          success: 'OTP verification successful.');
      return true;
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<bool> personalDetails({
    String? gender,
    String? dateOfBirth,
    int? age,
    String? height,
    String? weight,
    String? anyDisability,
    String? maritalStatus,
    String? noOfChildren,
  }) async {
    state = RegisterState(isLoading: true, error: null, success: null);

    if (gender == null ||
        dateOfBirth == null ||
        age == null ||
        height == null ||
        weight == null ||
        anyDisability == null ||
        maritalStatus == null) {
      state = RegisterState(
          isLoading: false, error: 'Please fill all fields.', success: null);
      return false;
    }

    try {
      await _service.personalDetailsApi(
        gender,
        dateOfBirth,
        age,
        height,
        weight,
        anyDisability,
        maritalStatus,
        noOfChildren,
      );

      state = RegisterState(
          isLoading: false,
          error: null,
          success: 'Personal details saved successfully.');
      return true;
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<bool> createReligionsApi({
    String? motherTongue,
    String? religion,
    String? caste,
    String? subCaste,
    String? division,
  }) async {
    state = RegisterState(isLoading: true, error: null, success: null);

    try {
      final response = await _service.religiousInformationsApi(
          motherTongue ?? '',
          religion ?? '',
          caste ?? '',
          subCaste ?? '',
          division ?? '');

      if (response != null) {
        state = RegisterState(
            isLoading: false,
            error: null,
            success: 'Religious information saved successfully.');
        return true;
      } else {
        state = RegisterState(
            isLoading: false,
            error: 'Invalid response from server.',
            success: null);
        return false;
      }
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<bool> createProfessionalApi({
    String? education,
    String? employedType,
    String? occupation,
    String? annualIncomeCurrency,
    String? annualIncome,
  }) async {
    state = RegisterState(isLoading: true, error: null, success: null);

    try {
      await _service.professionalInformation(
        education: education ?? '',
        employedType: employedType ?? '',
        occupation: occupation ?? '',
        annualIncomeCurrency: annualIncomeCurrency ?? '',
        annualIncome: annualIncome ?? '',
      );

      state = RegisterState(
          isLoading: false,
          error: null,
          success: 'Professional information saved successfully.');
      return true;
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<bool> createLocationApi({
    String? country,
    String? states,
    String? pincode,
    String? city,
    String? flatNumber,
    String? address,
  }) async {
    state = RegisterState(isLoading: true, error: null, success: null);

    try {
      await _service.LocationInformation(
        country: country,
        state: states,
        pincode: pincode,
        city: city,
        flatNumber: flatNumber,
        address: address,
      );

      state = RegisterState(
          isLoading: false,
          error: null,
          success: 'Location information saved successfully.');
      return true;
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<bool> addAdditionalApi({
    String? employefamilyStatus,
    String? aboutYourSelf,
  }) async {
    state = RegisterState(isLoading: true, error: null, success: null);

    try {
      await _service.createAddtionalInformation(
          aboutYourSelf: aboutYourSelf.toString(),
          familyStatus: employefamilyStatus.toString());

      state = RegisterState(
          isLoading: false,
          error: null,
          success: 'Additional information saved successfully.');
      return true;
    } catch (e) {
      state =
          RegisterState(isLoading: false, error: e.toString(), success: null);
      return false;
    }
  }

  Future<void> _saveUserData(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }
}
