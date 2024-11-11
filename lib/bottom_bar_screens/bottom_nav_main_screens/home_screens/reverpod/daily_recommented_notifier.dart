import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:equatable/equatable.dart';

class DailyRecomment extends Equatable {
  final int? id;
  final String? name;
  final int? age;
  final List<String>? photos;

  const DailyRecomment({
    this.id,
    this.name,
    this.age,
    this.photos,
  });

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? 0,
      'name': name ?? '',
      'age': age ?? 0,
      'photos': photos ?? [],
    };
  }

  factory DailyRecomment.fromJson(Map<String, dynamic> json) {
    return DailyRecomment(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [], // Return an empty list if photos is null
    );
  }

  @override
  List<Object?> get props => [name, photos, age];
}

class dailyRecommentState extends Equatable {
  final bool isLoading;
  final List<DailyRecomment>? dailyRecommentList;
  final String? error;

  const dailyRecommentState({
    this.isLoading = false,
    this.dailyRecommentList,
    this.error,
  });

  dailyRecommentState copyWith({
    bool? isLoading,
    List<DailyRecomment>? dailyRecommentList,
    String? error,
  }) {
    return dailyRecommentState(
      isLoading: isLoading ?? this.isLoading,
      dailyRecommentList: dailyRecommentList ?? this.dailyRecommentList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, dailyRecommentList, error];
}

class dailyRecommentNotifier extends StateNotifier<dailyRecommentState> {
  dailyRecommentNotifier() : super(const dailyRecommentState());

  Future<void> dailyRecommentFetchData() async {
    state = state.copyWith(isLoading: true);

    try {
      final int userId = await SharedPrefHelper.getUserId() ?? 1;

      final response = await http.post(
        Uri.parse(Api.dailyRecommented),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          "userId": 3,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        final List<DailyRecomment> dailyRecommentList = data.map((item) {
          return DailyRecomment.fromJson(item as Map<String, dynamic>);
        }).toList();

        state = state.copyWith(
            isLoading: false, dailyRecommentList: dailyRecommentList);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'No Daily Recommendation Available',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'An error occurred: $e',
      );
    }
  }
}

final dailyRecommentProvider =
    StateNotifierProvider<dailyRecommentNotifier, dailyRecommentState>(
  (ref) => dailyRecommentNotifier(),
);
