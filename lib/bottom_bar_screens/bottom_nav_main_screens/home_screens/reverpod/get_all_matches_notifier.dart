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
  final List<String>? images;
  final String? uniqueId;
  final String? occupation;
  final String? caste;
  final String? state;
  final String? city;

  const Matches({this.id, this.name, this.age, this.images,this.uniqueId,this.occupation,this.caste,this.state,this.city});

  Map<String, dynamic> toJson() {
    return {
      'userId': id,
      'name': name,
      'age': age,
      'images': images,
      'uniqueId': uniqueId,
      'city': city,
      'state': state,
      'occupation' : occupation,
      'caste': caste,
    };
  }

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      id: json['userId'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
        images: (json['images'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList(),
      occupation: json['occupation'] as String?,
      caste: json['caste'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      uniqueId: json['uniqueId'] as String?
    );
  }

  @override
  List<Object?> get props => [id, name, age, images,occupation,caste,state,city,uniqueId];
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
