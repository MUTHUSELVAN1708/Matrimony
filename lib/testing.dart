import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllMatchState1 extends Equatable {
  final bool isLoading;
  final Map<String, dynamic>? allMatchList;
  final String? error;

  const AllMatchState1({
    this.isLoading = false,
    this.allMatchList,
    this.error,
  });

  AllMatchState1 copyWith({
    bool? isLoading,
    Map<String, dynamic>? allMatchList,
    String? error,
  }) {
    return AllMatchState1(
      isLoading: isLoading ?? this.isLoading,
      allMatchList: allMatchList ?? this.allMatchList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, allMatchList, error];
}

class AllMatchesNotifier extends StateNotifier<AllMatchState1> {
  AllMatchesNotifier() : super(const AllMatchState1());

  Future<void> allMatchDataFetch() async {
    state = state.copyWith(isLoading: true);

    try {
      final int userId = await SharedPrefHelper.getUserId() ?? 1;
      print('______________');

      final response = await http.post(
        Uri.parse(Api.getAllMatches),
        headers: {
          'Content-Type': 'application/json',
          'AppId': '1',
        },
        body: jsonEncode({
          "userId": userId,
        }),
      );
      print('______________');
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        state = state.copyWith(isLoading: false, allMatchList: data);
        print(data);
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

final allMatchesProvider =
    StateNotifierProvider<AllMatchesNotifier, AllMatchState1>(
  (ref) => AllMatchesNotifier(),
);
