import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';

class ImageApiState<T> {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  ImageApiState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  ImageApiState<T> copyWith({
    bool? isLoading,
    String? error,
    String? successMessage,
  }) {
    return ImageApiState<T>(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}

class UploadImageApiNotifier<T> extends StateNotifier<ImageApiState<T>> {
  UploadImageApiNotifier() : super(ImageApiState<T>());

  Future<void> uploadPhoto(List<String> base64Image) async {
    state = state.copyWith(isLoading: true, error: null, successMessage: null);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.createUploadPhoto),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({'userId': userId, 'images': base64Image}),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(
          isLoading: false,
          successMessage: "Image uploaded successfully!",
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to upload image: ${response.reasonPhrase}',
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

final imageRegisterApiProvider =
    StateNotifierProvider<UploadImageApiNotifier<void>, ImageApiState<void>>(
        (ref) {
  return UploadImageApiNotifier<void>();
});
