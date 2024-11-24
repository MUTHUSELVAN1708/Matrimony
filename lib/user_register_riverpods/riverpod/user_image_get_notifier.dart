import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:equatable/equatable.dart';

class UserImageModel extends Equatable {
  final String uniqueId;
  final List<String> images;
  final bool paymentStatus;
  final String name;

  const UserImageModel({
    required this.paymentStatus,
    required this.name,
    required this.uniqueId,
    required this.images,
  });

  factory UserImageModel.fromJson(Map<String, dynamic> json) {
    return UserImageModel(
        uniqueId: json['uniqueId'] as String,
        images: List<String>.from(json['images'] as List<dynamic>),
        paymentStatus: json['paymentStatus'] as bool,
        name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'uniqueId': uniqueId,
      'images': images,
      'paymentStatus': paymentStatus,
      'name': name
    };
  }

  UserImageModel copyWith({
    String? uniqueId,
    List<String>? images,
    bool? paymentStatus,
    String? name,
  }) {
    return UserImageModel(
      uniqueId: uniqueId ?? this.uniqueId,
      images: images ?? this.images,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [uniqueId, images, paymentStatus, name];
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
