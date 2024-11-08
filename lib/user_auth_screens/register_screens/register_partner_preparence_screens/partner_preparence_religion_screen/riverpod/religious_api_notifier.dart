import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:matrimony/common/api_list.dart';

class ReligiousModel extends Equatable {
  final int id;
  final String religion;

  const ReligiousModel({required this.id, required this.religion});

  ReligiousModel copyWith({int? id, String? religion}) {
    return ReligiousModel(
      id: id ?? this.id,
      religion: religion ?? this.religion,
    );
  }

  factory ReligiousModel.fromJson(Map<String, dynamic> json) {
    return ReligiousModel(
      id: json['id'] as int,
      religion: json['religion'] as String,
    );
  }

  @override
  List<Object?> get props => [id, religion];
}

// Modify ReligiousState to use a list of ReligiousModel
class ReligiousState extends Equatable {
  final bool isLoading;
  final List<ReligiousModel>? data;
  final String? errorMessage;

  const ReligiousState({
    this.isLoading = false,
    this.data ,
    this.errorMessage,
  });

  ReligiousState copyWith({
    bool? isLoading,
    List<ReligiousModel>? data,
    String? errorMessage,
  }) {
    return ReligiousState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];
}

class ReligiousNotifier extends StateNotifier<ReligiousState> {
  ReligiousNotifier() : super(const ReligiousState());

  Future<void> getReligiousData() async {
    state = state.copyWith(isLoading: true);

    try {
      final response = await http.get(Uri.parse(Api.getReligious));
      print(response.statusCode);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List;
        print(jsonData);

        final religiousData = jsonData
            .map((item) => ReligiousModel.fromJson(item))
            .toList();
        print('_________');
        print(religiousData);

        state = state.copyWith(isLoading: false, data: religiousData);
      } else {
        throw Exception('Failed to load religious data');
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: error.toString(),
      );
    }
  }


}

final religiousProvider = StateNotifierProvider<ReligiousNotifier, ReligiousState>(
  (ref) => ReligiousNotifier(),
);
