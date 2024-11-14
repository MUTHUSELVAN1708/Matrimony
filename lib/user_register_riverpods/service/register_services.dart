import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterService {
  Future<Map<String, dynamic>?> registerApi(
    String profileFor,
    String name,
    String email,
    String password,
    String phoneNumber,
  ) async {
    try {
      print('Api triggered');
      final response = await http.post(
        Uri.parse(Api.createUser),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'profileFor': profileFor,
          'name': name,
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
        }),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Account Created');
        print(data['id']);
        return {'userId': data['id'], 'errorMessage': ''};
      } else if (response.statusCode == 400) {
        return {'errorMessage': jsonDecode(response.body)['errorMessage']};
      } else {
        return {'errorMessage': 'Something Went Wrong'};
      }
    } catch (e) {
      return {'errorMessage': 'Something Went Wrong'};
    }
  }

  Future<bool> otpVerificationApi(
    String otp,
    String phoneNo,
  ) async {
    final int? userId = await SharedPrefHelper.getUserId();
    final response = await http.post(
      Uri.parse(Api.otpVerify),
      headers: {
        'Content-Type': 'application/json',
        'AppId': "1",
        // 'token': token!,
      },
      body: jsonEncode({
        'id': userId,
        'otp': otp,
        'phoneNumber': phoneNo,
      }),
    );
    print("$otp,$phoneNo");
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
      print(response.statusCode);
    } else {
      return false;
    }
  }

  Future<bool> personalDetailsApi(
    String gender,
    String dateOfBirth,
    int age,
    String height,
    String weight,
    String anyDisability,
    String maritalStatus,
    String? noOfChildren,
  ) async {
    final int? userId = await SharedPrefHelper.getUserId();
    final response = await http.post(
      Uri.parse(Api.createPersonalDetails),
      headers: {
        'Content-Type': 'application/json',
        'AppId': "1",
      },
      body: jsonEncode({
        'userId': userId,
        'gender': gender,
        'dateOfBirth': dateOfBirth,
        'age': age,
        'height': height,
        'weight': weight,
        'anyDisability': anyDisability,
        'maritalStatus': maritalStatus,
        'noOfChildren': noOfChildren,
      }),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      return false;
      throw Exception('Failed to submit personal details: ${response.body}');
    }
  }

  Future<bool> religiousInformationsApi(
    String motherTongue,
    String religion,
    String caste,
    String subCaste,
    String division,
  ) async {
    final int? userId = await SharedPrefHelper.getUserId();
    final response = await http.post(
      Uri.parse(Api.createReligionsApi),
      headers: {
        'Content-Type': 'application/json',
        'AppId': "1",
      },
      body: jsonEncode({
        'userId': userId,
        'motherTongue': motherTongue,
        'religion': religion,
        'caste': caste,
        'subCaste': subCaste,
        'division': division,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> professionalInformation({
    required String education,
    required String employedType,
    required String occupation,
    required String annualIncomeCurrency,
    String? annualIncome,
  }) async {
    final int? userId = await SharedPrefHelper.getUserId();

    final response = await http.post(
      Uri.parse(Api.createProfessionalInformation),
      headers: {
        'Content-Type': 'application/json',
        'AppId': "1",
      },
      body: jsonEncode({
        'userId': userId,
        'education': education,
        'employedType': employedType,
        'occupation': occupation,
        'annualIncomeCurrency': annualIncomeCurrency,
        'annualIncome': annualIncome,
      }),
    );

    if (response.statusCode == 200) {
      return true;
      print(response.statusCode);
    } else {
      return false;
      throw Exception(
          'Failed to submit professional information: ${response.body}');
    }
  }

  Future<bool> LocationInformation({
    String? country,
    String? state,
    String? pincode,
    String? city,
    String? flatNumber,
    String? address,
    bool? ownHouse,
  }) async {
    final int? userId = await SharedPrefHelper.getUserId();
    final prefs = await SharedPreferences.getInstance();

    final response = await http.post(
      Uri.parse(Api.createLocationDetails),
      headers: {
        'Content-Type': 'application/json',
        'AppId': "1",
      },
      body: jsonEncode({
        'userId': userId,
        'country': country,
        'state': state,
        'pincode': pincode,
        'city': city,
        'flatNumber': flatNumber,
        'address': address,
        'ownHouse': ownHouse
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      prefs.setString('name', responseData['name']);
      prefs.setString('employedType', responseData['employedType']);
      prefs.setString('occupation', responseData['occupation']);
      prefs.setString('education', responseData['education']);
      prefs.setString('city', responseData['city']);
      return true;
      print(response.statusCode);
    } else {
      return false;
      throw Exception(
          'Failed to submit location information: ${response.body}');
    }
  }

  Future<bool> createAddtionalInformation({
    String? familyStatus,
    String? aboutYourSelf,
  }) async {
    final int? userId = await SharedPrefHelper.getUserId();

    final response = await http.post(
      Uri.parse(Api.createAddtionalInformation),
      headers: {
        'Content-Type': 'application/json',
        'AppId': "1",
      },
      body: jsonEncode({
        'userId': userId,
        'familyStatus': familyStatus,
        'aboutYourSelf': aboutYourSelf,
      }),
    );

    if (response.statusCode == 200) {
      return true;
      print('Successfully submitted information: ${response.statusCode}');
    } else {
      return false;
      throw Exception(
          'Failed to submit professional information: ${response.body}');
    }
  }
}
