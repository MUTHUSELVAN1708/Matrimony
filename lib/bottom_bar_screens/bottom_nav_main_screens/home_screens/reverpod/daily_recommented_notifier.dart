import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Matches Model
class dailyRecomment extends Equatable {
  final int? id;
  final String? name;
  final List<String>? image;
  final String? age;

  const dailyRecomment({this.id, this.name, this.image, this.age});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'age': age,
    };
  }

  factory dailyRecomment.fromJson(Map<String, dynamic> json) {
    return dailyRecomment(
      id: json['id'] as int,
      name: json['name'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      age: json['age'] as String?,
    );
  }

  @override
  List<Object?> get props => [name, image, age];
}

class dailyRecommentState extends Equatable {
  final bool isLoading;
  final List<dailyRecomment>? dailyRecommentList;
  final String? error;

  const dailyRecommentState({
    this.isLoading = false,
    this.dailyRecommentList,
    this.error,
  });

  dailyRecommentState copyWith({
    bool? isLoading,
    List<dailyRecomment>? dailyRecommentList,
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
      print('Fetching data for user ID: $userId');

      final response = await http.post(
        Uri.parse(Api.dailyRecommented),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          "userId": userId,
        }),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body.length);
        final data = jsonDecode(response.body) as List<dynamic>;
        print(data.length);
        final List<dailyRecomment> dailyRecommentList = data.map((item) {
          return dailyRecomment.fromJson(item as Map<String, dynamic>);
        }).toList();
        print(dailyRecommentList.length);

        state = state.copyWith(
            isLoading: false, dailyRecommentList: dailyRecommentList);
        print('Fetched matches: $dailyRecommentList');
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to fetch data. Status code: ${response.statusCode}',
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
