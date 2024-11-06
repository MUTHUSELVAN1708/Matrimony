import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerState {
  final bool isLoading1;
  final bool isLoading2;
  final bool isLoading3;
  final String? imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final String? error1;
  final String? error2;
  final String? error3;

  ImagePickerState({
    this.isLoading1 = false,
    this.isLoading2 = false,
    this.isLoading3 = false,
    this.imageUrl1,
    this.imageUrl2,
    this.imageUrl3,
    this.error1,
    this.error2,
    this.error3,
  });

  ImagePickerState copyWith({
    bool? isLoading1,
    bool? isLoading2,
    bool? isLoading3,
    String? imageUrl1,
    String? imageUrl2,
    String? imageUrl3,
    String? error1,
    String? error2,
    String? error3,
  }) {
    return ImagePickerState(
      isLoading1: isLoading1 ?? this.isLoading1,
      isLoading2: isLoading2 ?? this.isLoading2,
      isLoading3: isLoading3 ?? this.isLoading3,
      imageUrl1: imageUrl1 ?? this.imageUrl1,
      imageUrl2: imageUrl2 ?? this.imageUrl2,
      imageUrl3: imageUrl3 ?? this.imageUrl3,
      error1: error1 ?? this.error1,
      error2: error2 ?? this.error2,
      error3: error3 ?? this.error3,
    );
  }
}

class ImagePickerNotifier extends StateNotifier<ImagePickerState> {
  ImagePickerNotifier() : super(ImagePickerState());

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage1() async {
    state = state.copyWith(isLoading1: true);
    await _pickImageAndUpdateState(
      pickImage: _pickAndConvertImage(),
      updateState: (imageUrl) =>
          state.copyWith(imageUrl1: imageUrl, isLoading1: false),
      errorState: (error) => state.copyWith(error1: error, isLoading1: false),
    );
  }

  Future<void> pickImage2() async {
    state = state.copyWith(isLoading2: true);
    await _pickImageAndUpdateState(
      pickImage: _pickAndConvertImage(),
      updateState: (imageUrl) =>
          state.copyWith(imageUrl2: imageUrl, isLoading2: false),
      errorState: (error) => state.copyWith(error2: error, isLoading2: false),
    );
  }

  Future<void> pickImage3() async {
    state = state.copyWith(isLoading3: true);
    await _pickImageAndUpdateState(
      pickImage: _pickAndConvertImage(),
      updateState: (imageUrl) =>
          state.copyWith(imageUrl3: imageUrl, isLoading3: false),
      errorState: (error) => state.copyWith(error3: error, isLoading3: false),
    );
  }

  Future<void> _pickImageAndUpdateState({
    required Future<String?> pickImage,
    required ImagePickerState Function(String?) updateState,
    required ImagePickerState Function(String) errorState,
  }) async {
    try {
      final pickedImage = await pickImage;
      if (pickedImage != null) {
        state = updateState(pickedImage);
      } else {
        throw Exception('Image not selected');
      }
    } catch (e) {
      state = errorState(e.toString());
    }
  }

  Future<String?> _pickAndConvertImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    print(image);
    if (image != null) {
      print("entered converter");

      if (kIsWeb) {
        final Uint8List bytes =
            await image.readAsBytes(); // Use image.readAsBytes() directly
        final base64String = base64Encode(bytes);
        print(base64String);
        return base64String;
      } else {
        final File imageFile = File(image.path);
        print("Image file path: ${imageFile.path}");
        final bytes = await imageFile.readAsBytes();
        print(bytes);
        final base64String = base64Encode(bytes);
        print(base64String);
        return base64String;
      }
    }
    return null;
  }
}

// Provider
final imagePickerProvider =
    StateNotifierProvider<ImagePickerNotifier, ImagePickerState>((ref) {
  return ImagePickerNotifier();
});
