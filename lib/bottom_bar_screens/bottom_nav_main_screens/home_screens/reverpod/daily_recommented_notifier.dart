import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:matrimony/models/success_story.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final List<SuccessStory> successStories;
  final String? error;

  const DailyRecommendState({
    this.isLoading = false,
    this.dailyRecommendList = const [],
    this.successStories = const [],
    this.error,
  });

  DailyRecommendState copyWith({
    bool? isLoading,
    List<DailyRecommend>? dailyRecommendList,
    List<SuccessStory>? successStories,
    String? error,
  }) {
    return DailyRecommendState(
      isLoading: isLoading ?? this.isLoading,
      dailyRecommendList: dailyRecommendList ?? this.dailyRecommendList,
      successStories: successStories ?? this.successStories,
      error: error,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, dailyRecommendList, error, successStories];
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

  Future<void> fetchSuccessStories() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastFetchTime = prefs.getString('lastSuccessStoryFetchTime');
      DateTime lastFetchDateTime = lastFetchTime != null
          ? DateTime.parse(lastFetchTime)
          : DateTime(2000, 1, 1);

      final now = DateTime.now();

      final localData = prefs.getString('successStories');
      if (now.difference(lastFetchDateTime).inDays < 1 &&
          now.day == lastFetchDateTime.day &&
          localData != null) {
        final List<dynamic> data = jsonDecode(localData);
        final List<SuccessStory> successStories = data
            .map((item) => SuccessStory.fromJson(item as Map<String, dynamic>))
            .toList();
        state = state.copyWith(successStories: successStories);
        return;
      }

      final response = await http.post(
        Uri.parse(Api.successStory),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        final List<SuccessStory> successStories = data
            .map((item) => SuccessStory.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(successStories: successStories);

        await prefs.setString(
          'successStories',
          jsonEncode(successStories.map((e) => e.toJson()).toList()),
        );
        await prefs.setString(
            'lastSuccessStoryFetchTime', now.toIso8601String());
      } else {
        throw Exception('Failed to fetch success stories.');
      }
    } catch (e) {
      print('Error fetching success stories: $e');
    }
  }
}

final dailyRecommendProvider =
    StateNotifierProvider<DailyRecommendNotifier, DailyRecommendState>(
  (ref) => DailyRecommendNotifier(),
);
