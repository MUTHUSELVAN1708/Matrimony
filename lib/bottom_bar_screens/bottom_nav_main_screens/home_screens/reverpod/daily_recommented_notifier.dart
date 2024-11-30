import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DailyRecommend extends Equatable {
  final int? userId;
  final String? name;
  final int? age;
  final List<String> images;
  final String? uniqueId;
  final String? occupation;
  final String? caste;
  final String? state;
  final String? city;

  const DailyRecommend({
    this.userId,
    this.name,
    this.age,
    this.images = const [],
    this.uniqueId,
    this.occupation,
    this.caste,
    this.state,
    this.city,
  });

  /// Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'age': age,
      'images': images,
      'uniqueId': uniqueId,
      'occupation': occupation,
      'caste': caste,
      'state': state,
      'city': city,
    };
  }

  /// Factory method to create an instance from JSON
  factory DailyRecommend.fromJson(Map<String, dynamic> json) {
    return DailyRecommend(
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      images: (json['images'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      uniqueId: json['uniqueId'] as String?,
      occupation: json['occupation'] as String?,
      caste: json['caste'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
    );
  }

  @override
  List<Object?> get props =>
      [userId, name, age, images, uniqueId, occupation, caste, state, city];
}

class DailyRecommendState extends Equatable {
  final bool isLoading;
  final List<DailyRecommend> dailyRecommendList;
  final String? error;

  const DailyRecommendState({
    this.isLoading = false,
    this.dailyRecommendList = const [],
    this.error,
  });

  DailyRecommendState copyWith({
    bool? isLoading,
    List<DailyRecommend>? dailyRecommendList,
    String? error,
  }) {
    return DailyRecommendState(
      isLoading: isLoading ?? this.isLoading,
      dailyRecommendList: dailyRecommendList ?? this.dailyRecommendList,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, dailyRecommendList, error];
}

class DailyRecommendNotifier extends StateNotifier<DailyRecommendState> {
  DailyRecommendNotifier() : super(const DailyRecommendState());

  Future<void> fetchDailyRecommendations() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

      if (userId == null) {
        throw Exception("User ID is null. Please log in again.");
      }

      final response = await http.post(
        Uri.parse(Api.dailyRecommented),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({"userId": userId}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<DailyRecommend> recommendations = data
            .map(
                (item) => DailyRecommend.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(
            isLoading: false, dailyRecommendList: recommendations);
      } else {
        // final errorResponse = jsonDecode(response.body);
        // final errorMessage =
        //     errorResponse['message'] ?? 'Unknown error occurred';
        state = state.copyWith(
          isLoading: false,
          error: 'No Recommendations Available.',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'No Recommendations Available.',
      );
    }
  }
}

final dailyRecommendProvider =
    StateNotifierProvider<DailyRecommendNotifier, DailyRecommendState>(
  (ref) => DailyRecommendNotifier(),
);
