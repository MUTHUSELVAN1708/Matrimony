import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:equatable/equatable.dart';

class UserImageModel extends Equatable {
  final int id;
  final int userId;
  final List<String> images;

  const UserImageModel({
    required this.id,
    required this.userId,
    required this.images,
  });

  factory UserImageModel.fromJson(Map<String, dynamic> json) {
    return UserImageModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      images: List<String>.from(json['images'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'images': images,
    };
  }

  UserImageModel copyWith({
    int? id,
    int? userId,
    List<String>? images,
  }) {
    return UserImageModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      images: images ?? this.images,
    );
  }

  @override
  List<Object?> get props => [id, userId, images];
}

class GetImageState {
  final bool isLoading;
  final String? error;
  final UserImageModel? data;

  GetImageState({
    this.isLoading = false,
    this.error,
    this.data,
  });

  GetImageState copyWith({
    bool? isLoading,
    String? error,
    UserImageModel? data,
  }) {
    return GetImageState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class GetImageApiNotifier extends StateNotifier<GetImageState> {
  GetImageApiNotifier() : super(GetImageState());

  Future<void> getImage() async {
    state = state.copyWith(isLoading: true, error: null, data: null);
    try {
      final int? userId = await SharedPrefHelper.getUserId();
      final response = await http.post(
        Uri.parse(Api.getUserImage),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final userImageData = UserImageModel.fromJson(jsonResponse);

        state = state.copyWith(
          isLoading: false,
          data: userImageData,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to retrieve image: ${response.reasonPhrase}',
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

final getImageApiProvider =
    StateNotifierProvider<GetImageApiNotifier, GetImageState>((ref) {
  return GetImageApiNotifier();
});
