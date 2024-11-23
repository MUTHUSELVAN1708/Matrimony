import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matrimony/common/api_list.dart';
import 'package:matrimony/common/local_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Matches Model
class Matches extends Equatable {
  final int? id;
  final String? name;
  final int? age;
  final List<String>? photos;

  const Matches({this.id, this.name, this.age, this.photos});

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'age': age,
      'photos': photos,
    };
  }

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      id: json['userId'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
    );
  }

  @override
  List<Object?> get props => [id, name, age, photos];
}

class AllMatchState extends Equatable {
  final bool isLoading;
  final List<Matches>? allMatchList;
  final String? error;

  const AllMatchState({
    this.isLoading = false,
    this.allMatchList,
    this.error,
  });

  AllMatchState copyWith({
    bool? isLoading,
    List<Matches>? allMatchList,
    String? error,
  }) {
    return AllMatchState(
      isLoading: isLoading ?? this.isLoading,
      allMatchList: allMatchList ?? this.allMatchList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, allMatchList, error];
}

class AllMatchesNotifier extends StateNotifier<AllMatchState> {
  AllMatchesNotifier() : super(const AllMatchState());

  Future<void> allMatchDataFetch() async {
    state = state.copyWith(isLoading: true);

    try {
      final int? userId = await SharedPrefHelper.getUserId();

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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;

        final List<Matches> matchList = data.map((item) {
          return Matches.fromJson(item as Map<String, dynamic>);
        }).toList();
        // if (matchList.isEmpty) {
        //   state = state.copyWith(
        //     isLoading: false,
        //     error: 'No Matches Available',
        //   );
        // } else {
        print('MatchList');
        print(matchList);
        state = state.copyWith(isLoading: false, allMatchList: matchList);
        // }
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'No Matches Available',
        );
      }
    } catch (e) {
      print(e);
      state = state.copyWith(
        isLoading: false,
        error: 'No Matches Available',
      );
    }
  }
}

final allMatchesProvider =
    StateNotifierProvider<AllMatchesNotifier, AllMatchState>(
  (ref) => AllMatchesNotifier(),
);
