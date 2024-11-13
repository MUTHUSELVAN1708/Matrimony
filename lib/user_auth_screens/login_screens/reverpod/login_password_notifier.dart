import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:matrimony/user_register_riverpods/riverpod/user_image_get_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'package:equatable/equatable.dart';

class LogUserModel extends Equatable {
  final String token;
  final String email;
  final String phoneNumber;
  final String role;
  final int id;

  const LogUserModel({
    required this.token,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.id,
  });

  factory LogUserModel.fromJson(Map<String, dynamic> json) {
    return LogUserModel(
      token: json['token'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      role: json['role'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'email': email,
      'phoneNumber': phoneNumber,
      'role': role,
      'id': id,
    };
  }

  LogUserModel copyWith({
    String? token,
    String? email,
    String? phoneNumber,
    String? role,
    int? id,
  }) {
    return LogUserModel(
      token: token ?? this.token,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [token, email, phoneNumber, role, id];
}

class LoginState {
  final bool isLoading;
  final String? error;
  final LogUserModel? data;
  final String? mobileNo;

  LoginState({this.isLoading = false, this.error, this.data, this.mobileNo});

  LoginState copyWith(
      {bool? isLoading, String? error, LogUserModel? data, String? mobileNo}) {
    return LoginState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        data: data ?? this.data,
        mobileNo: mobileNo ?? this.mobileNo);
  }
}

class LogStateNotifier extends StateNotifier<LoginState> {
  LogStateNotifier() : super(LoginState());

  Future<LogUserModel> passwordWithLogin(String password, String email) async {
    state = state.copyWith(isLoading: true, error: null, data: null);
    try {
      final response = await http.post(
        Uri.parse(Api.passwordWithLogin),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'password': password,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userImageData = LogUserModel.fromJson(jsonResponse);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', userImageData.token);
        await prefs.setInt('userId', userImageData.id);

        print(userImageData.toJson());
        state = state.copyWith(
          isLoading: false,
          data: userImageData,
        );

        return userImageData;
      } else if (response.statusCode == 400) {
        state = state.copyWith(
          isLoading: false,
          error: json.decode(response.body)['errorMessage'],
        );
        return LogUserModel(
            id: 1, email: '', phoneNumber: '', role: '', token: '');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return LogUserModel(
          id: 1, email: '', phoneNumber: '', role: '', token: '');
    }
    return LogUserModel(id: 1, email: '', phoneNumber: '', role: '', token: '');
  }

  Future<LogUserModel> otpWithLogin(String phoneNo, String no) async {
    state = state.copyWith(isLoading: true, error: null, data: null);
    if (no.length != 10) {
      state = state.copyWith(
        isLoading: false,
        error: 'Please Enter mobile number correctly',
      );
      return const LogUserModel(
          id: 1, email: '', phoneNumber: '', role: '', token: '');
    }
    try {
      final response = await http.post(
        Uri.parse(Api.otpWithLogin),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'phoneNumber': phoneNo,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userImageData = LogUserModel.fromJson(jsonResponse);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', userImageData.token);
        await prefs.setInt('userId', userImageData.id);

        print(userImageData.toJson());
        state = state.copyWith(
          isLoading: false,
          data: userImageData,
        );

        return userImageData;
      } else if (response.statusCode == 400) {
        state = state.copyWith(
          isLoading: false,
          error: json.decode(response.body)['errorMessage'],
        );
        return const LogUserModel(
            id: 1, email: '', phoneNumber: '', role: '', token: '');
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return const LogUserModel(
          id: 1, email: '', phoneNumber: '', role: '', token: '');
    }
    return const LogUserModel(
        id: 1, email: '', phoneNumber: '', role: '', token: '');
  }

  void updatePhoneNo(String mobileNo) {
    state = state.copyWith(mobileNo: mobileNo);
  }

  void clearPhoneNo() {
    state = LoginState(
        isLoading: state.isLoading,
        data: state.data,
        error: state.error,
        mobileNo: null);
  }
}

final logApiProvider =
    StateNotifierProvider<LogStateNotifier, LoginState>((ref) {
  return LogStateNotifier();
});
