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
      token: json['Token'] as String,
      email: json['Email'] as String,
      phoneNumber: json['PhoneNumber'] as String,
      role: json['role'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Token': token,
      'Email': email,
      'PhoneNumber': phoneNumber,
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

  LoginState({
    this.isLoading = false,
    this.error,
    this.data,
  });

  LoginState copyWith({
    bool? isLoading,
    String? error,
    LogUserModel? data,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
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
        await prefs.setString('Token', userImageData.token);
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
}

final logApiProvider =
    StateNotifierProvider<LogStateNotifier, LoginState>((ref) {
  return LogStateNotifier();
});
