import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GovernmentProofApiState<T> {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  GovernmentProofApiState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  GovernmentProofApiState<T> copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return GovernmentProofApiState<T>(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

class GovernmentProofApiNotifier<T> extends StateNotifier<GovernmentProofApiState<T>> {
  GovernmentProofApiNotifier() : super(GovernmentProofApiState<T>());
    Future<void> _saveUserData(String token) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', token);
    await prefs.setString('token', token);
  }

  Future<void> uploadGovernmentProofApi({
  String? govtIdProof, 
  String? idImage,  
  }) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.createUploadGovernmentProof),  
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          'userId': userId,
          'govtIdProof': govtIdProof,  
          'idImage': idImage,        
        }),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(
          isLoading: false,
          successMessage: "Government proof uploaded successfully!",
        );
        final responseData = jsonDecode(response.body);
        _saveUserData(responseData.data['token']);
        
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to upload proof: ${response.reasonPhrase}',
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

final governmentProofApiProvider = StateNotifierProvider<GovernmentProofApiNotifier<void>, GovernmentProofApiState<void>>((ref) {
  return GovernmentProofApiNotifier<void>();
});
